int n = 16; 
int k = 0;
bool finished = 0;  

active proctype log() 
{ 
	int m = n; 
	assert n > 0;
	do 
		:: m >= 2 -> 
			m = m/2; 
			k = k + 1 
		:: else -> break 
	od; 
	assert true;
	
	finished = 1; 
}

init
{
	finished == 1; //wait for log calculation

	int powk = 1;
	int i = 0;
	
	//calculate 2^k
	do 
		:: i < k -> 
			powk = powk * 2; 
			i = i + 1 
		:: else -> break 
	od;

	//assert post condition 	
	assert ( powk <= n && n <= powk*2);
}
