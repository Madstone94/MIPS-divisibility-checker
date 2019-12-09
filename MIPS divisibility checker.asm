#################################################################################### 
# Created by:  Stone, Matthew
#              1673656
#              7 August 2018 
# 
# Assignment:  Lab 3 
#              CMPE 012, Computer Systems and Assembly Language 
#              UC Santa Cruz, Fall 2018 
#  
# Description: 
#  
# Notes:       Got help from TA Zach on lab during office hours. Problem: rogue syscall and my misunderstanding of how the $v0 register works when its set to 10. Timing problem due to missing NOPS.
#################################################################################### 
.data
intro: .asciiz "Please input a positive integer: "
Flux: .asciiz  "Flux\n"
Bunny: .asciiz  "Bunny\n"
FluxBunny: .asciiz  "Flux Bunny\n"
term: .asciiz "\n"
.text
# intro message
li $v0, 4
la $a0, intro
syscall
# input
li $v0, 5
syscall
# stores input into temp register
move $t1, $v0
# 0 is always a flux bunny, loop starts at 1.
li $v0, 4
la $a0, FluxBunny
syscall
loop:
        addi $t0, $t0, 1
        bgt $t0, $t1, exit
        # processes integer
        rem $t2, $t0, 5
        rem $t3, $t0, 7
        # checkers
        beqz $t2, five
        back: nop
        beqz $t3, seven
        backer: nop
        beqz $t2, both
        backest: nop
        bgtz $t2, neither
        backester: nop
        j loop
# condition for 5 divisible
five: nop
        bgtz $t3, five2
        j back
five2: nop
        li $v0, 4
        la $a0, Flux
        syscall
        j loop
# condition for 7 divisible
seven: nop
        bgtz $t2, seven2
        j backer
seven2: nop 
        li $v0, 4
        la $a0, Bunny
        syscall
        j loop
# condition for both divisible
both: nop
        beqz $t3, both2
        j backest
both2: nop
        li $v0, 4
        la $a0, FluxBunny
        syscall
        j loop
# condition for neither
neither: nop
        bgtz $t3, neither2
        j backester
neither2: nop
        li $v0, 1
        move $a0, $t0
        syscall
        li $v0, 4
        la $a0, term
        syscall
        j loop
exit: nop
        li $v0, 10
        syscall
