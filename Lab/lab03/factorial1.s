.globl factorial

.data
n: .word 8 #全局变量为8

.text
main:
    la t0, n
    lw a0, 0(t0) # 将参数传进去
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial: # 传进来的参数是a0
    # YOUR CODE HERE # 目标是阶乘 递归版本
    li t0 ,1
    beq a0, t0, Basecase #递归过程a0,ra会被覆盖
    addi sp, sp, -8
    sw a0 0(sp)
    sw ra 4(sp)

    addi a0 , a0, -1
    jal factorial

    lw ra 4(sp)
    lw t1 0(sp)
    addi sp, sp, 8
    mul a0, a0, t1
    jr ra

Basecase:
    jr ra