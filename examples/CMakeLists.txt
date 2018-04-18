include_directories(${CMAKE_SOURCE_DIR}/lib)

add_executable(example example.c)
add_executable(example-serial example-serial.c)

target_link_libraries(example roboint)
target_link_libraries(example-serial roboint)
