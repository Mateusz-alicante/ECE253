# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog main.sv

#load simulation using mux as the top level simulation module
vsim mux2to1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {x} 0
force {y} 0
force {s} 0
#run simulation for a few ns
run 10ns
# Expect 0


force {x} 1
force {y} 0
force {s} 0
#run simulation for a few ns
run 10ns
# Expect 1

force {x} 1
force {y} 0
force {s} 1
#run simulation for a few ns
run 10ns
# Expect 0

force {x} 0
force {y} 1
force {s} 1
#run simulation for a few ns
run 10ns
# Expect 1
