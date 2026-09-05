# Aurora Glass style reminder: a restrained glassmorphic OpenOS/bNode desktop shell focused on clear hierarchy and responsive interaction.
cmake_minimum_required(VERSION 3.20)
project(openos_aurora_shell LANGUAGES C CXX ASM_NASM)

include(CTest)

set(CMAKE_C_STANDARD 17)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(openos_system_bridge STATIC
  src/c/system_bridge.c
  src/asm/cpu_features.asm
)

target_include_directories(openos_system_bridge PUBLIC src/c)

target_compile_options(openos_system_bridge PRIVATE
  $<$<COMPILE_LANGUAGE:C>:-Wall;-Wextra;-Wpedantic>
)

add_executable(openos_shell_demo
  src/cpp/ShellState.cpp
  src/cpp/main.cpp
)

target_link_libraries(openos_shell_demo PRIVATE openos_system_bridge)

target_compile_options(openos_shell_demo PRIVATE
  $<$<COMPILE_LANGUAGE:CXX>:-Wall;-Wextra;-Wpedantic>
)

if(BUILD_TESTING)
  add_test(NAME openos_shell_demo_status COMMAND openos_shell_demo)
endif()

install(TARGETS openos_shell_demo RUNTIME DESTINATION bin)
