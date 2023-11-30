.global _start
.text


_start:

    la s0, LIST # Load list in register
    lw s1, 0(s0) 

    # This will be the number of times to perform bubble sort
    # (n = len(LIST) - 1)
    addi s1, s1, -1 

    addi s0, s0, 4 # Do not include the first element of LIST in comparisons

    addi s5, zero, 0 # N of times it has run already

OUTER_LOOP:

    beq s5, s1, END # If the index is equal to the number of elements - 1, end the outer loop

    addi s3, zero, 0 # s3 keeps track if the current iteration has swapped

    add s4, zero, s0 # Reset index to initial

    # times to run inner loop
    # n = len(LIST) - i - 1
    sub s6, s1, s5 
    
INNER_LOOP:

    beqz s6, END_INNER_LOOP

    add a0, zero, s4

    jal SWAP

    add s3, s3, a0

    addi s6, s6, -1
    addi s4, s4, 4

    b INNER_LOOP
    

END_INNER_LOOP:
    addi s5, s5, 1

    # If no swaps were made list is sorted
    beqz s3, END
    
    b OUTER_LOOP





#### SWAP subroutine
SWAP:
    lw t0, 0(a0)
    lw t1, 4(a0)
    addi t2, zero, 0

    blt t0, t1, END_SWAP # if t0 > t1 then skip the swap

    sw t1, 0(a0)
    sw t0, 4(a0)
    addi t2, zero, 1
    

END_SWAP:

    add a0, zero, t2
    jr ra

    

END:
    ebreak



.global LIST
.data
LIST:
.word 10, 10, 1, 23, 22, 10, 54, 34, 23, 23, 23
