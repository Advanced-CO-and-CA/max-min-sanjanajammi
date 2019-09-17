/******************************************************************************
* file: max-min_optimized.s
* author: Sanjana Jammi, CS18M522
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/
@ BSS section
  .bss
  
@ DATA SECTION
  .data  
  data_items    : .word 10, 4, 28, 0, 100, 8
  data_items_end: .word 0
  length        : .word (data_items_end - data_items)/4
  
  count_total   : .word 9230
  min_value     : .word 9234
  max_value     : .word 9238


@ TEXT section
  .text

.global _main

	 /* Finds the total number of items in the array(0 not used as a terminating condition here, can have 0 as an array element too), min and max of the given elements
		Output - Stored in memory locations given above
		Registers with final output - r0 = Count, r1 = Min value, r2 = Max value 
		For the given input data - r0 = 6, r1 = 0, r2 = 100*/
_main:
      	  
	   EOR r2, r2, r2;      @ max value, initialized to 0
	   EOR r1, r1, r1;      @ min value, initialized to 0
	   
	   // Load length, if length is 0, stop execution
	   LDR r4, =length;
	   LDR r0, [r4];        @ loading the value to register r0 to avoid memory reads each time
	   MOV r5, r0;          @ using this as a counter
	   
	   CMP r0, #0;
	   BEQ done;	        @ Break if 0 is encountered
	   
	   
	   LDR r4, =data_items; @ load data_items starting address
	   	
       // Looping through all the elements in the list 
loop:      LDR r3, [r4], #4;
	   	  
	   CMP r3, r1;
	   MOVMI r1, r3;        @ Set current element as the min value if it is lesser than the existing min element
	   CMP r3, r2;
	   MOVPL r2, r3;        @ Set current element as the max value if it is greater than the existing max element
	   
	   SUBS r5, r5, #1;     @ Decrement counter
	   BNE loop;	        @ Repeat till counter comes to 0
	   
       // Stop the pgm, store results in memory
done:      LDR r4, =count_total;
           STR r0, [r4];
	   LDR r4, =min_value;
	   STR r1, [r4];
	   LDR r4, =max_value;
	   STR r2, [r4];
	  