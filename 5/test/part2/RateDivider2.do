vlib work
vlog part2.sv


vsim -gCLOCK_FREQUENCY=10 RateDivider

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {Speed} 'b10
force {ClockIn} 0, 1 {1 ns} -r {2 ns}

run 2ns

force {Reset} 1
run 2ns

force {Reset} 0
run 2ns


run 100ns
