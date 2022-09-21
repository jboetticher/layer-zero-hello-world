// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.12;

import "./LayerZero/lzApp/NonblockingLzApp.sol";

contract HelloWorldMessageLZ is NonblockingLzApp {
    using BytesLib for bytes;

    mapping(address => string) public lastMessage;

    constructor(address _lzEndpoint) NonblockingLzApp(_lzEndpoint) {}

    function _nonblockingLzReceive(uint16, bytes memory, uint64, bytes memory _payload) override internal {
        (address sender, string memory message) = abi.decode(_payload, (address, string));
        lastMessage[sender] = message;
    }

    function sendMessage(string memory message, uint16 destChainId) external payable {
        bytes memory payload = abi.encode(msg.sender, message);
        _lzSend(destChainId, payload, payable(msg.sender), address(0x0), bytes(""), msg.value);
    }
}

// Moonbase Alpha: 0x2dCBc8a932E62712dd6a26A4F38Fe4Ff1E4F6C22
// Fantom Testnet: 0xa57194Dda16d7ec147A13E5Af28d52190A6d5461
