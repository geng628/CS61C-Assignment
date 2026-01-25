.globl abs

.text
# =================================================================
# FUNCTION: Given an int return its absolute value.
# Arguments:
# 	a0 (int) is input integer
# Returns:
#	a0 (int) the absolute value of the input
# =================================================================
abs:
    # Prologue

    # return 0
    addi sp,sp -8
    sw s0,0(sp)
    sw ra,4(sp)
    
    add s0, a0, x0
    bge s0, x0 ,exit
    xori t1, s0, -1
    addi t2, t1, 1
    add s0, x0, t2
    exit:
    add a0, x0, s0

    # Epilogue
    lw s0,0(sp)
    lw ra,4(sp)
    addi sp, sp, 8
    ret
