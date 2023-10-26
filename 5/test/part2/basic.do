vlib work
vlog part2.sv


vsim part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {ClockIn} 0, 1 {10 ns} -r {20 ns}

force {Reset} 1
run 10ns

force {Reset} 0
run 10ns

force {Speed} 'b00



run 1000ns
