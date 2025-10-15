From cb7b709afe693170ff73e268a2fb41cd6753105a Mon Sep 17 00:00:00 2001
From: microcai <microcaicai@gmail.com>
Date: Mon, 13 Jan 2025 20:53:19 +0800
Subject: [PATCH] fix build error

---
 cmake/cotire.cmake                        |  2 +-
 include/ThreadPool.h                      |  8 ++----
 include/VariantUtils.h                    | 35 +++++++++++++++++++++--
 src/core/document/NumericField.cpp        | 10 ++++++-
 src/core/search/FieldCacheImpl.cpp        |  2 +-
 src/core/store/MMapDirectory.cpp          |  2 +-
 src/core/util/FieldCacheSanityChecker.cpp |  2 +-
 src/core/util/FileUtils.cpp               |  8 ++----
 src/core/util/ThreadPool.cpp              | 10 ++-----
 src/test/search/QueryUtils.cpp            |  2 +-
 10 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/cmake/cotire.cmake b/cmake/cotire.cmake
index d855c1d..de045a7 100644
--- a/cmake/cotire.cmake
+++ b/cmake/cotire.cmake
@@ -39,7 +39,7 @@ if (NOT CMAKE_SCRIPT_MODE_FILE)
 endif()
 # we need the CMake variables CMAKE_SCRIPT_MODE_FILE and CMAKE_ARGV available since 2.8.5
 # we need APPEND_STRING option for set_property available since 2.8.6
-cmake_minimum_required(VERSION 2.8.6)
+cmake_minimum_required(VERSION 3.10)
 if (NOT CMAKE_SCRIPT_MODE_FILE)
 	cmake_policy(POP)
 endif()
diff --git a/include/ThreadPool.h b/include/ThreadPool.h
index dc6446f..82b4cac 100644
--- a/include/ThreadPool.h
+++ b/include/ThreadPool.h
@@ -14,7 +14,7 @@
 
 namespace Lucene {
 
-typedef boost::shared_ptr<boost::asio::io_service::work> workPtr;
+typedef boost::asio::executor_work_guard<boost::asio::io_context::executor_type> workPtr;
 
 /// A Future represents the result of an asynchronous computation. Methods are provided to check if the computation
 /// is complete, to wait for its completion, and to retrieve the result of the computation. The result can only be
@@ -51,9 +51,7 @@ public:
     LUCENE_CLASS(ThreadPool);
 
 protected:
-    boost::asio::io_service io_service;
-    workPtr work;
-    boost::thread_group threadGroup;
+    boost::asio::thread_pool io_service;
 
     static const int32_t THREADPOOL_SIZE;
 
@@ -64,7 +62,7 @@ public:
     template <typename FUNC>
     FuturePtr scheduleTask(FUNC func) {
         FuturePtr future(newInstance<Future>());
-        io_service.post(boost::bind(&ThreadPool::execute<FUNC>, this, func, future));
+        boost::asio::post(io_service, boost::bind(&ThreadPool::execute<FUNC>, this, func, future));
         return future;
     }
 
diff --git a/include/VariantUtils.h b/include/VariantUtils.h
index 1e6c243..6c59e96 100644
--- a/include/VariantUtils.h
+++ b/include/VariantUtils.h
@@ -43,8 +43,39 @@ public:
         return typeOf<VariantNull>(var);
     }
 
