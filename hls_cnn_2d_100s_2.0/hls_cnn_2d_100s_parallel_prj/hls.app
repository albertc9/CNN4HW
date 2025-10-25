<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="com.autoesl.autopilot.project" name="hls_cnn_2d_100s_parallel_prj" top="hls_cnn_2d_100s_parallel">
  <files>
    <file name="../../tb_data" sc="0" tb="1" cflags="-Wno-unknown-pragmas" blackbox="false" csimflags=""/>
    <file name="../../firmware/weights" sc="0" tb="1" cflags="-Wno-unknown-pragmas" blackbox="false" csimflags=""/>
    <file name="../../hls_cnn_2d_100s_parallel_test.cpp" sc="0" tb="1" cflags="-std=c++0x -Wno-unknown-pragmas" blackbox="false" csimflags=""/>
    <file name="firmware/hls_cnn_2d_100s_parallel.cpp" sc="0" tb="false" cflags="-std=c++0x" blackbox="false" csimflags=""/>
  </files>
  <solutions>
    <solution name="solution1" status="active"/>
  </solutions>
  <includePaths/>
  <libraryPaths/>
  <Simulation argv="">
    <SimFlow name="csim" ldflags="" mflags=""/>
  </Simulation>
</project>
