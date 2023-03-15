pragma solidity 0.7.5;

interface IERC721TokenFactory {
    function deployERC721BridgeContract(
        string memory _name,
        string memory _symbol,
        bytes32 _salt,
        address owner_
    ) external returns (address);

    function nativeTokenOf(bytes32 salt_) external view returns (address);
}
