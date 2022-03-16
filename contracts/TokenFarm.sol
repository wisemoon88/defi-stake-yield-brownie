//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract TokenFarm {
    //stake token
    //unstake token
    //issue token
    //add allowed token
    //getEthValue

    function stakeToken(uint256 _amount, address _token) public {
        require(_amount > 0, "amount not enough to stake");
    }
}
