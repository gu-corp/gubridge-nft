pragma solidity 0.7.5;

import "../interfaces/IERC721TokenFactory.sol";

contract OmnibridgeMock {
  function deployERC721BridgeToken (
    address _factory, 
    string memory _name,
    string memory _symbol,
    bytes32 _salt,
    address owner_
  ) public {
    IERC721TokenFactory(_factory).deployERC721BridgeContract(_name, _symbol, _salt, owner_);
  }
}