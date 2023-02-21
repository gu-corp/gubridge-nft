pragma solidity 0.7.5;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

import "../interfaces/IOwnable.sol";

contract ERC721NativeToken is ERC721 {
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

    /**
     * @dev Tells if this contract implements the interface defined by
     * `interfaceId`. See the corresponding EIP165.
     * @return true, if interface is implemented.
     */
    function supportsInterface(bytes4 interfaceId) public view override(ERC165) returns (bool) {
        bytes4 INTERFACE_ID_ERC165 = 0x01ffc9a7;
        bytes4 INTERFACE_ID_ERC721 = 0x80ac58cd;
        bytes4 INTERFACE_ID_ERC721_METADATA = 0x5b5e139f;
        bytes4 INTERFACE_ID_ERC721_ENUMERABLE = 0x780e9d63;
        return
            interfaceId == INTERFACE_ID_ERC165 ||
            interfaceId == INTERFACE_ID_ERC721 ||
            interfaceId == INTERFACE_ID_ERC721_METADATA ||
            interfaceId == INTERFACE_ID_ERC721_ENUMERABLE;
    }

    function burn(uint256 tokenId) public virtual onlyOwner {
        _burn(tokenId);
    }

    /**
     * @dev Stub for preventing unneeded storage writes.
     * All supported interfaces are hardcoded in the supportsInterface function.
     */
    function _registerInterface(bytes4) internal override {}
}