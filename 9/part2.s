.data
# Messages
msg_1: .asciz "Please take a deep breath       "
msg_2: .asciz "Please drink some water         "
msg_3: .asciz "Please give your eyes a break   "

# Timer Related
timeNow: .word 0xFFFF0018 # current time
cmp: .word 0xFFFF0020 # time for new interrupt

.text
# Display Related
.eqv OUT_CTRL 0xffff0008
.eqv OUT 0xffff000C
.eqv DELAY 5000

.global _start

_start:

main:

addi s10, zero, 0 # we will use s10 to flag if the time has elapsed
addi s6, zero, 2 # keep track which message we are reading

la s5, msg_1
li s8, OUT

# Set time delay
la s0, cmp
lw s0, 0(s0)
li s1, DELAY
li s3, DELAY
sw s1, 0(s0)

la t0, timer_handler
csrrw zero, utvec, t0

# Set registers to enable interupts
csrrsi zero, ustatus, 1
csrrsi zero, uie, 0x10

LOOP:
addi s9, s9, 1
beqz s10, LOOP

# When the 5 seconds have elapsed
addi s4, zero, 32 # perform the print loop 32 times

PRINT_LOOP:

lb s2 0(s5)

sw s2, 0(s8)

addi s5, s5, 1
addi s4, s4, -1
bnez s4, PRINT_LOOP
addi s7, s7, 1

# Update message to print
la s5, msg_2
addi t0, zero, 2
beq s6, t0, DONE_UPDATE

la s5, msg_3


DONE_UPDATE:

# setup up interup again
add s1, s1, s3
addi s10, zero, 0
beqz s6, END
addi s6, s6, -1
sw s1, 0(s0)

j LOOP

# Set time to trigger interrupt to be 5000 milliseconds (5 seconds)
# Set the handler address and enable interrupts
# Loop over the messages
# Print message to ASCII display
timer_handler:
addi s10, zero, 1
uret
# Push registers to the stack
# Indicate that 5 seconds have passed
# Pop registers from the stack


END:
ebreak




