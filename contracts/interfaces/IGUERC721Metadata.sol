pragma solidity ^0.7.0;

interface IGUERC721Metadata {
    function salt() external view returns (bytes32);
    function owner() external view returns (address);
}