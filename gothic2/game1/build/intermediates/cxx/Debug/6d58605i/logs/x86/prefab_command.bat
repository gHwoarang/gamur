@echo off
"C:\\Program Files\\Android\\Android Studio\\jbr\\bin\\java" ^
  --class-path ^
  "C:\\Users\\fatih\\.gradle\\caches\\modules-2\\files-2.1\\com.google.prefab\\cli\\2.1.0\\aa32fec809c44fa531f01dcfb739b5b3304d3050\\cli-2.1.0-all.jar" ^
  com.google.prefab.cli.AppKt ^
  --build-system ^
  cmake ^
  --platform ^
  android ^
  --abi ^
  x86 ^
  --os-version ^
  35 ^
  --stl ^
  c++_static ^
  --ndk-version ^
  27 ^
  --output ^
  "C:\\Users\\fatih\\AppData\\Local\\Temp\\agp-prefab-staging12929027612243643635\\staged-cli-output" ^
  "C:\\Users\\fatih\\.gradle\\caches\\8.11.1\\transforms\\60ea8a5426b08163581c614940c798d3\\transformed\\games-activity-1.2.2\\prefab"
