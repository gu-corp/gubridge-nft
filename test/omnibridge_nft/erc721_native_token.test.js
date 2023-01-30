const { expect } = require('chai')

const ERC721NativeToken = artifacts.require('ERC721NativeToken')
const { toBN, ZERO_ADDRESS } = require('../setup')

contract('ERC721NativeToken', (accounts) => {
  let token

  const owner = accounts[0]
  const user = accounts[1]
  const other = accounts[2]

  const defaultRoyalty = 500 // 5%

  async function setDefaultRoyalty(options) {
    const opts = options || {}

    const args = [opts.receiver || owner, opts.feeNumerator || defaultRoyalty]

    return token.setDefaultRoyalty(...args)
  }

  const mint = (() => {
    let tokenId = 100
    const uriFor = (tokenId) => `https://example.com/${tokenId}`

    return async () => {
      await token.mint(user, uriFor(tokenId))
      return tokenId++
    }
  })()

  describe('ERC2981 - support royalty fee', () => {
    beforeEach(async () => {
      token = await ERC721NativeToken.new('Test', 'TST', owner)
      await setDefaultRoyalty().should.be.fulfilled
      await mint().should.be.fulfilled
      await mint().should.be.fulfilled
    })

    describe('setDefaultRoyalty', () => {
      it('should return correctly royalty info', async () => {
        const { 0: receiver1, 1: amount1 } = await token.royaltyInfo(100, 100)
        expect(receiver1).to.eql(owner)
        expect(amount1).to.eql(toBN(5))

        const { 0: receiver2, 1: amount2 } = await token.royaltyInfo(100, 100)
        expect(receiver2).to.eql(owner)
        expect(amount2).to.eql(toBN(5))
      })

      it('should not allow not owner set royalty info', async () => {
        await token.setDefaultRoyalty(user, defaultRoyalty, { from: user }).should.be.rejected
      })
    })

    describe('deleteDefaultRoyalty', () => {
      it('should able to delete default royalty by owner', async () => {
        await token.deleteDefaultRoyalty().should.be.fulfilled
        const { 0: receiver, 1: amount } = await token.royaltyInfo(100, 100)

        expect(receiver).to.eql(ZERO_ADDRESS)
        expect(amount).to.eql(toBN(0))
      })

      it('should not able to delete default royalty by not owner', async () => {
        await token.deleteDefaultRoyalty({ from: user }).should.be.rejected
      })
    })

    describe('setTokenRoyalty', () => {
      it('should able to set token royalty by owner', async () => {
        await token.setTokenRoyalty(101, other, 1000).should.be.fulfilled
        const { 0: receiver, 1: amount } = await token.royaltyInfo(101, 100)
        expect(receiver).to.eql(other)
        expect(amount).to.eql(toBN(10))
      })

      it('should not able to set token royalty by not owner', async () => {
        await token.setTokenRoyalty(101, other, 1000, { from: user }).should.be.rejected
      })
    })

    describe('resetTokenRoyalty', () => {
      beforeEach(async () => {
        await token.setTokenRoyalty(101, other, 1000).should.be.fulfilled
        const { 0: receiver, 1: amount } = await token.royaltyInfo(101, 100)
        expect(receiver).to.eql(other)
        expect(amount).to.eql(toBN(10))
      })

      it('should able to reset token royalty by owner', async () => {
        await token.resetTokenRoyalty(101)
        const { 0: receiver, 1: amount } = await token.royaltyInfo(101, 100)
        expect(receiver).to.eql(owner)
        expect(amount).to.eql(toBN(5))
      })

      it('should not able to set token royalty by not owner', async () => {
        await token.resetTokenRoyalty(101, { from: user }).should.be.rejected
      })
    })

    describe('defaultRoyaltyInfo', () => {
      it.only('should return correctly default royalty info', async () => {
        const { 0: receiver, 1: royaltyFraction } = await token.defaultRoyaltyInfo()
        expect(receiver).to.eql(owner)
        expect(royaltyFraction).to.eql(toBN(500))
      })
    })
  })
})
