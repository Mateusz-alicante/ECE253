vlib work
vlog part2.sv


vsim -gCLOCK_FREQUENCY=10 RateDivider

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {Reset} 1
run 2ns

force {Reset} 0
run 2ns

force {Speed} 'b01

force {ClockIn} 0, 1 {1 ns} -r {2 ns}

run 30ns
