//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract SafeMathTester {
//in previous version then 0.8.0 ,if number is greater then its limit ,solidity will automatically assign the lowest value to it
//To prevent that we use safeMath library
//but for the version ^0.8.0 solidity it self check the number range the show error if number exceeds its limit.
//so we can use unchecked to stop solidity to do so for us for the version ^0.8.0
    uint8 public bigNumber=255;//checked

    function add() public {
        unchecked { bigNumber =bigNumber+1;}
    }
}