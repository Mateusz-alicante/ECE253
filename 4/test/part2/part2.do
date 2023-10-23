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

# Reset filpflops
force {Reset} 1
force {Clock} 1
run 10ns

force {Reset} 0
force {Clock} 0
run 10ns

# Set different Function values
force {Function} 'b00
force {Function} 'b01
force {Function} 'b10
force {Function} 'b11
run 10ns
