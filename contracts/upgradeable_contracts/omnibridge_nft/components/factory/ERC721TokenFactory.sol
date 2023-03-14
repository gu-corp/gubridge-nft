pragma solidity 0.7.5;

import "@openzeppelin/contracts/utils/Address.sol";

import "../bridged/ERC721TokenProxy.sol";
import "../../../Initializable.sol";
import "../../../Upgradeable.sol";
import "../../../Ownable.sol";

contract ERC721TokenFactory is Initializable, Upgradeable, Ownable {
  event ERC721NativeContractCreated(address indexed _collection);
  event ERC721BridgeContractCreated(address indexed _collection);

  bytes32 internal constant ERC721_TOKEN_BRIDGE_IMAGE_CONTRACT =
    0x6aad256926877203e89d1aabd3c123bafa04b2c16f96dbd769d5c99fe3c51eb1; // keccak256(abi.encodePacked("tokenBridgeImageContract"))
  bytes32 internal constant ERC721_TOKEN_NATIVE_IMAGE_CONTRACT =
    0x02d5fe70e145b5080c327371a50b630311beed4bc3e8d113faae24c37a9a0eb5; // keccak256(abi.encodePacked("tokenNativeImageContract"))
  bytes32 internal constant BRIDGE_CONTRACT =
    0x811bbb11e8899da471f0e69a3ed55090fc90215227fc5fb1cb0d6e962ea7b74f; // keccak256(abi.encodePacked("bridgeContract"))
  bytes32 internal constant ID_COUNTER =
    0xbe093699e7df0bed5814a55556d286cd5307e86409f33918b4e10a236fcdae16; // keccak256(abi.encodePacked("idCounter"))

  modifier onlyBridge() {
    require(msg.sender == bridge());
    _;
  } 
  
  function initialize(
      address erc721BridgeImage_,
      address erc721NativeImage_,
      address bridge_,
      address owner_
  ) external onlyRelevantSender returns (bool) {
      require(!isInitialized());

      _setERC721BridgeImage(erc721BridgeImage_);
      _setERC721NativeImage(erc721NativeImage_);
      _setBridge(bridge_);
      _setOwner(owner_);
      
      setInitialize();

      return isInitialized();
  }
  

  function erc721BridgeImage() public view returns (address) {
    return addressStorage[ERC721_TOKEN_BRIDGE_IMAGE_CONTRACT];
  }

  function erc721NativeImage() public view returns (address) {
    return addressStorage[ERC721_TOKEN_NATIVE_IMAGE_CONTRACT];
  }

  function bridge() public view returns (address) {
    return addressStorage[BRIDGE_CONTRACT];
  }

  function setERC721BridgeImage(address erc721BridgeImage_) public onlyOwner {
    _setERC721BridgeImage(erc721BridgeImage_);
  }

  function setERC721NativeImage(address erc721NativeImage_) public onlyOwner {
    _setERC721NativeImage(erc721NativeImage_);
  }

  function setBridge(address bridge_) public onlyOwner {
    _setBridge(bridge_);
  }

  function nativeTokenOf(bytes32 salt_) public view returns (address) {
    return addressStorage[keccak256(abi.encodePacked("nativeTokens", salt_))];
  }

  function deployERC721BridgeContract(
    string memory _name,
    string memory _symbol,
    bytes32 _salt,
    address _owner
  ) external onlyBridge returns(address) {
    require(erc721BridgeImage() != address(0));

    ERC721TokenProxy proxy = new ERC721TokenProxy{salt: _salt}(address(this));

    proxy.initialize(
      erc721BridgeImage(),
      _name,
      _symbol,
      bridge(),
      _salt,
      _owner
    );

    emit ERC721BridgeContractCreated(address(proxy));
    return address(proxy);
  }

  function deployERC721NativeContract(
    string memory _name,
    string memory _symbol
  ) external returns(address) {
    require(erc721NativeImage() != address(0));

    uint256 _collectionId = uintStorage[ID_COUNTER];
    uintStorage[ID_COUNTER] += 1;

    // salt = incremental + chainId
    // incremental make every single collection different address
    // chainId make single network different address
    bytes32 _salt = keccak256(abi.encodePacked(_collectionId, chainId()));
    ERC721TokenProxy proxy = new ERC721TokenProxy{salt: _salt}(address(this));

    proxy.initialize(
      erc721NativeImage(),
      _name,
      _symbol,
      address(0), // nativeToken not depend on bridge contract,
      _salt,
      msg.sender
    );

    addressStorage[keccak256(abi.encodePacked("nativeTokens", _salt))] = address(proxy);
    emit ERC721NativeContractCreated(address(proxy));
    return address(proxy);
  }

  function chainId() public view returns (uint256 chainId) {
    assembly {
      chainId := chainid()
    }
  }

  function _setERC721BridgeImage(address erc721BridgeImage_) internal {
    require(Address.isContract(erc721BridgeImage_));
    addressStorage[ERC721_TOKEN_BRIDGE_IMAGE_CONTRACT] = erc721BridgeImage_;
  }

  function _setERC721NativeImage(address erc721NativeImage_) internal {
    require(Address.isContract(erc721NativeImage_));
    addressStorage[ERC721_TOKEN_NATIVE_IMAGE_CONTRACT] = erc721NativeImage_;
  }

  function _setBridge(address bridge_) internal {
    require(Address.isContract(bridge_));
    addressStorage[BRIDGE_CONTRACT] = bridge_;
  }
}