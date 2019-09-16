/******************************************************************************
* file: max-min.s
* author: Sanjana Jammi, CS18M522
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/
@ BSS section
  .bss
  count_total : .word 9230
  min_value   : .word 9234
  max_value   : .word 9238

@ DATA SECTION
  .data
  data_items: .word 10, 4, 28, 100, 8, 0 ;@0 is used to terminate the data

@ TEXT section
  .text

.global _main

	 /* Finds the total number of items(excluding 0), min and max of the given elements
		Output - Stored in memory locations given above
		Registers with final output - r0 = Count, r1 = Min value, r2 = Max value 
		For the given input data - r0 = 5, r1 = 4, r2 = 100*/
_main:
      
	   // Initialize registers
      MOV r0, #0;          @ count    
	   MOV r1, #0;          @ min value    
	   MOV r2, #0;          @ max value    
	   
	   // Load first element, stop if the first element itself is 0
      LDR r4, =data_items;
	   LDR r3, [r4];	  
	   CMP r3, #0;
	   BEQ done;
	   
	   // Initialize min, max values to the first element initially
	   MOV r2, r3;          @ max value
	   MOV r1, r3;          @ min value
	   	
      // Looping through all the elements in the list		  
loop: ADD r4, r4, #4;
      LDR r3, [r4];    
      
	   CMP r3, #0;    
	   BEQ done;	        @ Break if 0 is encountered	  
	   
	   ADD r0, r0, #1;      @ Increment counter 
	   CMP r3, r1;    
	   MOVMI r1, r3;        @ Set current element as the min value if it is lesser than the existing min element
	  
	   CMP r3, r2;    
	   MOVPL r2, r3;        @ Set current element as the max value if it is greater than the existing max element
	   B loop;	            @ Repeat till 0 is encountered
  
      // Stop the pgm, store results in memory
done: LDR r4, =count_total;
	   STR r0, [r4];
	   LDR r4, =min_value;
	   STR r1, [r4];
	   LDR r4, =max_value;
	   STR r2, [r4];
	  