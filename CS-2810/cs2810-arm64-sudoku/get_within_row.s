                .global get_within_row
                .text

// get_within_row(board, row, n)
get_within_row:
                
		//x0 = board
		//x1 = row
		//x2 = n
		//x3 = index
		//x4 = 9
		//x5 = board value
		


		mov 	x3, #0
		mov 	x4, #9
		mul	x3, x1, x4
		add 	x3, x3, x2
		ldrb 	w5, [x0,x3]
		mov 	x0, x5
		ret
 	

		
		


		

		//def get_within_row(board, row, n):
   		//	 index = row * 9 + n
   		//	 return board[index]
		//wzr is the 32 bit version register 
		// db memory watch $x0 32

