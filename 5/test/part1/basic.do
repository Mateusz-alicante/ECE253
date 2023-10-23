vlib work
vlog part1.sv


vsim part1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

## Initilize values
force {Clock} 0
force {Enable} 0
force {Reset} 1
run 10ns


force {Clock} 0, 1 {10 ns} -r {20 ns}

run 10ns

force {Reset} 0
force {Enable} 1

run 1000ns