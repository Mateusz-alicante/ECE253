vlib work
vlog part1.sv


vsim part1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}


force {Clock} 0, 1 {1 ns} -r {2 ns}

force {w} 0
force {Reset} 1
run 2ns

force {Reset} 0
run 2ns

force {w} 1
run 2ns

force {w} 1
run 2ns

force {w} 1
run 2ns

force {w} 1
run 2ns

force {w} 0
run 2ns

force {w} 1
run 2ns

force {w} 1
run 2ns

force {w} 1
run 2ns