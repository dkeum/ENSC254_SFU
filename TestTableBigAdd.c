// Table of Testing Data

// *** Put your names and studnet numbers here, similar to other files. ***
// Student Name 1 Jun Woo Keum
// Student 1 # 301335490
// Student 1 userid (email) dkeum (dkeum@sfu.ca)

// Student Name 2 Amirali Farzaneh
// Student 2 # 301292829
// Student 2 userid (email) afarzane (afarzane@sfu.ca)

// ** Handing this file in is optional but recommended.  
// ** Only hand it in if you have added/modified testcases.


	const int TestTableBigAdd[] = {
	// you can copy testcases from down below up here if you want them to run first

		0, 0, 0, 0, 			// bigN0 in 1st "row" of table
		0, 0, 0, 0, 			// bigN1
		0, 0, 0, 0, 0, 	// bigNR - expected result
		3, 	 						// maxN0Size								 
		0, 	 						// Check returned value				
		0,							// Testcase row ID
		
		1, 0, 0, 0, 			// 2nd "row" of table
		1, 0, 0, 0,
		1, 0, 0, 0, 0, 			// note, does not become 0, 0, 0, 0
		3, 	 						// maxN0Size								 
		0, 	 						// Check returned value								  
		1,							// Testcase row ID
		
		2, 0, 0, 0, 			// 3rd "row" of table
		1, 0, 0, 0,
		2, 0, 0, 0, 0, 
		3, 	 						// maxN0Size								 
		0, 	 						// Check returned value								  
		2,							// Testcase row ID
		
		1, 1, 0, 0, 			// 4th "row" of table
		1, 1, 0, 0,
		1, 2, 0, 0, 0,
		3, 	 						// maxN0Size								 
		0, 	 						// Check returned value								  
		3,							// Testcase row ID
		
		1, 0, 3, 0, 			// 5th "row" of table
		2, 0, 0, 0,
		2, 0, 0, 0, 0, 
		3, 	 						// maxN0Size								 
		0, 	 						// Check returned value								  
		4,							// Testcase row ID
		
		1, 0x80000000, 0, 0, 		// 6th "row" of table
		1, 0x80000000, 0, 0,
		2, 0x00000000, 1, 0, 0,
		3, 	 						// maxN0Size								 
		0, 	 						// Check returned value								  
		5,							// Testcase row ID
		
		2, 0x80000000, 0xFFFFFFFF, 0, 	// "row" 7 of table
		1, 0x80000000, 0x00000000, 0, 
		3, 0x00000000, 0x00000000, 1, 0, 
		3, 	 						// maxN0Size								 
		0, 	 						// Check returned value								  
		6,							// Testcase row ID
		
		1, 4, 0, 0, 			// 8th "row" of table
		2, 5, 0, 0,
		2, 9, 0, 0, 0, 
		3, 	 						// maxN0Size								 
		0, 	 						// Check returned value								  
		7,							// Testcase row ID
		
		1, 0x80000000, 0x00000000, 0, 	// 9th "row" of table
		2, 0x80000000, 0xFFFFFFFF, 0,
		3, 0x00000000, 0x00000000, 1, 0, 
		3,                                    
		0,                                   
		8,							// Testcase row ID

		2, 0x80000000, 0x00000000, 0x00000000 , 		// "row" 10 of table
		3, 0x80000000, 0xFFFFFFFF, 0xFFFFFFFF,
		3, 0x00000000, 0x00000000, 0x00000000, 0,
		3, 						// maxN0Size			  
		1, 						// Check returned value				  
		9,							// Testcase row ID
		
		3, 0x80000000, 0xFFFFFFFF, 0xFFFFFFFF, 		// "row" 11 of table
		1, 0x80000000, 0x00000000, 0x00000000, 
		3, 0x00000000, 0x00000000, 0x00000000, 0,
		3, 						// maxN0Size			  
		1, 						// Check returned value			  
		10,							// Testcase row ID
		
		1, 0, 0, 0 			, 		// "row" 12 of table
		4, 0, 0, 0,
		4, 0, 0, 0, 0,
		3, 						// maxN0Size			  
		-1, 						// Check returned value			 
		11,							// Testcase row ID
		
		4, 0x80000000, 0xFFFFFFFF, 0xFFFFFFFF, 		// "row" 13 of table
		1, 0x80000000, 0x00000000, 0x00000000, 
		4, 0x00000000, 0x00000000, 0x00000000, 0,
		3                       , 			// maxN0Size
		-1                      , 			// Check returned value
		12,							// Testcase row ID

		3, 0x80000000, 0xFFFFFFFF, 0xFFFFFFFF , 		// "row" 14 of table
		1, 0x80000000, 0x00000000, 0x00000000, 
		4, 0x00000000, 0x00000000, 0x00000000, 1, 
		4                       , 			// maxN0Size
		0                      , 			// Check returned value
		13,							// Testcase row ID
		
		1, 0x80000000, 0x00000000, 0x00000000 , 		// "row" 15 of table
		3, 0x80000000, 0xFFFFFFFF, 0xFFFFFFFF, 
		4, 0x00000000, 0x00000000, 0x00000000, 1, 
		4                       , 			// maxN0Size
		0                      , 			// Check returned value
		14,							// Testcase row ID
		
		1, 0x90000000, 0, 0 , 		// "row" 16 of table
		1, 0x80000000, 0, 0, 
		2, 0x10000000, 1, 0, 0, 
		3                       , 			// maxN0Size
		0                      , 			// Check returned value
		15,							// Testcase row ID
		
		1, 0x90000000, 0, 0 , 		// "row" 17 of table
		1, 0xE0000000, 0, 0, 
		2, 0x70000000, 1, 0, 0, 
		2                       , 			// maxN0Size
		0                      , 			// Check returned value
		16,							// Testcase row ID
		
		0, 0x90000000, 0, 0 , 		// "row" 18 of table
		1, 0xE0000000, 0, 0, 
		1, 0xE0000000, 0, 0, 0, 
		2                       , 			// maxN0Size
		0                      , 			// Check returned value
		17,							// Testcase row ID
		
		1, 0x90000000, 0, 0 , 		// "row" 19 of table
		0, 0xE0000000, 0, 0, 
		1, 0x90000000, 0, 0, 0, 
		1                       , 			// maxN0Size
		0                      , 			// Check returned value
		18,							// Testcase row ID
		
		1, 0x80000000, 0x00000000, 0x00000000 , 		// "row" 20 of table
		3, 0x80000000, 0xFFFFFFFF, 0xFFFFFFFF, 
		4, 0x00000000, 0x00000000, 0x00000000, 1, 
		4                       , 			// maxN0Size
		0                      , 			// Check returned value
		19,							// Testcase row ID

		-1,					// end of testing table
		0, 0, 0			// these bytes are loaded into registers
	};
