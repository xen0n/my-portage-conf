From 23eac8d02385c082aa130da8784138e96532a5ce Mon Sep 17 00:00:00 2001
From: WANG Xuerui <xen0n@gentoo.org>
Date: Tue, 14 Jan 2025 11:41:36 +0800
Subject: [PATCH 2/2] Bump the minimum C++ standard to 14

---
 CMakeLists.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5c0fc02..0392f0e 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -46,8 +46,8 @@ include(dependencies)
 # build docs
 include(Lucene++Docs)
 
-# Enable C++11
-set(CMAKE_CXX_STANDARD 11)
+# C++14 is now required for the project
+set(CMAKE_CXX_STANDARD 14)
 set(CMAKE_CXX_STANDARD_REQUIRED ON)
 
 ####################################
-- 
2.48.1

