const { expect } = require('chai')
const web3 = require('web3')
const { ZERO_ADDRESS } = require('../setup')

const ERC721TokenProxy = artifacts.require('ERC721TokenProxy')
const ERC721BridgeToken = artifacts.require('ERC721BridgeToken')
const ERC721NativeToken = artifacts.require('ERC721NativeToken')
const OmnibridgeMock = artifacts.require('OmnibridgeMock')

contract('ERC721TokenProxy', (accounts) => {
  let token

  const factory = accounts[0]
  const owner = accounts[1]

  async function initialize(options) {
    const opts = options || {}
    const args = [
      opts.tokenImage || ZERO_ADDRESS,
      opts.name || 'Test',
      opts.symbol || 'TST',
      opts.bridge || ZERO_ADDRESS,
      opts.salt || web3.utils.fromAscii(''),
      opts.owner || ZERO_ADDRESS,
    ]

    return token.initialize(...args, { from: opts.caller || factory })
  }

  beforeEach(async () => {
    token = await ERC721TokenProxy.new(factory)
  })

  describe('initialize', () => {
    it('should initialize parameters', async () => {
      // Given
      expect(await token.isInitialized()).to.be.equal(false)

      // When
      // only factory able to initialize
      await initialize({ caller: owner }).should.be.rejected

      await initialize().should.be.fulfilled

      // already initialized
      await initialize().should.be.rejected

      // Then
      expect(await token.isInitialized()).to.be.equal(true)
    })

    it('should initialize with ERC721BridgeToken', async () => {
      const tokenBridgeImageERC721 = await ERC721BridgeToken.new('TEST', 'TST', owner)
      const bridge = await OmnibridgeMock.new('SUFFIX')
      const salt = web3.utils.fromAscii('bridge')

      await initialize({
        tokenImage: tokenBridgeImageERC721.address,
        bridge: bridge.address,
        salt,
        owner,
      }).should.be.fulfilled

      const bridgeToken = await ERC721BridgeToken.at(token.address)
      expect(await bridgeToken.salt()).to.be.equal(web3.utils.padRight(salt, 64))
      expect(await bridgeToken.bridgeContract()).to.be.equal(bridge.address)
      expect(await bridgeToken.owner()).to.be.equal(owner)
      expect(await bridgeToken.factory()).to.be.equal(factory)
    })

    it('should initialize with ERC721NativeToken', async () => {
      const tokenNativeImageERC721 = await ERC721NativeToken.new('TEST', 'TST', owner)
      const salt = web3.utils.fromAscii('native')

      await initialize({
        tokenImage: tokenNativeImageERC721.address,
        salt,
        owner,
      }).should.be.fulfilled

      const nativeToken = await ERC721NativeToken.at(token.address)
      expect(await nativeToken.salt()).to.be.equal(web3.utils.padRight(salt, 64))
      expect(await nativeToken.owner()).to.be.equal(owner)
      expect(await nativeToken.factory()).to.be.equal(factory)
    })
  })
})
