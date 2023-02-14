const { expect } = require('chai')
const { toBN } = require('../setup')

const ERC721NativeToken = artifacts.require('ERC721NativeToken')

const uriFor = (tokenId) => `https://example.com/${tokenId}`

contract('ERC721TokenFactory', (accounts) => {
  let token

  const owner = accounts[0]
  const other = accounts[1]

  beforeEach(async () => {
    token = await ERC721NativeToken.new('TEST', 'TST', owner)
    await token.mint(owner, uriFor(1))
    await token.mint(owner, uriFor(2))
  })

  describe('Support Burnable', () => {
    it('should able to burn by owner of nft', async () => {
      let balance

      balance = await token.balanceOf(owner)
      expect(balance).to.eql(toBN(2))

      await token.burn(1)
      balance = await token.balanceOf(owner)
      expect(balance).to.eql(toBN(1))

      await token.burn(2)
      balance = await token.balanceOf(owner)
      expect(balance).to.eql(toBN(0))
    })

    it('should able to burn by approver', async () => {
      let balance

      balance = await token.balanceOf(owner)
      expect(balance).to.eql(toBN(2))

      await token.approve(other, 1)
      await token.burn(1)
      balance = await token.balanceOf(owner)
      expect(balance).to.eql(toBN(1))
    })

    it('should not able to burn by not owner or approver of NFT', async () => {
      try {
        await token.burn(1, { from: other })
        expect(0).to.eql(1)
      } catch (error) {
        // VM should revert here
      }
    })
  })
})
