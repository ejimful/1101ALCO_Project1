main
	1.輸出"Input a number:"後輸入x
	2.判斷x是否>=100，成立就exit
	3.跳到funtion
	4.回來後輸出"The damage:"，接著輸出最後算出來的值(a0)。
function
	從0開始判斷，若x符合條件就跳去相應的case。
case
	1.case分為六種:1.x<0、2.x==0、3.x==1、4.1<x<=10、5.10<x<=20、6.x>20。
	2.在每個case4~case6中，stack會開2個64-bit doubleword，用來存a0(計算的值)和return address。