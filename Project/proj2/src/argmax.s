.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 77.
# =================================================================
argmax: 

    li t5 1
    blt a1, t5, Exception
    # Prologue
    addi sp,sp,-8
    sw s0,0(sp)
    sw s1,4(sp)

    mv s0,a0
    mv s1,a1
    add t0, x0, s0     
    add t1, zero,zero
    add t3 ,zero,zero    #min
    add t4, zero,zero
loop_start:
    beq t1, s1, loop_end
    lw t2, 0(t0)
    bge t3, t2, loop_continue
    mv t3, t2
    mv t4, t1
loop_continue:
    addi t1, t1, 1
    addi t0, t0, 4
    j loop_start
loop_end:
    mv a0, t4

    lw s0,0(sp)
    lw s1,4(sp)
    addi sp,sp,8
    # Epilogue


    ret
Exception:
    li a1, 77
    jal exit2