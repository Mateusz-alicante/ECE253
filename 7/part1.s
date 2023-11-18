.global _start
.text

_start:
    la s2, LIST
    addi s10, zero, 0
    addi s11, zero, 0
    
    # Write your code here

    addi s9, zero, -1
    
LOOP:
    lw s3, 0(s2)
    beq s3, s9, END
    addi s11, s11, 1
    add s10, s10, s3
    addi s2, s2, 4
    b LOOP

END:
    ebreak
.global LIST
.data
LIST:
.word 1, 2, 3, 5, 0xA, -1
