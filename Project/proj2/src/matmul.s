.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0

#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1

#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 72.
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 73.
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 74.
# =======================================================
matmul:

    # Error checks
    li t0, 1
    blt a1, t0, m0_invalid_dimensions
    blt a2, t0, m0_invalid_dimensions

    blt a4, t0, m1_invalid_dimensions
    blt a5, t0, m1_invalid_dimensions

    bne a2, a4, dimension_mismatch

    # Prologue
    addi sp,sp -36
    sw s0,0(sp)
    sw s1,4(sp)
    sw s2,8(sp)
    sw s3,12(sp)
    sw s4,16(sp)
    sw s5,20(sp)
    sw s6,24(sp)
    sw s7,28(sp)
    sw ra,32(sp)


    mv s0,a0
    mv s1,a3
    mv s2,a6

    mv s3,a1 # height of m0
    mv s4,a2 # width 0f m0 = height 0f m1
    mv s5,a5 # height 0f m1

    li t0, 0 # i = 0
outer_loop_start:
    beq t0, s3, outer_loop_end   # i
    li t1,0   # j = 0
inner_loop_start:
    beq t1, s5 ,inner_loop_end
    # Calculate row pointer for m0: m0 + i * width_m0 * 4
    mul t2, t0, s4
    slli t2, t2, 2
    add a0, s0, t2

    # Calculate column pointer for m1: m1 + j * 4
    slli t3, t1, 2
    add a1, s1, t3


    # set up argument for dot
    mv a2, s4
    li a3, 1
    mv a4, s5

    # Save registers before call
    addi sp, sp, -16
    sw t0,0(sp)
    sw t1,4(sp)
    sw t2,8(sp)
    sw t3,12(sp)

    jal ra, dot

    lw t3,12(sp)
    lw t2,8(sp)
    lw t1,4(sp)
    lw t0,0(sp)
    addi sp,sp,16

    # store a0(result) in d   i * width(m1) + j
    mul t4, t0, s5
    add t4, t4, t1
    slli t4 , t4, 2
    add t5, s2, t4
    sw a0, 0(t5)

    addi t1, t1, 1 # j++
    j inner_loop_start

inner_loop_end:
    addi t0, t0, 1 #i++
    j outer_loop_start
outer_loop_end:


    # Epilogue
    lw s0,0(sp)
    lw s1,4(sp)
    lw s2,8(sp)
    lw s3,12(sp)
    lw s4,16(sp)
    lw s5,20(sp)
    lw s6,24(sp)
    lw s7,28(sp)
    lw ra,32(sp)
    addi sp, sp, 36
    ret

m0_invalid_dimensions:
    li a1, 72
    j exit_with_error
m1_invalid_dimensions:
    li a1, 73
    j exit_with_error
dimension_mismatch:
    li a1, 74
    j exit_with_error
exit_with_error:
    jal exit2