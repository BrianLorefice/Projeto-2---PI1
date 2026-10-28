.data
tocando: .asciiz "Alarme tocando"
nao_tocando: .asciiz "Alarme não está tocando"
valorA: .asciiz "Digite o valor para A(a porta está aberta ?(0 ou 1)):"
valorB: .asciiz "Digite o valor para B(foi detectado movimento ?(0 ou 1)):"
valorC: .asciiz "Digite o valor para C(o alarme está ativo ?(0 ou 1)):"
invalido: .asciiz "Valor invalido digitado, tente novamente\n"

.text

.globl main

main:
entrada_A:
la $a0, valorA #peço valor para A
li $v0, 4
syscall

li $v0, 5
syscall
move $t0, $v0 #guardo A em $t0

beq $t0, 0, entrada_B #Esse bloco verifica se foi digitado um binário para A
beq $t0, 1, entrada_B
la $a0, invalido
li $v0, 4
syscall
j entrada_A

entrada_B:
la $a0, valorB #peço valor para B
li $v0, 4
syscall

li $v0, 5
syscall
move $t1, $v0 #guardo B em $t1

beq $t1, 0, entrada_C #Esse bloco verifica se foi digitado um binário para B
beq $t1, 1, entrada_C
la $a0, invalido
li $v0, 4
syscall
j entrada_B

entrada_C:
la $a0, valorC #peço valor para C
li $v0, 4
syscall

li $v0, 5
syscall
move $t2, $v0 #guardo C em $t2

beq $t2, 0, portas #Esse bloco verifica se foi digitado um binário para C
beq $t2, 1, portas
la $a0, invalido
li $v0, 4
syscall
j entrada_C

portas:
and $t3, $t0, $t2 #A and C, resultado vai para $t3
and $t4, $t1, $t2 #B and C, resultado vai para $t4
or $t5, $t3, $t4 #$t3 or $t4, resultado vai para $t5

beq $t5, 1, res_1 #verifica se $t5 é igual a 1, se for manda para o bloco onde o alarme toca, se não for, ele deixa passar reto

res_0:
la $a0, nao_tocando #bloco onde o alarme não toca
li $v0, 4
syscall
li $v0, 10 #encerra o programa
syscall

res_1:
la $a0, tocando #bloco conde o alarme toca
li $v0, 4
syscall
li $v0, 10 #encerra o programa
syscall
