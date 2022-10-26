// SPDX-License-Identifier: MIT
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
        _lzSend({
            _dstChainId: destChainId, 
            _payload: payload, 
            _refundAddress: payable(msg.sender), 
            _zroPaymentAddress: address(0x0), 
            _adapterParams: bytes(""), 
            _nativeFee: msg.value}
        );
    }
}

// Moonbase Alpha: 0xCaE75D43cFd8e26ab44cc4f95dBcF3438015F462
// Fantom Testnet: 0x86D5C5b145C782D94383f170f5080BbA104D3D25
