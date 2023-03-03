pragma solidity ^0.7.0;

interface IGUERC721Metadata {
    function id() external view returns (uint256);
    function owner() external view returns (address);
    function implementation() external view returns (address);
}