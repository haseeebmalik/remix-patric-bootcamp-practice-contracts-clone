//Get funds from users
//Withdraw funds
//Set a minimum funding value in USD


//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./5_PriceConverter.sol";

//custom error instead of storing a string in revert,because string will cost way more gas.

error NotOwner();

contract FundMe {
    //this is library
    using PriceConverter for uint256;
    //this is equal to 50 dollers.
    //constants and immutable are keyword we use for the variables which are dont change in the app
    //we can also use these two variables for the variable in constructor.
    //basically these are used to optimize gas for contract execution.
uint256 public constant MINIMUM_USD=50 * 1e18;
  //21,415 gas -execution cost of calling MINIMUM_USD function with constant
  //23,515 gas -execution cost of calling MINIMUM_USD function without constant 
//21,415*141000000000 =$9.058545
//23,515*141000000000 =$9.946845
//without const the calling of MINIMUM_USD function will cost almost 1doller more.

address[] public funders;
mapping(address=>uint256) public addressToAmountFunded;
    address public immutable i_owner;

    //21,508 gas -execution cost of calling i_owner function with immutable
    //23,644 gas -execution cost of calling i_owner function without immutable 


//the reason why constant and immutable will cost less gas because instead of storing them in storage slot, we will save them directaly store them into byte code of the contract.
    constructor(){
        i_owner=msg.sender;
    }
    function fund() public payable{

        //Want to be able to set a minimum fund amount in USD.
        //How do we send eath to this account
        // require(msg.value>1e18,"Didn't send enough");
      
       
       

        // require(getConversionRate(msg.value)>=MINIMUM_USD,"Didn't send enough");
                     //or with library
                      //here msg.value is automatically send as first parameter in getConcersionRate function.
           require(msg.value.getConversionRate()>=MINIMUM_USD,"Didn't send enough");
                
                 //18 decimals
        //What is reverting?
        //Undo any action before, and send remaining gas back.
      
     //msg.sender is a global function which is the address of the user which calls this function
      funders.push(msg.sender);
      addressToAmountFunded[msg.sender]+=msg.value;
    }


    function withdraw() public onlyOwner{
        //but if we have many functions which need to be a sender, then we need modifiers.
    //   require(msg.sender==i_owner,"Sender is not owner.");
        for(uint256 funderIndex=0;funderIndex<funders.length;funderIndex++){
            address funder=funders[funderIndex];
            addressToAmountFunded[funder]=0;

        }
        //reset the funders array with zero element
        funders=new address[](0);
        //Now withdraw the funds

        //There are three ways to transfer funds from contract
         //1. transfer
         //2. send
         //3. call

         //msg.sender= address
         //payable(msg.sender)= payable address
         //here "this" keyword is the balance of this whole contract.
                  //transfer will revert back transaction if it fails
        //  payable(msg.sender).transfer(address(this).balance);
        //           // send will not revert transaction but returns a bool
        //  bool sendSuccess =payable(msg.sender).send(address(this).balance);
        //      //Now we have to revert transaction ourself
        //      require(sendSuccess, "Send failed.");

                  //call is the best method to send and receive tokens
                   //because "dataReturn" is an array so we give it memory
                (bool callSuccess , bytes memory dataReturn)=payable(msg.sender).call{value: address(this).balance}("");
              require(callSuccess,"call Failed.");
    }

    modifier onlyOwner {
        // require(msg.sender==i_owner,"Sender is not owner.");
        
        if(msg.sender!=i_owner){revert NotOwner();}
      _;
    }

    //what happens if someone sends this contract eth without calling the fund function
    //if some one call a function of a contract which is not present ,then receive function trigger automatically

    //receive
    //fallback

    receive() external payable {
       fund();
    }

    fallback() external payable {
       fund();
    }
   
}