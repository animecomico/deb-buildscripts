#!/bin/sh
#Build a metapackage with dependencies to everything being needed to build and run the ChibiOS simulator
./mkmetapkg.sh chibios-toolchain 1.0 "build-essential, gcc-4.7-multilib, gcc-arm-none-eabi, openocd" "ChibiOS dependencies (metapackage)"
