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
    # YOUR CODE HERE # 目标是阶乘  //迭代版本
    add t0, x0, a0
    addi t1 , x0, 1
LOOP:
    beq t0, x0, Exit
    mul t1, t1, t0
    addi t0, t0, -1
    jal x0, LOOP
Exit:
    add a0, t1, x0
    jr ra
