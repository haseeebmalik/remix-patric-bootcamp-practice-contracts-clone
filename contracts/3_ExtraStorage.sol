//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./1_SimpleStorage.sol";
contract ExtraStorage is SimpleStorage{

    //In this contract we will learn inheritance and modifiers
function store(uint256 _favoriteNumber) public override {
    favouriteNumber=_favoriteNumber+5;
}


}