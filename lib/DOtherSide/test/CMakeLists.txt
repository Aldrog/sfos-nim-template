project(TestDynamicQObject)

set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_CXX_FLAGS "-std=c++11")

include_directories(${CMAKE_SOURCE_DIR}/lib/include ${CMAKE_SOURCE_DIR}/lib/include/Qt)

find_package(Qt5Test REQUIRED)

add_executable(${PROJECT_NAME} test_dynamicqobject.cpp)
target_link_libraries(${PROJECT_NAME} DOtherSideStatic Qt5::Test)
