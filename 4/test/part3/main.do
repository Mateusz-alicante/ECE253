vlib work
vlog part3.sv


vsim part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

## Initilize values
force {clock} 0
force {reset} 0
force {ParallelLoadn} 1
force {RotateRight} 1
force {ASRight} 0
force {Data_IN} 'b0000
run 10ns

# Reset filpflops
force {reset} 1
force {clock} 1
run 10ns

force {reset} 0
force {clock} 0
run 10ns

# Set flipflops to value
force {ParallelLoadn} 0
force {Data_IN} 'b1100
force {clock} 1
run 10ns

force {clock} 0
run 10ns

## Now rotate the values in the FFs
force {reset} 0
force {ParallelLoadn} 1
force {RotateRight} 1
force {ASRight} 0
force {clock} 1
run 10ns

force {clock} 0
run 10ns

force {clock} 1
run 10ns

force {clock} 0
run 10ns

force {clock} 1
run 10ns

force {clock} 0
run 10ns

force {clock} 1
run 10ns

force {clock} 0
run 10ns



