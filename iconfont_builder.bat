@echo off
rem This file was created by pub v2.5.1.
rem Package: iconfont_builder
rem Version: 0.2.2
rem Executable: iconfont_builder
rem Script: main
dart "C:\Users\Natth\AppData\Roaming\Pub\Cache\global_packages\iconfont_builder\bin\main.dart.snapshot.dart2" %*

rem The VM exits with code 253 if the snapshot version is out-of-date.
rem If it is, we need to delete it and run "pub global" manually.
if not errorlevel 253 (
  exit /b %errorlevel%
)

pub global run iconfont_builder:main %*
