                .global _start

                .equ    stdin, 0
                .equ    stdout, 1
                .equ    sys_read, 63
                .equ    sys_write, 64
                .equ    sys_exit, 93



		.data
prompt:		.ascii "Please type in a Sudoku puzzle to solve:\n> "
		.equ prompt_size, .-prompt

wrong:		.ascii "The input contained invalid characters\n"
		.equ wrong_size, .-wrong

long:		.ascii "The input was too long\n"
		.equ  long_size, .-long

unsolvable: 	.ascii "The board has no solution\n"
		.equ unsolvable_len, .-unsolvable

short:		.ascii "The input was too short\n"
		.equ  short_size, .-short

		
		.bss
input:		.space 200
		.equ  input_len, .-input

		.text


_start:
                // prompt user for a board
        	mov x0, #stdout
		ldr x1, =prompt
		ldr x2, =prompt_size
		mov x8, #sys_write
		svc #0
		   
		mov x0, #stdin
		ldr x1, =input
		ldr x2, =input_len
		mov x8, #sys_read
		svc #0

		mov x7,	#0
		cmp x0,	#0
		b.ge	.parse
		
		neg x0, x0
		mov x8, #sys_exit
		svc #0
		
.parse:
		ldr	x0, =input
		ldrb	w6,[x0,x7]
		cmp 	x6, #'\n'
		b.eq	.swap
		
		add	x7,x7, #1
		b	.parse

.swap:
		mov	x5, 0
		strb	w5,[x0,x7]
		b	.read
		
.read:	
		bl	read_board
		cmp	x0,#0
		b.ne	.exit
		ldr	x0, =input
		bl	solve
		cmp	x0,#0
		b.ne	.exit2
		ldr	x0,=input
		bl	print_board

.exit:	
		cmp	x0,#1
		b.eq	.tooshort
		cmp	x0,#2
		b.eq	.invalid
		cmp	x0,#3
		b.eq	.toolong

.tooshort:
		mov x0,#stdout
		ldr x1,=short
		ldr x2,=short_size
		mov x8, #sys_write
		svc	#0
		mov x0,#0
		mov x8, #sys_exit
		svc #0

.invalid:

		mov x0, #stdout
		ldr x1, =wrong
		ldr x2, =wrong_size
		mov x8, #sys_write
		svc	#0
		mov x0,#0
		mov x8,#sys_exit
		svc #0

.toolong:
		mov x0,#stdout
		ldr x1,=long
		ldr x2,=long_size	
		mov x8,#sys_write
		svc #0
		mov x0, #0
		mov x8,#sys_exit
		svc #0

.exit2:
		mov x0, #stdout
		ldr x1, =unsolvable
		ldr x2, =unsolvable_len
		mov x8, #sys_write
		svc #0
		mov x0,#0
		mov x8, #sys_exit
		svc	#0
		
		mov     x0, #0
                mov     x8, #sys_exit
                svc     #0






