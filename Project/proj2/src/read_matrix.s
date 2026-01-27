.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
# Exceptions:
# - If malloc returns an error,
#   this function terminates the program with error code 88.
# - If you receive an fopen error or eof, 
#   this function terminates the program with error code 90.
# - If you receive an fread error or eof,
#   this function terminates the program with error code 91.
# - If you receive an fclose error or eof,
#   this function terminates the program with error code 92.
# ==============================================================================
read_matrix:

    addi sp,sp, -20
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw ra, 16(sp)

    mv s1, a1
    mv s2, a2
    # Prologue
    

    mv a1, a0
    li a2, 0    #only read
    jal fopen   #return a0, a0 is file descriptor
    mv s0, a0
    

    li a0, 8
    jal malloc
    
    mv t0, a0
    mv a1, s0
    mv a2, t0
    li a3, 8
    addi sp,sp -12
    sw a0, 4(sp)
    sw a1, 8(sp)
    sw a2, 0(sp)
    jal fread
    
    lw a2, 0(sp)
    lw a1, 8(sp)
    lw a0, 4(sp)
    addi sp,sp, 12

    lw t1,0(a2)
    lw t2,4(a2)
    sw t1,0(s1)  # row
    sw t2,0(s2)  # column

    mul t1, t1, t2
    slli t1, t1, 2
    mv a0, t1
    addi sp,sp, -4
    sw t1, 0(sp)
    jal malloc
    
    lw t1, 0(sp)
    addi sp,sp, 4
    mv a1, s0
    mv s3, a0
    mv a2, s3
    mv a3, t1
    
    jal fread
    

    mv a1, s0
    jal fclose
    
    mv a0, s3
    # Epilogue
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw ra, 16(sp)
    addi sp,sp, 20
    ret

fclose_error:
    li a1, 92
    j fal_error
fread_error:
    li a1, 91
    j fal_error
fopen_error:
    li a1, 90
    j fal_error
malloc_error:
    li a1, 88
    j fal_error
fal_error:
    jal exit2