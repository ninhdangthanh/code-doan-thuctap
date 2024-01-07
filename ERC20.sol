// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyTokenOfNinh {
    string public name = "MyTokenOfNinh";
    string public symbol = "MTKON";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    mapping(address => uint256) public nonce;


    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(uint256 initialSupply) {
        totalSupply = initialSupply * 10**decimals;
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address to, uint256 value, uint256 userNonce) external returns (bool) {
        require(balanceOf[msg.sender] >= value, "Not enough balance");
        require(userNonce == nonce[msg.sender], "Invalid nonce");
        
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        nonce[msg.sender]++;

        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) external returns (bool) { // ủy quyền cho thằng khác(spender) có thể chuyển tiền trong tài khoản của mình với một số lượng nhất định
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        require(balanceOf[from] >= value, "Not enough balance");
        require(allowance[from][msg.sender] >= value, "Not enough allowance");
        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }
}