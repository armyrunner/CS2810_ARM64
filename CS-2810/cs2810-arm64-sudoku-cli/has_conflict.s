                .global has_conflict
                .text

// has_conflict(board) -> 0 or 1
has_conflict:
                // your code goes here
                

		sub 	sp, sp, #64
		str 	x20,[sp,#0]
		str 	x21,[sp,#8]
		str	x22,[sp,#16]
		str	x23,[sp,#24]
		str	x24,[sp,#32]
		str	x25,[sp,#40]
		str	x30,[sp,#48]

 

		// x20 = board
		// x21 = i
		mov	x20,x0
		mov	x21,#0
		ldr	x22,=get_within_row
		ldr 	x23,=get_within_column
		ldr 	x24,=get_within_group
		ldr	x25,=has_conflict_within
		b	.begin
				
		//if has_conflict_within(board, get_within_row, i) != 0.
.loop:
		add 	x21,x21,#1
		cmp	x21,#9
		b.ge	.ret0


.begin:		mov 	x0,x20
		mov	x1,x22
		mov 	x2,x21
		blr	x25
		cbnz	x0,.ret1
		
		//if has_conflict_within(board, get_within_column, i) != 0:

.test2:
		mov 	x0,x20
		mov	x1,x23
		mov 	x2,x21
		blr	x25
		cbnz	x0,.ret1	
			

 		//if has_conflict_within(board, get_within_group, i) != 0:
.test3:
		mov 	x0,x20
		mov 	x1,x24
		mov 	x2,x21
		blr	x25
		cbnz	x0,.ret1
		b	.loop

.ret1:	
		mov	x0,#1
		b	.end

.ret0:		mov	x0,#0
		b	.end	

.end:
		ldr x20,[sp,#0]
		ldr x21,[sp,#8]
		ldr x22,[sp,#16]
		ldr x23,[sp,#24]
		ldr x24,[sp,#32]
		ldr x25,[sp,#40]
		ldr x30,[sp,#48]
		add sp,sp, #64
	
		ret




	
