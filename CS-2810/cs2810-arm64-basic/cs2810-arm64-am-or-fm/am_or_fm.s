                .global am_or_fm
		

                .text
am_or_fm:                
	.testam:
		cmp x0, #535
		b.lt .testfm		
		cmp x0, #1605
		b.gt .done
		mov x0, #1
                ret
	.testfm:
		cmp x0, #88
		b.lt .done
		cmp x0, #108
		b.gt .done
		mov x0, #2
                ret
	.done:		
		mov x0, #0
		ret
			
