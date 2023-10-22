vlib work
vlog part3.sv


vsim part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {clock} 0
run 10ns

force {clock} 1
force {reset} 1
force {Data_IN} 'b0101
run 10ns

force {clock} 0
run 10ns

force {clock} 1
force {reset} 0
force {ParallelLoadn} 0
force {RotateRight} 0
force {ASRight} 0
force {Data_IN} 'b0101
run 10ns

force {clock} 1
force {reset} 0
force {ParallelLoadn} 1
force {RotateRight} 1
force {ASRight} 0
force {Data_IN} 'b0101
run 10ns

force {clock} 0
run 10ns
force {clock} 1
run 10ns

force {clock} 0
run 10ns
force {clock} 1
run 10ns