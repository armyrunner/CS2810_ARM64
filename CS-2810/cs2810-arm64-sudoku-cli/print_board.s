                .global print_board
                
		.equ    stdout, 1
                .equ    sys_write, 64
		.equ    sys_exit, 93
                .text

		// print_board(board) -> 0 for success, >0 for error
print_board:
		sub sp,sp, #80
		str x19, [sp,#0]
		str x20, [sp,#8]
		str x21, [sp,#16]
		str x22, [sp,#24]
		str x23, [sp,#32]
		str x24, [sp,#40]
		str x30, [sp,#48]
		str x28, [sp,#56]
		str x26, [sp,#64]
		
		mov x19, #0 //index
		mov x20, #0 //row
		mov x21, #2 //position
		mov x22, x0 //board
		mov x24, #0 //column
		ldr x26, =template

.rowloop:	
		cmp x20, #9
		b.ge .lastrow
	  	cmp x20, #0
		b.eq .dividerrow
		cmp X20, #3
		b.eq .dividerrow
	 	cmp x20, #6
		b.eq .dividerrow

.rowloopend:
		mov x21, #2
		mov x24, #0

.columnloop:
		cmp x24, #9
		b.ge .printrow
		ldrb w23, [x22,x19]
		add x19, x19, #1
		cmp x23, #0
		b.eq .addspace
		b .convertascii

.addspace:

		mov x23, #' '
		b .next

.convertascii:

		add x23,x23, #'0'

.next:
		strb w23,[x26,x21]
		add x21, x21, #2
		cmp x24, #2
		b.eq .addposition
		cmp x24, #5
		b.eq .addposition
		b    .addcolumn

.addposition:

		add x21, x21, #2
	
.addcolumn:

		add x24,x24, #1
		b   .columnloop
	
.printrow:
		mov   x0, #0
		mov   x1, x26
		b     print_row

.lastrow:

		mov 	x0,#2
		b	print_row	
		b  	.end
.dividerrow:
		
		mov   x0, #1
		b    print_row
		b   .rowloopend
.end:
		
		ldr x19, [sp,#0]
		ldr x20, [sp,#8]
		ldr x21, [sp,#16]
		ldr x22, [sp,#24]
		ldr x23, [sp,#32]
		ldr x24, [sp,#40]
		ldr x30, [sp,#48]
		ldr x28, [sp,#56]
		ldr x26, [sp,#64]
		add sp,sp,#80
		mov x0, #0
		mov x8, #sys_exit
		svc #0	
		ret

print_row:
		mov x3, x0
		mov x4, x1
		cmp x0, #1
		b.eq  .printdivider
		cmp x0, #2
		b.eq  .printlastdivider
		b .printrow1
	
.printdivider:
		mov x0, #stdout
		ldr x1, =divider
		mov x2, #26
		mov x8, #sys_write
		svc #0
		b  .rowloopend

.printlastdivider:
		mov x0, #stdout
		ldr x1, =divider
		mov x2, #26
		mov x8, #sys_write
		svc #0
		b  .end

.printrow1:
		mov x0, #stdout
		mov x2, #div_size
		mov x8, #sys_write
		svc #0
		mov x0, #0
		mov x8, #sys_exit
		add x20, x20, #1
		b .rowloop

		.data
divider:	.ascii "+-------+-------+-------+\n"
		.equ    div_size, .-divider
		.balign 8
	
template:	.ascii "| 1 2 3 | 4 5 6 | 7 8 9 |\n"
		.equ template_size, .-template
		.balign 8


