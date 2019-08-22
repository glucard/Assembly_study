.data
    numbers: .word 8, 321, 2, -323, 4, 55, 6, 7, 8, 9
    max_min_msg: .asciiz "\nOs valores minimo e maximo, respectivamente, sao: "
    conjuncao_msg: .asciiz " e "

.text
.globl main
    main:
        la $s0, numbers #definindo $s0 como o endereco do array numbers
        li $t0,  0x00000000 #contador
        li $t1,  0x00000028 #condicao de parada (40 em hexadecimal)
        lw $s1, 0($s0) #$s1 definido como o portador do valor MAXIMO (iniciado com o primeiro valor do array numbers)
        lw $s2, 0($s0) #$s1 definido como o portador do valor MINIMO (iniciado com o primeiro valor do array numbers)
        jal max_min_array #chamando a funcao max_min_array
        jal print_min_e_max #chamando a funcao print_min_e_max
        j END #chamando a funcao END

    add_min:
        move $s2, $t2 #define $s1 com o valor de $t2
        addi $t0, 4 #incrementa uma posicao<int> no contador
        j max_min_array #chama a funcao max_min_array sem guardar a posicao atual 

    add_max:
        move $s1, $t2  #define $s1 com o valor de $t2
        addi $t0, 4 #incrementa uma posicao<int> no contador
        j max_min_array #chama a funcao max_min_array sem guardar a posicao atual 
        
    max_min_array: #funcao para verificar o valor minimo e maximo
        beq $t0, $t1, EXIT_LOOP #condicao de parada do loop if($t0 == $t1):EXIT_LOOP
        addu $a0, $s0, $t0 # $a0 = $s0 + $t0 (endereco do array number + contador)
        lw $t2, 0($a0) #carrega o valor do endereco armazenado em $a0 em $t2
        bgt $t2, $s1, add_max #if(t2 > $s1) then define $t2 como valor maximo
        blt $t2, $s2, add_min #if(t2 > $s1) then define $t2 como valor maximo
        addi $t0, 4 #incrementa uma posicao<int> no contador
        j max_min_array #rechama a propria funcao (LOOP)

    print_min_e_max: #funcao print para Str e int
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

    EXIT_LOOP: #sair do loop
        jr $ra

    END: #terminar algoritmo
        li $v0, 10
        syscall
