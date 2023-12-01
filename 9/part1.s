.global _start
.text

_start:

# Load adress registers
la s0, KEYBOARDREADY
lw s0, 0(s0)
la s1, KEYBOARDDATA
lw s1, 0(s1)
la s2, DISPLAYREADY
lw s2, 0(s2)
la s3, DISPLAY
lw s3, 0(s3)

POLL:
lbu t0, 0(s0) # Load byte from the keybord pressed adress
andi t0, t0, 1 # only care about less significant bit
beqz t0, POLL # Check if key is being pressed

lw s4, 0(s1) # Save the ascii value being pressed


# first wait until the display is availiable:
WAIT_DISP:
lbu t0, 0(s2) 
andi t0, t0, 1 # only care about less significant bit
beqz t0, WAIT_DISP 

# When ready display char
sw s4, 0(s3)
j POLL





END:
    ebreak
    
.global KEYBOARDDATA, KEYBOARDREADY, DISPLAY, DISPLAYREADY
.data

KEYBOARDREADY:
.word 0xffff0000

KEYBOARDDATA:
.word 0xffff0004


DISPLAYREADY:
.word 0xffff0008

DISPLAY:
.word 0xffff000c
