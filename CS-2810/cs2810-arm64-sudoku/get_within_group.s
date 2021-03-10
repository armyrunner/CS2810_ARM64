                .global get_within_group
                .text

// get_within_group(board, group, n)
get_within_group:
                // your code goes here
                

		//x0 = board
		//x1 - group
		//x2 = n
		//x3 = 3
		//x4 = row
		//x5 = column	
		//x6 = Index
		//x7 = mulitiply value
		//x9 = division value
		//x10 = remainder
		//x11 = modulus
		//x12 = 9
		//x13 = board value
	
		// registers used
		mov x3, #3
		mov x6, #0
		mov x12, #9

		// row 
		
		udiv 	x4, x1, x3  	// (group / 3)
		mul 	x4, x4, x3
		udiv 	x7, x2, x3 	// ( n / 3)
		add 	x4, x4, x7
		
		// column 
		udiv 	x9,  x1, x3 	//(group % 3)
		mul 	x10, x9, x3
		sub	x5,  x1, x10
		mul	x5,  x5, x3
		
		udiv	x9,  x2, x3	//(n % 3)
		mul	x10, x9, x3
		sub	x11, x2, x10
		add	x5,  x5, x11

		// Index
		mul x6, x4, x12
		add x6, x5, x6
		ldrb w13, [x0,x6]
		mov x0, x13

		ret
