.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors

#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 75.
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 76.
# =======================================================
dot:
    li t5, 1
    blt a2,t5 error1
    blt a3,t5 error2
    blt a3,t5 error2
    addi sp,sp -8
    sw s0,0(sp)
    sw s1,4(sp)
    # Prologue
    mv s0,a0
    mv s1,a1
    add t1,zero,zero
    add t6,zero,zero #result
    mv t0, s0
    mv t2, s1   #stride
    slli a3, a3, 2   #real stride * 4
    slli a4, a4, 2
loop_start:
    beq t1, a2, loop_end
    lw t4,0(t0)
    lw t5,0(t2)
    mul t3, t4, t5
    add t6, t6, t3
    
    add t0, t0, a3
    add t2, t2, a4
    addi t1, t1, 1
    j loop_start
loop_end:
    mv a0, t6
    # Epilogue
    lw s1, 4(sp)
    lw s0, 0(sp)
    addi sp, sp, 8
    ret

error1:
    li a1, 75
    jal exit2
error2:
    li a1, 76
    jal exit2