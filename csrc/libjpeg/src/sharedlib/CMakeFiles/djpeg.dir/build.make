# CMAKE generated file: DO NOT EDIT!
# Generated by "MSYS Makefiles" Generator, CMake Version 3.14

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /X/tools/cmake/bin/cmake.exe

# The command to remove a file.
RM = /X/tools/cmake/bin/cmake.exe -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /X/tools/luapower-full/csrc/libjpeg/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /X/tools/luapower-full/csrc/libjpeg/src

# Include any dependencies generated for this target.
include sharedlib/CMakeFiles/djpeg.dir/depend.make

# Include the progress variables for this target.
include sharedlib/CMakeFiles/djpeg.dir/progress.make

# Include the compile flags for this target's objects.
include sharedlib/CMakeFiles/djpeg.dir/flags.make

sharedlib/CMakeFiles/djpeg.dir/__/djpeg.c.obj: sharedlib/CMakeFiles/djpeg.dir/flags.make
sharedlib/CMakeFiles/djpeg.dir/__/djpeg.c.obj: sharedlib/CMakeFiles/djpeg.dir/includes_C.rsp
sharedlib/CMakeFiles/djpeg.dir/__/djpeg.c.obj: djpeg.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/X/tools/luapower-full/csrc/libjpeg/src/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object sharedlib/CMakeFiles/djpeg.dir/__/djpeg.c.obj"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/djpeg.dir/__/djpeg.c.obj   -c /X/tools/luapower-full/csrc/libjpeg/src/djpeg.c

sharedlib/CMakeFiles/djpeg.dir/__/djpeg.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/djpeg.dir/__/djpeg.c.i"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /X/tools/luapower-full/csrc/libjpeg/src/djpeg.c > CMakeFiles/djpeg.dir/__/djpeg.c.i

sharedlib/CMakeFiles/djpeg.dir/__/djpeg.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/djpeg.dir/__/djpeg.c.s"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /X/tools/luapower-full/csrc/libjpeg/src/djpeg.c -o CMakeFiles/djpeg.dir/__/djpeg.c.s

sharedlib/CMakeFiles/djpeg.dir/__/cdjpeg.c.obj: sharedlib/CMakeFiles/djpeg.dir/flags.make
sharedlib/CMakeFiles/djpeg.dir/__/cdjpeg.c.obj: sharedlib/CMakeFiles/djpeg.dir/includes_C.rsp
sharedlib/CMakeFiles/djpeg.dir/__/cdjpeg.c.obj: cdjpeg.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/X/tools/luapower-full/csrc/libjpeg/src/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object sharedlib/CMakeFiles/djpeg.dir/__/cdjpeg.c.obj"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/djpeg.dir/__/cdjpeg.c.obj   -c /X/tools/luapower-full/csrc/libjpeg/src/cdjpeg.c

sharedlib/CMakeFiles/djpeg.dir/__/cdjpeg.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/djpeg.dir/__/cdjpeg.c.i"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /X/tools/luapower-full/csrc/libjpeg/src/cdjpeg.c > CMakeFiles/djpeg.dir/__/cdjpeg.c.i

sharedlib/CMakeFiles/djpeg.dir/__/cdjpeg.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/djpeg.dir/__/cdjpeg.c.s"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /X/tools/luapower-full/csrc/libjpeg/src/cdjpeg.c -o CMakeFiles/djpeg.dir/__/cdjpeg.c.s

sharedlib/CMakeFiles/djpeg.dir/__/rdcolmap.c.obj: sharedlib/CMakeFiles/djpeg.dir/flags.make
sharedlib/CMakeFiles/djpeg.dir/__/rdcolmap.c.obj: sharedlib/CMakeFiles/djpeg.dir/includes_C.rsp
sharedlib/CMakeFiles/djpeg.dir/__/rdcolmap.c.obj: rdcolmap.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/X/tools/luapower-full/csrc/libjpeg/src/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object sharedlib/CMakeFiles/djpeg.dir/__/rdcolmap.c.obj"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/djpeg.dir/__/rdcolmap.c.obj   -c /X/tools/luapower-full/csrc/libjpeg/src/rdcolmap.c

sharedlib/CMakeFiles/djpeg.dir/__/rdcolmap.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/djpeg.dir/__/rdcolmap.c.i"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /X/tools/luapower-full/csrc/libjpeg/src/rdcolmap.c > CMakeFiles/djpeg.dir/__/rdcolmap.c.i

sharedlib/CMakeFiles/djpeg.dir/__/rdcolmap.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/djpeg.dir/__/rdcolmap.c.s"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /X/tools/luapower-full/csrc/libjpeg/src/rdcolmap.c -o CMakeFiles/djpeg.dir/__/rdcolmap.c.s

