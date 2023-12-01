# Program that counts consecutive 1’s.
.global _start
.text

# Searches for longest string of 1s in WORD data

_start:
    la s2, LIST # Load the memory address into s2
    addi s4, zero, -1
    addi s10, zero, 0 # Register s10 will hold the result

# Loop for every word and find the longes number of 1s
LOOP:
    lw a0, 0(s2)
    beq a0, s4, END # If the current element is -1, end the program
    jal ONES  # jump to LOOP_ONES and save position to ra

    ble a0, s10, CONTINUE # if a0 <= s10 then target
    # If the current length is larger than the one stores, place it in the solution register
    add s10, zero, a0

CONTINUE:
    addi s2, s2, 4
    b LOOP



ONES:
    addi t1, zero, 0 # start with 0 length
    
LOOP_ONES:
    beqz a0, ONES_RETURN # Loop until data contains no more 1’s
    srli t0, a0, 1 # Perform SHIFT, followed by AND
    and a0, t0, a0
    addi t1, t1, 1 # Count the string lengths so far
    b LOOP_ONES

ONES_RETURN:
    add a0, zero, t1
    jr ra


END:
    ebreak



.global LIST
.data
LIST:
.word 0x103fe00f,0x3, 0x3, 0x0000ffff, -1

