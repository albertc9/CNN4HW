#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
# Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/home/work1/Apps/Vivado/2023.2/ids_lite/ISE/bin/lin64:/home/work1/Apps/Vivado/2023.2/bin
else
  PATH=/home/work1/Apps/Vivado/2023.2/ids_lite/ISE/bin/lin64:/home/work1/Apps/Vivado/2023.2/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/work1/Work/CNN_iCube_FPGA_b/CNN_iCube_FPGA_b1/CNN_iCube_FPGA_b1.runs/synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log CNN4HW_TOP.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source CNN4HW_TOP.tcl
