cmake_minimum_required(VERSION 3.3 FATAL_ERROR )

project( regression-test )

set(Boost_USE_STATIC_LIBS ON )
set(Boost_USE_MULTITHREADED ON)

enable_testing()

FIND_PACKAGE( Boost COMPONENTS
    thread
    filesystem
    serialization
    regex
    program_options
    chrono
    date_time
    system
    REQUIRED )

MESSAGE(STATUS "Boost information:")
MESSAGE(STATUS "Boost_INCLUDE_DIRS: ${Boost_INCLUDE_DIRS}")
MESSAGE(STATUS "Boost_LIBRARY_DIRS: ${Boost_LIBRARY_DIRS}")
MESSAGE(STATUS "Boost_LIBRARIES: ${Boost_LIBRARIES}")

link_libraries(
    ${Boost_LIBRARIES}
)

INCLUDE_DIRECTORIES("${Boost_INCLUDE_DIR};${CMAKE_SOURCE_DIR}/src/share;${CMAKE_SOURCE_DIR}/src;${CMAKE_SOURCE_DIR}/src/compiler")
ADD_DEFINITIONS( "-DHAS_BOOST" )

set(CMAKE_CURRENT_DATA_DIR .)

set(SOURCES_QRY_TEST
  ${CMAKE_SOURCE_DIR}/src/qry/qry.cpp
  test_qry.cpp
)

set(SOURCES_COMPILER_TEST
  ${CMAKE_SOURCE_DIR}/src/compiler/compiler.cpp
  ${CMAKE_SOURCE_DIR}/src/compiler/parser.cpp
  ${CMAKE_SOURCE_DIR}/src/share/QStruct.cpp
  ${CMAKE_SOURCE_DIR}/src/share/SOperations.cpp
  test_compiler.cpp
)

add_executable( test_xqry ${SOURCES_QRY_TEST} )
add_executable( test_xcompiler ${SOURCES_COMPILER_TEST} )

target_link_libraries( test_xqry ${Boost_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT} -lrt -ldl -lboost_unit_test_framework )
target_link_libraries( test_xcompiler ${Boost_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT} -lrt -ldl -lboost_unit_test_framework )

add_test( 
  NAME unittest-test-xqry
  WORKING_DIRECTORY ${CMAKE_CURRENT_DATA_DIR}
  COMMAND test_xqry
)

add_test( 
  NAME unittest-test-xcompiler
  WORKING_DIRECTORY ${CMAKE_CURRENT_DATA_DIR}
  COMMAND test_xcompiler
)
