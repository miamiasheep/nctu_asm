// final project(matrix).cpp : 定義主控台應用程式的進入點。
//

#include<iostream>
#include<stdio.h>
#include<time.h>
#define test 1000000
using namespace std;
extern "C"
	{
	  void mul_ASM_naive(short[4],short[4][8],short[8]);
		//void mul_ASM_naive(short);
	  void mul_ASM_SSE2(short[4],short[4][8],short[8]);
		
	}

 
__declspec(align(16))
short VectorA[4]={1,2,4,8},
MatrixB[4][8]={1 ,2 ,3 ,4 ,5 ,6 ,7 ,8,9 ,10,11,12,13,14,15,16
              ,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32},VectorC[8];
void mul(short VectorA[4],short MatrixB[4][8],short VectorC[8]){
for(int i=0;i<8;i++){
		 VectorC[i]=0;
		 for(int j=0;j<4;j++){
		   VectorC[i]=VectorC[i]+VectorA[j]*MatrixB[j][i];
		 }
	 }
}			 
int main(void)
{ 
	int start,finish,total;

	cout<<"c Language:\n";
	 start=clock();
	 for(int i=0;i<test;i++)
	 mul(VectorA,MatrixB,VectorC);
	 finish=clock();
	 total =finish-start;
	
	 for(int i=0;i<8;i++)printf("%hu ",VectorC[i]);
	 cout <<endl;
	 cout<<"execution time:"<<total<<endl;
	 cout<<endl;
	 cout<<"asm naive:\n";
	 
	 start=clock();
	 for(int i=0;i<test;i++)
     mul_ASM_naive(VectorA,MatrixB,VectorC);
	 finish=clock();
	 total=finish-start;
	
      for(int i=0;i<8;i++)printf("%hu ",VectorC[i]);
	  cout <<endl;
     cout<<"execution time:"<<total <<endl;
	 cout<<endl;
	cout<<"ASM SSE2\n";
	
	start=clock();
	 for(int i=0;i<test;i++)
		 mul_ASM_SSE2(VectorA,MatrixB,VectorC);
	 finish=clock();
	 total=finish-start;
	 
	for(int i=0;i<8;i++)printf("%hu ",VectorC[i]);
	cout<<endl;
	cout<<"execution time: "<<total<<endl;
	cout <<endl;
	return 0;
}

