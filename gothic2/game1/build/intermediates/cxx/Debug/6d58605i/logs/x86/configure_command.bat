@echo off
"C:\\Users\\fatih\\AppData\\Local\\Android\\Sdk\\cmake\\3.22.1\\bin\\cmake.exe" ^
  "-HC:\\Users\\fatih\\AndroidStudioProjects\\gothic2\\app\\src\\main\\cpp" ^
  "-DCMAKE_SYSTEM_NAME=Android" ^
  "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ^
  "-DCMAKE_SYSTEM_VERSION=35" ^
  "-DANDROID_PLATFORM=android-35" ^
  "-DANDROID_ABI=x86" ^
  "-DCMAKE_ANDROID_ARCH_ABI=x86" ^
  "-DANDROID_NDK=C:\\Users\\fatih\\AppData\\Local\\Android\\Sdk\\ndk\\27.0.12077973" ^
  "-DCMAKE_ANDROID_NDK=C:\\Users\\fatih\\AppData\\Local\\Android\\Sdk\\ndk\\27.0.12077973" ^
  "-DCMAKE_TOOLCHAIN_FILE=C:\\Users\\fatih\\AppData\\Local\\Android\\Sdk\\ndk\\27.0.12077973\\build\\cmake\\android.toolchain.cmake" ^
  "-DCMAKE_MAKE_PROGRAM=C:\\Users\\fatih\\AppData\\Local\\Android\\Sdk\\cmake\\3.22.1\\bin\\ninja.exe" ^
  "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=C:\\Users\\fatih\\AndroidStudioProjects\\gothic2\\app\\build\\intermediates\\cxx\\Debug\\6d58605i\\obj\\x86" ^
  "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=C:\\Users\\fatih\\AndroidStudioProjects\\gothic2\\app\\build\\intermediates\\cxx\\Debug\\6d58605i\\obj\\x86" ^
  "-DCMAKE_BUILD_TYPE=Debug" ^
  "-DCMAKE_FIND_ROOT_PATH=C:\\Users\\fatih\\AndroidStudioProjects\\gothic2\\app\\.cxx\\Debug\\6d58605i\\prefab\\x86\\prefab" ^
  "-BC:\\Users\\fatih\\AndroidStudioProjects\\gothic2\\app\\.cxx\\Debug\\6d58605i\\x86" ^
  -GNinja
