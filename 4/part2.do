vlib work
vlog part2.sv


vsim part2
  
#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}
##Initialize values
force {Clock} 0
force {Reset_b} 0
force {Data}
force {Function}
run 10ns
