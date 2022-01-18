/******************************************************************************
;@
;@ Student Name 1 Jun Woo Keum
;@ Student 1 # 301335490
;@ Student 1 userid (email) dkeum (dkeum@sfu.ca)
;@
;@ Student Name 2 Amirali Farzaneh
;@ Student 2 # 301292829
;@ Student 2 userid (email) afarzane (afarzane@sfu.ca)
;@
;@ Below, edit to list any people who helped you with the code in this file,
;@      or put ‘none’ if nobody helped (the two of) you.
;@
;@ Helpers: _everybody helped us/me with the assignment (list names or put ‘none’)__
;@
;@ Also, reference resources beyond the course textbooks and the course pages on Canvas
;@ that you used in making your submission.
;@
;@ Resources:  ___________
;@
;@% Instructions:
;@ * Put your name(s), student number(s), userid(s) in the above section.
;@ * Edit the "Helpers" line and "Resources" line.
;@ * Your group name should be "<userid1>_<userid2>" (eg. stu1_stu2)
;@ * Form groups as described at:  https://courses.cs.sfu.ca/docs/students
;@ * Submit your file to courses.cs.sfu.ca
;@
;@ Name        : BigFib.c
;@ Description : bigFib subroutine for HW5.
******************************************************************************/

#include <stdlib.h>
#include <errno.h>
#include <stdio.h>

typedef unsigned int bigNumN[];

int bigAdd(bigNumN bigN0P, const bigNumN bigN1P, unsigned int maxN0Size);

int bigFib(int n, int maxSize, unsigned **bNP){

	unsigned* bNa = malloc(4*(1 + maxSize));
	// check for null pointer being returned.
	unsigned* bNb = malloc(4*(1 + maxSize));
	// check for null pointer being returned.

	unsigned int *bTemp= bNa;
	unsigned temp= 0;	
	unsigned int temp3= 0;
	int j = 0;
	

// n and MaxSize is greater than or equal to zero
	if( n <0 || maxSize <0){
		free(bNa);
		free(bNb);
		errno = EINVAL; 
		return	-1; 
	}

		
	// ... fill in code here ****


	if(bNP==NULL){
			errno = EINVAL; 
			free(bNb);
			free(bNa);
			return	-1; 
		}
	// no valid word means no computing 
	if(maxSize == 0){
		bigAdd(bNa,bNb,maxSize);
		*bNP= bNa;
		free(bNb);
		return 0;
	}
 
//if malloc was successful	
	if (bNa && bNb){ 

		// initialize fibonacci numbers at starting address of bNa and bNb
		// need to initialize most significant bit with valid word number
		*bNa = 1;
		*bNb = 1; 

		bTemp=bNa+1; //next the intialized value at one word after the maxSize word
		*bTemp= 0; 
		
		bTemp=bNb+1;
		*bTemp= 1; 
		
			temp =0; 

if(n==2){
	*bNa =1;
// for loop for fibonacci
	bTemp=bNa+1; //next the intialized value at one word after the maxSize word
	*bTemp= 0; 
		
	bTemp=bNb+1;
	*bTemp= 1; 
	for(int i = 1; i < n; i++){


	bTemp = bNa+1;
	temp = 	*(bTemp);

		int j = bigAdd(bNa,bNb,maxSize);

	//passed case j==0 do nothing
	//params are wack or overflow case
		if(j== -1){
			//free memory
			free(bNb);
			return EINVAL;  
		}

		if(j==1){
			free(bNb);
			return	i+1;
		}
			if(i >=1){
				bTemp = bNb+1;
				*bTemp = temp;
			}
	}	
}




if(n>=3){


/// initializing values////
// for loop for fibonacci
	bTemp=bNa+1; //next the intialized value at one word after the maxSize word
	*bTemp= 1; 
		
	bTemp=bNb+1;
	*bTemp= 1; 



// Calculate Fib_n ///
	for(int i = 3; i <= n; i++){


	if(i%2==1){
		j = bigAdd(bNa,bNb,*(bNa+1));
	}
	else{
		j = bigAdd(bNb,bNa,*(bNa+1));
		}
		
	//	printf("AFTER value of i: %d \n the value of bNa is : %d \n the value of bNb is : %d\n ", i, (unsigned int)*(bNa),*(bNb));
	//	printf("value of j: %d\n for index i: %d\n",j,i);
	
		if(*(bNa)> maxSize){
						//*bTemp = *(bNb);
						//bTemp = bNa+1; 
						//*bTemp = *(bNb+1); 
					  //*bNP = bNa;
						//free(bNb);
						//bNb = bNa;
						
						*bNP = bNb;
						free(bNa);
						bTemp = bNa-1;
						*bTemp = 8172;
						
						return	i-1;
		}

		if(*(bNb)> maxSize){			
						*bNP = bNa;
						free(bNb);
						return	i-1;
		}

	//params are wack or overflow case
		if(j== -1){
			//free memory
			free(bNb);
			return EINVAL;  
		}

	//overflow case
			if(j==1){


				bTemp = bNa;
				temp3 = *bTemp;
				printf("value of size so far: %d",temp3 );
					if( temp3 < maxSize){
						*bTemp+=1;	
						bTemp = bNb;
						*bTemp+=1;	
					}
				else{
					//bTemp = bNa+1;
					//*bTemp = temp;
					*bNP = bNa;
					free(bNb);
					return	i-1;
				}
		}
	}	
}





if(n==1){
	*bNa =1;
// for loop for fibonacci
	for(int i = 0; i < n; i++){
		int j = bigAdd(bNa,bNb,maxSize);

	//passed case j==0 do nothing
	//params are wack or overflow case
		if(j== -1 || j==1){
			//free memory
			free(bNb);
			return EINVAL;  
		}
	}	
}
	}
// not enough malloc memory
	else{
		errno = ENOMEM;
		free(bNb);
		free(bNa);
		return -1;
}

	// The following two lines of code are just examples.
	// You might not always want to do them.
   // set address if there is no overflow and no error 


	
	*bNP = bNa; // don't forget to free the other allocated memory
		free(bNb);
	return n;
}

