.globl	main
.data 	
    Input:	.string "Input the number:\n"
    Output:	.string "The damage:\n"	
.text
main:
	addi t6,zero,100
    	#begin
	la a0, Input		#print:input the number
    	li a7, 4
	ecall
    	li a7,5			#readInt
	ecall
	bge a0,t6,end 		#如果>=100的話就exit
    	jal function
    	
    	mv t0,a0		#把算出來的值a0放到t0
    	la a0,Output		#print:the damage
    	li a7,4
    	ecall
    	mv a0,t0		#把算出來的值放回a0
    	li a7,1			#print值
    	ecall
end:
	li a7,10
	ecall
function:
	add t1,zero,zero 
	blt a0,zero,case1	#x<0, return -1
	beq a0,zero,case2	#x==0, return 1
	addi t1,zero,1
	beq t1,a0,case3		#x==1, return 5
	addi t0,a0,-10
	bltz t0,case4		#1<x<=10
	addi t0,t0,-10
	bltz t0,case5		#10<x<=20
	
	j case6
case1:#x<0
	li a0, -1
	jalr x0, 0(ra)
case2:#x==0
	li a0,1
	jalr x0,0(ra)
case3:#x==1
	li a0,5
	jalr x0,0(ra)
case4:#1<x<=10
	addi sp,sp,-16		#設定stack pointer要放的東西
	sd ra,8(sp)		#放return address
	sd a0,0(sp)		#放input
	
	addi a0,a0,-1		#go to function(x-1)
	jal function
	
	ld t1,0(sp)		#load還沒-1的x
	sd a0,0(sp)		#把function(x-1)的值存到stack
	addi a0,t1,-2		#go to function(x-2)
	jal function
	
	ld t1,0(sp)		#把function(x-1)的load到t1
	add a0,a0,t1		#a0=function(x-2)+function(x-1)
	
	ld ra,8(sp)		#把return address叫出stack
	addi sp,sp,16		#把stack還回去
	jalr x0,0(ra)
case5:#10<x<=20
	addi sp,sp,-16		#設定stack pointer要放的東西
	sd ra,8(sp)		#放return address
	sd a0,0(sp)		#放input
	
	addi a0,a0,-2		#go to function(x-2)
	jal function
	
	ld t1,0(sp)		#load還沒-2的x
	sd a0,0(sp)		#把function(x-2)的值存到stack
	addi a0,t1,-3		#go to function(x-3)
	jal function
	
	ld t1,0(sp)		#把return address叫出stack
	add a0,a0,t1		#a0=function(x-2)+function(x-1)
	
	ld ra,8(sp)		#把return address叫出stack
	addi sp,sp,16		#把stack還回去
	jalr x0,0(ra)
case6:#x>20
	addi sp,sp,-16		#設定stack pointer要放的東西
	sd ra,8(sp)		#放return address
	sd a0,0(sp)		#放input
	
	addi t5,t5,5		#go to function(x/5)
	div a0,a0,t5		
	jal function
	
	ld t1,0(sp)		#load還沒/5的x
	
	addi t5,zero,2		#2x
	mul t1,t1,t5
	add a0,a0,t1		#把a0=2x+function(x/5)
	
	ld ra,8(sp)		#把return address叫出stack
	addi sp,sp,16		#把stack還回去
	jalr x0,0(ra)
	