sharedlib/CMakeFiles/djpeg.dir/__/rdswitch.c.obj: sharedlib/CMakeFiles/djpeg.dir/flags.make
sharedlib/CMakeFiles/djpeg.dir/__/rdswitch.c.obj: sharedlib/CMakeFiles/djpeg.dir/includes_C.rsp
sharedlib/CMakeFiles/djpeg.dir/__/rdswitch.c.obj: rdswitch.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/X/tools/luapower-full/csrc/libjpeg/src/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object sharedlib/CMakeFiles/djpeg.dir/__/rdswitch.c.obj"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/djpeg.dir/__/rdswitch.c.obj   -c /X/tools/luapower-full/csrc/libjpeg/src/rdswitch.c

sharedlib/CMakeFiles/djpeg.dir/__/rdswitch.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/djpeg.dir/__/rdswitch.c.i"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /X/tools/luapower-full/csrc/libjpeg/src/rdswitch.c > CMakeFiles/djpeg.dir/__/rdswitch.c.i

sharedlib/CMakeFiles/djpeg.dir/__/rdswitch.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/djpeg.dir/__/rdswitch.c.s"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /X/tools/luapower-full/csrc/libjpeg/src/rdswitch.c -o CMakeFiles/djpeg.dir/__/rdswitch.c.s

sharedlib/CMakeFiles/djpeg.dir/__/wrgif.c.obj: sharedlib/CMakeFiles/djpeg.dir/flags.make
sharedlib/CMakeFiles/djpeg.dir/__/wrgif.c.obj: sharedlib/CMakeFiles/djpeg.dir/includes_C.rsp
sharedlib/CMakeFiles/djpeg.dir/__/wrgif.c.obj: wrgif.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/X/tools/luapower-full/csrc/libjpeg/src/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building C object sharedlib/CMakeFiles/djpeg.dir/__/wrgif.c.obj"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/djpeg.dir/__/wrgif.c.obj   -c /X/tools/luapower-full/csrc/libjpeg/src/wrgif.c

sharedlib/CMakeFiles/djpeg.dir/__/wrgif.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/djpeg.dir/__/wrgif.c.i"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /X/tools/luapower-full/csrc/libjpeg/src/wrgif.c > CMakeFiles/djpeg.dir/__/wrgif.c.i

sharedlib/CMakeFiles/djpeg.dir/__/wrgif.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/djpeg.dir/__/wrgif.c.s"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /X/tools/luapower-full/csrc/libjpeg/src/wrgif.c -o CMakeFiles/djpeg.dir/__/wrgif.c.s

sharedlib/CMakeFiles/djpeg.dir/__/wrppm.c.obj: sharedlib/CMakeFiles/djpeg.dir/flags.make
sharedlib/CMakeFiles/djpeg.dir/__/wrppm.c.obj: sharedlib/CMakeFiles/djpeg.dir/includes_C.rsp
sharedlib/CMakeFiles/djpeg.dir/__/wrppm.c.obj: wrppm.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/X/tools/luapower-full/csrc/libjpeg/src/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object sharedlib/CMakeFiles/djpeg.dir/__/wrppm.c.obj"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/djpeg.dir/__/wrppm.c.obj   -c /X/tools/luapower-full/csrc/libjpeg/src/wrppm.c

sharedlib/CMakeFiles/djpeg.dir/__/wrppm.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/djpeg.dir/__/wrppm.c.i"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /X/tools/luapower-full/csrc/libjpeg/src/wrppm.c > CMakeFiles/djpeg.dir/__/wrppm.c.i

sharedlib/CMakeFiles/djpeg.dir/__/wrppm.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/djpeg.dir/__/wrppm.c.s"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /X/tools/luapower-full/csrc/libjpeg/src/wrppm.c -o CMakeFiles/djpeg.dir/__/wrppm.c.s

sharedlib/CMakeFiles/djpeg.dir/__/wrbmp.c.obj: sharedlib/CMakeFiles/djpeg.dir/flags.make
sharedlib/CMakeFiles/djpeg.dir/__/wrbmp.c.obj: sharedlib/CMakeFiles/djpeg.dir/includes_C.rsp
sharedlib/CMakeFiles/djpeg.dir/__/wrbmp.c.obj: wrbmp.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/X/tools/luapower-full/csrc/libjpeg/src/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building C object sharedlib/CMakeFiles/djpeg.dir/__/wrbmp.c.obj"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/djpeg.dir/__/wrbmp.c.obj   -c /X/tools/luapower-full/csrc/libjpeg/src/wrbmp.c

sharedlib/CMakeFiles/djpeg.dir/__/wrbmp.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/djpeg.dir/__/wrbmp.c.i"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /X/tools/luapower-full/csrc/libjpeg/src/wrbmp.c > CMakeFiles/djpeg.dir/__/wrbmp.c.i

sharedlib/CMakeFiles/djpeg.dir/__/wrbmp.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/djpeg.dir/__/wrbmp.c.s"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /X/tools/luapower-full/csrc/libjpeg/src/wrbmp.c -o CMakeFiles/djpeg.dir/__/wrbmp.c.s

