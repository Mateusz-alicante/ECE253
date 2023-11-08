vlib work
vlog part3.sv


vsim part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}


force {Clock} 0, 1 {1 ns} -r {2 ns}

force {Go} 0
force {Divisor} 0
force {Divident} 0

force {Reset} 1
run 2ns

force {Reset} 0
run 3ns

force {Divident} 'b0111
force {Divisor} 'b0011
force {Go} 1
run 3ns

force {Go} 0
run 3ns

run 20ns