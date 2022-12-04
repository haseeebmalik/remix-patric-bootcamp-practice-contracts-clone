//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./1_SimpleStorage.sol";
contract StorageFactory{

 //This contract is for deploying and interecting with other contracts



    // SimpleStorage public simpleStorage;
    //or we can make an array of SimpleStorage contracts
    SimpleStorage[] public simpleStorageArray;


    function createSimpleStorageContract() public {
    //this will craete a new contract of SimpleStorage and deploy it .
       SimpleStorage simpleStorage=new SimpleStorage();
        simpleStorageArray.push(simpleStorage);

    }
    //this function is for intracting with SimpleStorage Contract
    function sfStore(uint256 _simpleStorageIndex,uint256 _simpleStorageNumber) public{
        //In order to intract with any contract we need two things.
        //1.Addess
        //2.ABI-Application Binary Interface

        // SimpleStorage simpleStorage=SimpleStorage(simpleStorageArray[_simpleStorageIndex]);
           //or
        // SimpleStorage simpleStorage=simpleStorageArray[_simpleStorageIndex];
        // simpleStorage.store(_simpleStorageNumber);
           //or
        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }
    //this function is for intracting with SimpleStorage Contract
    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        // SimpleStorage simpleStorage=simpleStorageArray[_simpleStorageIndex];
        // return simpleStorage.retrive();
           //or
        return simpleStorageArray[_simpleStorageIndex].retrive();
    }

}