sharedlib/CMakeFiles/djpeg.dir/__/wrtarga.c.obj: sharedlib/CMakeFiles/djpeg.dir/flags.make
sharedlib/CMakeFiles/djpeg.dir/__/wrtarga.c.obj: sharedlib/CMakeFiles/djpeg.dir/includes_C.rsp
sharedlib/CMakeFiles/djpeg.dir/__/wrtarga.c.obj: wrtarga.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/X/tools/luapower-full/csrc/libjpeg/src/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building C object sharedlib/CMakeFiles/djpeg.dir/__/wrtarga.c.obj"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/djpeg.dir/__/wrtarga.c.obj   -c /X/tools/luapower-full/csrc/libjpeg/src/wrtarga.c

sharedlib/CMakeFiles/djpeg.dir/__/wrtarga.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/djpeg.dir/__/wrtarga.c.i"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /X/tools/luapower-full/csrc/libjpeg/src/wrtarga.c > CMakeFiles/djpeg.dir/__/wrtarga.c.i

sharedlib/CMakeFiles/djpeg.dir/__/wrtarga.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/djpeg.dir/__/wrtarga.c.s"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /X/tools/luapower-full/csrc/libjpeg/src/wrtarga.c -o CMakeFiles/djpeg.dir/__/wrtarga.c.s

# Object files for target djpeg
djpeg_OBJECTS = \
"CMakeFiles/djpeg.dir/__/djpeg.c.obj" \
"CMakeFiles/djpeg.dir/__/cdjpeg.c.obj" \
"CMakeFiles/djpeg.dir/__/rdcolmap.c.obj" \
"CMakeFiles/djpeg.dir/__/rdswitch.c.obj" \
"CMakeFiles/djpeg.dir/__/wrgif.c.obj" \
"CMakeFiles/djpeg.dir/__/wrppm.c.obj" \
"CMakeFiles/djpeg.dir/__/wrbmp.c.obj" \
"CMakeFiles/djpeg.dir/__/wrtarga.c.obj"

# External object files for target djpeg
djpeg_EXTERNAL_OBJECTS =

djpeg.exe: sharedlib/CMakeFiles/djpeg.dir/__/djpeg.c.obj
djpeg.exe: sharedlib/CMakeFiles/djpeg.dir/__/cdjpeg.c.obj
djpeg.exe: sharedlib/CMakeFiles/djpeg.dir/__/rdcolmap.c.obj
djpeg.exe: sharedlib/CMakeFiles/djpeg.dir/__/rdswitch.c.obj
djpeg.exe: sharedlib/CMakeFiles/djpeg.dir/__/wrgif.c.obj
djpeg.exe: sharedlib/CMakeFiles/djpeg.dir/__/wrppm.c.obj
djpeg.exe: sharedlib/CMakeFiles/djpeg.dir/__/wrbmp.c.obj
djpeg.exe: sharedlib/CMakeFiles/djpeg.dir/__/wrtarga.c.obj
djpeg.exe: sharedlib/CMakeFiles/djpeg.dir/build.make
djpeg.exe: libjpeg.dll.a
djpeg.exe: sharedlib/CMakeFiles/djpeg.dir/linklibs.rsp
djpeg.exe: sharedlib/CMakeFiles/djpeg.dir/objects1.rsp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/X/tools/luapower-full/csrc/libjpeg/src/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Linking C executable ../djpeg.exe"
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/cmake/bin/cmake.exe -E remove -f CMakeFiles/djpeg.dir/objects.a
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/ar.exe cr CMakeFiles/djpeg.dir/objects.a @CMakeFiles/djpeg.dir/objects1.rsp
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && /X/tools/mingw64/bin/gcc.exe -O3 -DNDEBUG   -Wl,--whole-archive CMakeFiles/djpeg.dir/objects.a -Wl,--no-whole-archive  -o ../djpeg.exe -Wl,--out-implib,../libdjpeg.dll.a -Wl,--major-image-version,0,--minor-image-version,0 @CMakeFiles/djpeg.dir/linklibs.rsp

# Rule to build all files generated by this target.
sharedlib/CMakeFiles/djpeg.dir/build: djpeg.exe

.PHONY : sharedlib/CMakeFiles/djpeg.dir/build

sharedlib/CMakeFiles/djpeg.dir/clean:
	cd /X/tools/luapower-full/csrc/libjpeg/src/sharedlib && $(CMAKE_COMMAND) -P CMakeFiles/djpeg.dir/cmake_clean.cmake
.PHONY : sharedlib/CMakeFiles/djpeg.dir/clean

sharedlib/CMakeFiles/djpeg.dir/depend:
	$(CMAKE_COMMAND) -E cmake_depends "MSYS Makefiles" /X/tools/luapower-full/csrc/libjpeg/src /X/tools/luapower-full/csrc/libjpeg/src/sharedlib /X/tools/luapower-full/csrc/libjpeg/src /X/tools/luapower-full/csrc/libjpeg/src/sharedlib /X/tools/luapower-full/csrc/libjpeg/src/sharedlib/CMakeFiles/djpeg.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : sharedlib/CMakeFiles/djpeg.dir/depend

