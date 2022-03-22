//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenFarm is Ownable {
    // need mapping of token address -> staker address -> amount
    mapping(address => mapping(address => uint256)) public stakingBalance;
    mapping(address => uint256) public uniqueTokensStaked;
    address[] public stakers; //this list is so that we can capture the list of stakers for that particular token

    //stake token
    //unstake token
    //issue token
    //add allowed token
    //getEthValue
    address[] public allowedTokens; //this is a list of allowed tokens to be staked

    //function that will issue token as a reward for staking. for 1 ether give 1 dapptoken, for dai, need to covnert to eth first and then provide 1 dapptoken
    function issueTokens() public onlyOwner {
        for (
            uint256 stakersIndex = 0;
            stakersIndex < stakers.length;
            stakersIndex++
        ) {
            address recipient = stakers[stakersIndex];
            //send them token reward based on total value locked
        }
    }

    //function takes in amount to stake and the token contract address
    function stakeToken(uint256 _amount, address _token) public {
        //what types of token can they stake?
        //how much can they stake?

        require(_amount > 0, "amount not enough to stake");
        require(tokenIsAllowed(_token), "token is not allowed");
        //need to call transferfrom function since token farm contract does not own the token
        IERC20(_token).transferFrom(msg.sender, address(this), _amount); //using IERC20 interface to get abi, provide token address as argument, hence contract call complete thus can call transfer from function
        updateUniqueTokensStaked(msg.sender, _token); //calling function to check whether token currently staked is unique or not
        stakingBalance[_token][msg.sender] =
            stakingBalance[_token][msg.sender] +
            _amount;
        if (uniqueTokensStaked[msg.sender] == 1) {
            stakers.push(msg.sender);
        }
    }

    //function to determine if token staked is unique or not and therefore if needed to update the stakes list
    function updateUniqueTokensStaked(address _user, address _token) internal {
        //is internal so only this contract can call the function
        if (stakingBalance[_token][_user] <= 0) {
            uniqueTokensStaked[_user] = uniqueTokensStaked[_user] + 1;
        }
    }

    //function that adds the allowed tokens that can be staked
    function addAllowedTokens(address _token) public onlyOwner {
        allowedTokens.push(_token);
    }

    //create a function that defines what tokens are allowed to be staked
    function tokenIsAllowed(address _token) public returns (bool) {
        for (
            uint256 allowedTokensIndex = 0;
            allowedTokensIndex < allowedTokens.length;
            allowedTokensIndex++
        ) {
            if (allowedTokens[allowedTokensIndex] == _token) {
                return true;
            }
        }
        return false;
    }
}
