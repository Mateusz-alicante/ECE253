vlib work
vlog part3.sv


vsim -gCLOCK_FREQUENCY=6 part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

run 2ns

force {ClockIn} 0, 1 {1 ns} -r {2 ns}

force {Reset} 1
force {Start} 0
run 2ns

force {Reset} 0
run 3ns

force {Letter} 'b000
force {Start} 1

run 2ns

force {Start} 0

run 140ns

