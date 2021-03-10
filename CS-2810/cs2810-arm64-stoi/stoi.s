                .global stoi
                .text
stoi: 		
		// initial values to registrars
				
      		mov x1,#0	        //  n =0
		mov x2,#0		//  c
		mov x3,#0		// length of c
		mov x4,#10		// sets for mulitply
		mov x5,#0		// keeps track of neg sign
		mov x6,#0		// helper register

.loop:		
		ldrb w2,[x0,x3]		 //c = input
		cmp x2,#'-'
		b.eq .negval
		b   .calc 	
.negval:
		cmp x3, #1
		b.ge .calc
		mov x5,#1
		add x3,x3,#1
		b   .loop

.calc:
		cmp x2, #'0'		 //If c <0
		b.lt .div		 //goto end
		cmp x2, #'9'
		b.gt .div	 //if c > 9
		
		sub x2,x2,#'0'
		add x1,x1,x2
		mul x1,x1,x4
		add x3,x3,#1
	   	b	.loop	


.div:	
		sdiv x1,x1,x4
		cmp x5, #1
		b.ne .end
		sub x1,x6,x1
		
.end:
		mov x0,x1			//return n
                ret
