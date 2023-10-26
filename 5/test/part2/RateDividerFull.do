vlib work
vlog part2.sv


vsim RateDivider

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {Reset} 1
run 10ns

force {Reset} 0
run 10ns

force {Speed} 'b00

force {ClockIn} 0, 1 {1 ns} -r {2 ns}

run 40ns
