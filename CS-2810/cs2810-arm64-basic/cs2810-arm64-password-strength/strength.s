                
.global strength

                .text
strength:
                

	 	mov x1, #0       //	lenght = 0
 		mov x2, #0	 //	haslower = 0
		mov x3, #0       //     hasupper = 0
		mov x4, #0       //     ch
		mov x5, #0	 //     hasdigit = 0
		mov x7, #0       //     score = 0
		mov x8, #0      // 	hassymbol = 0
			 


	.loop:		
			ldrb w4, [x0,x1]
  			cbz x4, .score
			add x1,x1, #1
			cmp x4, #'0'
			b.lt    .addsym
			cmp x4,#'9'
			b.le   .addnum
			cmp x4, #'A'
			b.lt   .addsym
			cmp x4, #'Z'
			b.le   .addupper
			cmp x4, #'a'
			b.lt   .addsym
			cmp x4, #'z'
			b.le   .addlower   // equal to z if greater than z goes to adssym 
			

	.addsym:	
			mov x8,#1
			b   .loop
		
	.addnum:	
			mov x5,#1
			b  .loop
	.addupper:	
			mov x3,#1
			b  .loop
	.addlower:	
			mov x2,#1
			b .loop
	.score:
			add  x7,x7,x2
			add  x7,x7,x3
			add  x7,x7,x5
			add  x7,x7,x8
		
	.length12:		
			cmp x1, #12
			b.lt .total
			add x7,x7, #1
		
			
	.length16:
			cmp x1, #16
			b.lt .total
			add x7,x7, #1
	 			
	.total:	
			mov x0,x7
			ret			
