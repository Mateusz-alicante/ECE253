vlib work
vlog 7to1.sv


vsim part1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}


force {MuxIn} 'b00000001
force {MuxSelect} 'b111
#run simulation for a few ns
# expect 1
run 10ns


force {MuxIn} 'b0111111
force {MuxSelect} 'b111
#run simulation for a few ns
# expect 0
run 10ns

