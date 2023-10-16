# set the working dir, where all compiled verilog goes
vlib work

# compile all system verilog modules in mux.sv to working dir
# could also have multiple verilog files
vlog main.sv

#load simulation using mux as the top level simulation module
vsim v7404

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {pin1} 0
#run simulation for a few ns
run 10ns


force {pin1} 1
#run simulation for a few ns
run 10ns
