                .global read_board
                .text

// read_board(*input, *board) ->
//     0 for success
//     1 for input too short
//     2 for input contains invalid character
//     3 for input too long
read_board:

		//x0: input
		//x1: bouard
		//x2: i
		//x3: ch
		mov x2, #0


.loop:		
		ldrb w3,[x0,x2]
		cbnz x3, .checkdot		 // check to see if it is not zero to move to the next section
		mov x0,#1
		ret
		
.checkdot:
		cmp x3,#'.'   			// check to see if there is a dot
		b.ne  .checkdigit		// if it is not equal check for a digit
		strb wzr, [x1,x2]
		b  .nexti
.checkdigit:
		
		cmp x3, #'1'
		b.lt .invalidchar
		cmp x3, #'9'
		b.gt .invalidchar
		sub x3,x3,#'0'
		strb w3, [x1,x2]
		b  .nexti

.invalidchar:
		mov x0,#2
		ret


.nexti:		
		
		add x2,x2, #1
		cmp x2, #81
		b.lt   .loop
		
		ldrb w3,[x0,x2]
		cbz x3, .success
		mov x0, #3
		ret

.success:
		mov x0, #0
		ret



			

