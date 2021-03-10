                .global has_conflict_within
                .text

// has_conflict_within(board, get_within, major) -> 0 or 1
has_conflict_within:


			//lr =  set the link register or x30
			//x20 = board
			//x21 = get_within
			//x22 = major
			//x23 = used
			//x24 = index
			 
			
			//x0 = board
			//x1 = get_within
			//x2 = major
			//x3 = used
			//x4 = i
			//x6 = bit_position
			//x9 = 1 hepler for shift
									
			sub 	sp, sp, #48
			str 	x20,[sp,#0]
			str 	x21,[sp,#8]
			str	x22,[sp,#16]
			str	x23,[sp,#24]
			str	x24,[sp,#32]
			str	x30,[sp,#40]

			mov x20,x0
			mov x21,x1
			mov x22,x2
			mov x23,#0 //used = 0
			mov x24,#0 //i = 0
			


			b	.strloop


.loop:		

			//for i = 0; i < 9; i++
			add x24,x24,#1
			cmp x24,#9
			b.ge .ret0
			
.strloop:		
			// cell = get_within(board, major, i)
			mov x0,x20
			mov x1,x22
			mov x2,x24
			blr x21
			
			//if cell > 0:
			cmp x0,#0
			b.eq .loop
			mov x9,#1
			lsl x6,x9,x0 // bit_position = 1 << cell
			
			//  if used & bit_position != 0:
			and  x10,x23,x6
			cbnz  x10, .ret1 	
		
.check:
			orr x23,x23,x6 // used = use | bit_position
			b   .loop
			

.ret0:			
			
			mov x0,#0
			b  .end
.ret1:	
			mov x0,#1
			b  .end


.end:
			ldr x20,[sp,#0]
			ldr x21,[sp,#8]
			ldr x22,[sp,#16]
			ldr x23,[sp,#24]
			ldr x24,[sp,#32]
			ldr x30,[sp,#40]
			add sp,sp, #48
	
			ret





