.data
    numbers: .word 8, 321, 2, -323, 4, 55, 6, 7, 8, 9
    max_min_msg: .asciiz "\nOs valores minimo e maximo, respectivamente, sao: "
    conjuncao_msg: .asciiz " e "

.text
.globl main
    main:
        la $s0, numbers
        li $t0,  0x00000000
        li $t1,  0x00000028 #40 em hexadecimal
        lw $s1, 0($s0)
        lw $s2, 0($s0)
        jal max_min_array
        jal print_min_e_max
        j END

    add_min:
        move $s2, $t2
        addi $t0, 4
        j max_min_array

    add_max:
        move $s1, $t2
        addi $t0, 4
        j max_min_array
        
    max_min_array:
        beq $t0, $t1, EXIT_LOOP
        addu $a0, $s0, $t0
        lw $t2, 0($a0)
        bgt $t2, $s1, add_max
        blt $t2, $s2, add_min
        addi $t0, 4
        j max_min_array

    print_min_e_max:
        la $a0, max_min_msg
        li $v0, 4
        syscall

        la $a0, ($s2)
        li $v0, 1
        syscall
        
        la $a0, conjuncao_msg
        li $v0, 4
        syscall

        la $a0, ($s1)
        li $v0, 1
        syscall

    EXIT_LOOP:
        jr $ra

    END:
        li $v0, 10
        syscall