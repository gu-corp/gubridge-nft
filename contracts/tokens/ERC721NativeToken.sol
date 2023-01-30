pragma solidity 0.7.5;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "../common/ERC2981.sol";

import "../interfaces/IOwnable.sol";

contract ERC721NativeToken is ERC721, ERC2981 {
    using Counters for Counters.Counter;

    address private bridgeContract;
    address private _factory;
    uint256 private _id;
    address private _owner;
    Counters.Counter private _tokenIdCounter;

    constructor(
        string memory _name,
        string memory _symbol,
        address owner_
    ) ERC721(_name, _symbol) {
        _owner = owner_;
    }

    function id() public view returns(uint256) {
        return _id;
    }

    modifier onlyFactory() {
        require(msg.sender == _factory);
        _;
    } 

    modifier onlyFactoryOwner() {
        require(msg.sender == IOwnable(_factory).owner());
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == _owner);
        _;
    }

    function owner() public view returns (address) {
        return _owner;
    }

    function factory () public view returns (address) {
        return _factory;
    }

    function mint(address _to, string memory _uri) external onlyOwner {
        _tokenIdCounter.increment();
        uint256 _tokenId = _tokenIdCounter.current();

        _safeMint(_to, _tokenId);
        _setTokenURI(_tokenId, _uri);
    }

    function setTokenFactory(address factory_) external onlyFactoryOwner {
        require(_factory != address(0));
        _factory = factory_;
    }

    /**
     * @dev Tells if this contract implements the interface defined by
     * `interfaceId`. See the corresponding EIP165.
     * @return true, if interface is implemented.
     */
    function supportsInterface(bytes4 interfaceId) public view override(ERC2981, ERC165) returns (bool) {
        bytes4 INTERFACE_ID_ERC165 = 0x01ffc9a7;
        bytes4 INTERFACE_ID_ERC721 = 0x80ac58cd;
        bytes4 INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;
        bytes4 INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;
        bytes4 INTERFACE_ID_ERC2981 = 0x2a55205a;
        return
            interfaceId == INTERFACE_ID_ERC165 ||
            interfaceId == INTERFACE_ID_ERC721 ||
            interfaceId == INTERFACE_ID_ERC721_METADATA ||
            interfaceId == INTERFACE_ID_ERC721_ENUMERABLE ||
            interfaceId == INTERFACE_ID_ERC2981;
    }

    function setDefaultRoyalty(address receiver, uint96 feeNumerator) public onlyOwner {
        _setDefaultRoyalty(receiver, feeNumerator);
    }

    function deleteDefaultRoyalty() public onlyOwner {
        _deleteDefaultRoyalty();
    }

    function setTokenRoyalty(uint256 tokenId, address receiver, uint96 feeNumerator) public onlyOwner {
        _setTokenRoyalty(tokenId, receiver, feeNumerator);
    }

    function resetTokenRoyalty(uint256 tokenId) public onlyOwner {
        _resetTokenRoyalty(tokenId);
    }

    function defaultRoyaltyInfo() public view returns(address, uint96) {
        return (_defaultRoyaltyInfo.receiver, _defaultRoyaltyInfo.royaltyFraction);
    }

    function royaltyInfoOf(uint256 tokenId) public view returns(address, uint96) {
        require(_tokenRoyaltyInfo[tokenId]);
        return (_tokenRoyaltyInfo[tokenId].receiver, _tokenRoyaltyInfo[tokenId].royaltyFraction);
    }

    /**
     * @dev Stub for preventing unneeded storage writes.
     * All supported interfaces are hardcoded in the supportsInterface function.
     */
    function _registerInterface(bytes4) internal override {}

    /**
     * @dev See {ERC721-_burn}. This override additionally clears the royalty information for the token.
    */
    function _burn(uint256 tokenId) internal virtual override {
        super._burn(tokenId);
        _resetTokenRoyalty(tokenId);
    }
}