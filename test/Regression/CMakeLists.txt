cmake_minimum_required(VERSION 3.3 FATAL_ERROR )

project( regression-test )

enable_testing()

set(CMAKE_CURRENT_DATA_DIR test/Regression/Data)

add_test( 
  NAME check_if_installed
  WORKING_DIRECTORY /usr/local/bin
  COMMAND test -f /usr/local/bin/xcompiler
)

add_test( 
  NAME compiler-test-on-query
  WORKING_DIRECTORY ${CMAKE_CURRENT_DATA_DIR}
  COMMAND xcompiler -q query-lnx.rql
)

# -----------------------------------------------------------------------------------------------

add_test( 
  NAME compile_pattern_source-1
  WORKING_DIRECTORY ${CMAKE_CURRENT_DATA_DIR}/Pattern1
  COMMAND sh -c "xcompiler -q query.rql > out.txt ; xdumper >> out.txt"
)

add_test(
  NAME compare_output_with_pattern-1
  WORKING_DIRECTORY ${CMAKE_CURRENT_DATA_DIR}/Pattern1
  COMMAND ${CMAKE_COMMAND} -E compare_files pattern.txt out.txt
)

set_tests_properties(compare_output_with_pattern-1 PROPERTIES DEPENDS compile_pattern_source-1)

# -----------------------------------------------------------------------------------------------

add_test( 
  NAME compile_pattern_source-2
  WORKING_DIRECTORY ${CMAKE_CURRENT_DATA_DIR}/Pattern2
  COMMAND sh -c "xcompiler query.rql > out.txt ; xdumper >> out.txt"
)

add_test(
  NAME compare_output_with_pattern-2
  WORKING_DIRECTORY ${CMAKE_CURRENT_DATA_DIR}/Pattern2
  COMMAND ${CMAKE_COMMAND} -E compare_files pattern.txt out.txt
)

set_tests_properties(compare_output_with_pattern-2 PROPERTIES DEPENDS compile_pattern_source-2)

# -----------------------------------------------------------------------------------------------

add_test(
        NAME compile_pattern_source-3
        WORKING_DIRECTORY ${CMAKE_CURRENT_DATA_DIR}/Pattern3
        COMMAND sh -c "xcompiler query-unfold.rql > out.txt ; xdumper >> out.txt"
)

add_test(
        NAME compare_output_with_pattern-3
        WORKING_DIRECTORY ${CMAKE_CURRENT_DATA_DIR}/Pattern3
        COMMAND ${CMAKE_COMMAND} -E compare_files pattern.txt out.txt
)

set_tests_properties(compare_output_with_pattern-3 PROPERTIES DEPENDS compile_pattern_source-3)

# -----------------------------------------------------------------------------------------------

add_test(
        NAME compile_pattern_source-4
        WORKING_DIRECTORY ${CMAKE_CURRENT_DATA_DIR}/Pattern4
        COMMAND sh -c "xcompiler query-crc.rql > out.txt ; xdumper >> out.txt"
)

add_test(
        NAME compare_output_with_pattern-4
        WORKING_DIRECTORY ${CMAKE_CURRENT_DATA_DIR}/Pattern4
        COMMAND ${CMAKE_COMMAND} -E compare_files pattern.txt out.txt
)

set_tests_properties(compare_output_with_pattern-4 PROPERTIES DEPENDS compile_pattern_source-4)

# -----------------------------------------------------------------------------------------------

add_test(
  NAME dumper-test
  WORKING_DIRECTORY ${CMAKE_CURRENT_DATA_DIR}
  COMMAND sh -c "xcompiler -q query-lnx.rql; xdumper -d"
)

set_tests_properties(dumper-test PROPERTIES DEPENDS compiler-test-on-query)

add_test( 
  NAME retractor-waterfall
  WORKING_DIRECTORY ${CMAKE_CURRENT_DATA_DIR}
  COMMAND sh -c "xcompiler query-lnx.rql; xretractor -m 20 --waterfall"
)

add_test( 
  NAME workflow-test
  WORKING_DIRECTORY ${CMAKE_CURRENT_DATA_DIR}
  COMMAND test-workflow.sh query-lnx.rql
)

add_test( 
  NAME workflow-all-operators
  WORKING_DIRECTORY ${CMAKE_CURRENT_DATA_DIR}
  COMMAND test-all-operators.sh query-all.rql
)

