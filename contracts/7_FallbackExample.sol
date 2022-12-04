 //SPDX-License-identifier: MIT

 contract FallbackExample {

     uint256 public result;
//this receive function is trigger every time we send a transaction to this contract and we dont specify a function of the contract and we keep the calldata blank.
     receive() external payable{
         result=1;
     }
 //In calldata there is actually functions ,so if you dont specify a wrong function and give some wrong call data ,solidity will take you to fallBack function.
     fallback() external payable {
         result=2;
     }

 }