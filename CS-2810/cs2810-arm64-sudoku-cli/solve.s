                .global solve
                .text

// solve(board) -> 0 for success, 1 for failure
// on success, the board will be solved
// on failure, the board will be unchanged
solve:
                // your code goes here

		
		sub 	sp, sp, #64
		str 	x20,[sp,#0]  //board
		str 	x21,[sp,#8]  //i
		str	x22,[sp,#16]	// n
		str	x23,[sp,#24]	// board[i]
		str	x24,[sp,#32]	
		str	x25,[sp,#40]
		str	lr,[sp,#48]
		//if has_conflict(board) != 0

		mov	x20,x0	//board
		mov	x21,#0	//i
		mov	x22,#1	//n
		mov	x23,#0	//board[i]
		ldr	x24, =has_conflict
		ldr 	x25, =solve


		mov 	x0,x20
		bl	has_conflict
		cbnz	x0,.end

.loop1:		
							//for(i=0;i<81;i++)
		cmp	x21,#81
		b.lt	.board
		mov 	x0,#0
		b	.end

.board:
		ldrb	w23,[x20,x21]	//if board[i] !=0
		cbz	x23,.loop2

.nxti:
		add 	x21,x21,#1
		b	.loop1	

.loop2:	
		
		cmp	x22,#10
		b.ge	.final
		strb	w22,[x20,x21]
		mov	x0,x20
		bl	solve
		cbz	x0,.end
		add	x22,x22,#1
		b	.loop2


.final:		
		mov	x7,#0
		strb	w7,[x20,x21]
		mov	x0,#1

.end:	
	
		ldr x20,[sp,#0]
		ldr x21,[sp,#8]
		ldr x22,[sp,#16]
		ldr x23,[sp,#24]
		ldr x24,[sp,#32]
		ldr x25,[sp,#40]
		ldr lr,[sp,#48]
		add sp,sp, #64
	
		ret