-    template <typename VAR>
-    static int32_t hashCode(VAR var) {
+    static int32_t hashCode(String var) {
+        return StringUtils::hashCode(var);
+    }
+
+    static int32_t hashCode(int32_t var) {
+        return var;
+    }
+
+    static int32_t hashCode(int64_t var) {
+        return var;
+    }
+    static int32_t hashCode(double var) {
+        int64_t longBits = MiscUtils::doubleToLongBits(var);
+        return (int32_t)(longBits ^ (longBits >> 32));
+    }
+
+    static int32_t hashCode(NumericValue var) {
+        return boost::apply_visitor([](auto _var){
+            return hashCode(_var);
+        },var);
+    }
+
+
+    template<typename T>
+    static int32_t hashCode(Collection<T> var) {
+        return var.hashCode();
+    }
+
+    static int32_t hashCode(LuceneObjectPtr var) {
+            return var->hashCode();
+    }
+
+    static int32_t hashCodeAny(boost::any var) {
         if (typeOf<String>(var)) {
             return StringUtils::hashCode(get<String>(var));
         }
diff --git a/src/core/document/NumericField.cpp b/src/core/document/NumericField.cpp
index da356a5..43969be 100644
--- a/src/core/document/NumericField.cpp
+++ b/src/core/document/NumericField.cpp
@@ -11,6 +11,12 @@
 #include "NumericTokenStream.h"
 #include "StringUtils.h"
 
+inline std::wostream& operator << (std::wostream& s, const boost::shared_ptr<Lucene::Reader>& reader)
+{
+    s << reader.get();
+    return s;
+}
+
 namespace Lucene {
 
 NumericField::NumericField(const String& name)
@@ -54,7 +60,9 @@ ReaderPtr NumericField::readerValue() {
 
 String NumericField::stringValue() {
     StringStream value;
-    value << fieldsData;
+    boost::apply_visitor([&](auto V){
+        value << V;
+    }, fieldsData);
     return value.str();
 }
 
diff --git a/src/core/search/FieldCacheImpl.cpp b/src/core/search/FieldCacheImpl.cpp
index aabcbff..26f1e28 100644
--- a/src/core/search/FieldCacheImpl.cpp
+++ b/src/core/search/FieldCacheImpl.cpp
@@ -131,7 +131,7 @@ bool Entry::equals(const LuceneObjectPtr& other) {
 }
 
 int32_t Entry::hashCode() {
-    return StringUtils::hashCode(field) ^ VariantUtils::hashCode(custom);
+    return StringUtils::hashCode(field) ^ VariantUtils::hashCodeAny(custom);
 }
 
 Cache::Cache(const FieldCachePtr& wrapper) {
diff --git a/src/core/util/FieldCacheSanityChecker.cpp b/src/core/util/FieldCacheSanityChecker.cpp
index afc326c..8c4cad3 100644
--- a/src/core/util/FieldCacheSanityChecker.cpp
+++ b/src/core/util/FieldCacheSanityChecker.cpp
@@ -53,7 +53,7 @@ Collection<InsanityPtr> FieldCacheSanityChecker::check(Collection<FieldCacheEntr
         }
 
         ReaderFieldPtr rf(newLucene<ReaderField>(item->getReaderKey(), item->getFieldName()));
-        int32_t valId = VariantUtils::hashCode(val);
+        int32_t valId = VariantUtils::hashCodeAny(val);
 
         // indirect mapping, so the MapOfSet will dedup identical valIds for us
         valIdToItems.put(valId, item);
diff --git a/src/core/util/ThreadPool.cpp b/src/core/util/ThreadPool.cpp
index c8dc10e..63ceef0 100644
--- a/src/core/util/ThreadPool.cpp
+++ b/src/core/util/ThreadPool.cpp
@@ -14,16 +14,12 @@ Future::~Future() {
 
 const int32_t ThreadPool::THREADPOOL_SIZE = 5;
 
-ThreadPool::ThreadPool() {
-    work.reset(new boost::asio::io_service::work(io_service));
-    for (int32_t i = 0; i < THREADPOOL_SIZE; ++i) {
-        threadGroup.create_thread(boost::bind(&boost::asio::io_service::run, &io_service));
-    }
+ThreadPool::ThreadPool()
+    : io_service(THREADPOOL_SIZE)
+{
 }
 
 ThreadPool::~ThreadPool() {
-    work.reset(); // stop all threads
-    threadGroup.join_all(); // wait for all competition
 }
 
 ThreadPoolPtr ThreadPool::getInstance() {
diff --git a/src/test/search/QueryUtils.cpp b/src/test/search/QueryUtils.cpp
index 42e4d57..b7e1e3a 100644
--- a/src/test/search/QueryUtils.cpp
+++ b/src/test/search/QueryUtils.cpp
@@ -251,7 +251,7 @@ public:
                     << (scorerDiff > maxDiff ? L"--> " : L"") << L"scorerScore2="
                     << scorerScore2 << L" scorerDiff=" << scorerDiff
                     << L"\n\thitCollector.doc=" << doc << L" score="
-                    << score << L"\n\t Scorer=" << scorer << L"\n\t Query="
+                    << score << L"\n\t Scorer=" << scorer.get() << L"\n\t Query="
                     << q->toString() + L"  " << L"\n\t Searcher=" + s->toString()
                     << L"\n\t Order=" << sbord.str() << L"\n\t Op="
                     << (op == skip_op ? L" skip()" : L" next()");
-- 
2.47.1

