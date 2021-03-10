                .global get_within_column
                .text

// get_within_column(board, column, n)
get_within_column:
                // your code goes here
                



		//x0 = board
		//x1 = column
		//x2 = n
		//x3 = index
		//x4 = 9
		//x5 = board value


		mov 	x3, #0
		mov 	x4, #9
		mul	x3, x2, x4
		add 	x3, x3, x1
		ldrb 	w5, [x0,x3]
		mov	x0, x5

		ret
