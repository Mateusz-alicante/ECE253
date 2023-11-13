vlib work
vlog part2.sv


vsim part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}


force {Clock} 0, 1 {1 ns} -r {2 ns}

force {DataIn} 0
force {Reset} 1
force {Go} 0
run 2ns

force {Reset} 0
run 4ns

# Load Data

force {DataIn} 'b00000001
force {Go} 1

run 2ns

force {Go} 0

run 2ns


force {DataIn} 'b00000010
force {Go} 1

run 2ns

force {Go} 0

run 2ns


force {DataIn} 'b00000100
force {Go} 1

run 2ns

force {Go} 0

run 2ns


force {DataIn} 'b00001000
force {Go} 1

run 2ns

force {Go} 0

run 2ns

run 20ns
