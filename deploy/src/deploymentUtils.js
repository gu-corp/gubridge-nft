/* eslint-disable no-param-reassign */
const BigNumber = require('bignumber.js')
const Web3Utils = require('web3').utils
const assert = require('assert')
const {
  web3Home,
  web3Foreign,
  GAS_LIMIT_EXTRA,
  HOME_DEPLOYMENT_GAS_PRICE,
  FOREIGN_DEPLOYMENT_GAS_PRICE,
  DEPLOYMENT_ACCOUNT_PRIVATE_KEY,
  DEPLOYMENT_FACTORY_ACCOUNT_PRIVATE_KEY,
} = require('./web3')

async function deployContract(contractJson, args, { network, nonce }) {
  let web3
  if (network === 'foreign') {
    web3 = web3Foreign
  } else {
    web3 = web3Home
  }
  const instance = new web3.eth.Contract(contractJson.abi)
  const result = instance
    .deploy({
      data: contractJson.bytecode,
      arguments: args,
    })
    .encodeABI()
  const receipt = await sendTx(network, {
    data: result,
    nonce,
    to: null,
  })
  instance.options.address = receipt.contractAddress
  instance.deployedBlockNumber = receipt.blockNumber

  return instance
}

async function deployContractByFactoryDeploymentAccount(contractJson, args, { network, nonce }) {
  let web3
  if (network === 'foreign') {
    web3 = web3Foreign
  } else {
    web3 = web3Home
  }
  const instance = new web3.eth.Contract(contractJson.abi)
  const result = instance
    .deploy({
      data: contractJson.bytecode,
      arguments: args,
    })
    .encodeABI()
  const receipt = await sendTx(network, {
    data: result,
    nonce,
    to: null,
    privateKey: DEPLOYMENT_FACTORY_ACCOUNT_PRIVATE_KEY,
  })
  instance.options.address = receipt.contractAddress
  instance.deployedBlockNumber = receipt.blockNumber

  return instance
}

function sendTx(network, options) {
  return (network === 'foreign' ? sendRawTxForeign : sendRawTxHome)(options)
}

async function sendRawTxHome(options) {
  return sendRawTx({
    ...options,
    gasPrice: HOME_DEPLOYMENT_GAS_PRICE,
    web3: web3Home,
  })
}

async function sendRawTxForeign(options) {
  return sendRawTx({
    ...options,
    gasPrice: FOREIGN_DEPLOYMENT_GAS_PRICE,
    web3: web3Foreign,
  })
}

async function sendRawTx({ data, nonce, to, web3, gasPrice, value, privateKey = DEPLOYMENT_ACCOUNT_PRIVATE_KEY }) {
  try {
    const estimatedGas = new BigNumber(
      await web3.eth.estimateGas({
        from: web3Home.eth.accounts.privateKeyToAccount(privateKey).address,
        value,
        to,
        data,
      })
    )

    const blockData = await web3.eth.getBlock('latest')
    const blockGasLimit = new BigNumber(blockData.gasLimit)
    if (estimatedGas.isGreaterThan(blockGasLimit)) {
      throw new Error(
        `estimated gas greater (${estimatedGas.toString()}) than the block gas limit (${blockGasLimit.toString()})`
      )
    }
    let gas = estimatedGas.multipliedBy(new BigNumber(1 + GAS_LIMIT_EXTRA))
    if (gas.isGreaterThan(blockGasLimit)) {
      gas = blockGasLimit
    } else {
      gas = gas.toFixed(0)
    }

    const rawTx = {
      nonce,
      gasPrice: Web3Utils.toHex(gasPrice),
      gasLimit: Web3Utils.toHex(gas),
      to,
      data,
      value,
    }

    const signedTx = await new Promise((res) =>
      web3.eth.accounts.signTransaction(rawTx, privateKey, (err, signedTx) => res(signedTx))
    )
    const receipt = await web3.eth
      .sendSignedTransaction(signedTx.rawTransaction)
      .once('transactionHash', (txHash) => console.log('pending txHash', txHash))
      .on('error', (e) => {
        throw e
      })
    assert.ok(receipt.status, 'Transaction Failed')
    return receipt
  } catch (e) {
    console.error(e)
  }
  return null
}

async function upgradeProxy({ proxy, implementationAddress, version, nonce, network, privateKey }) {
  await sendTx(network, {
    data: proxy.methods.upgradeTo(version, implementationAddress).encodeABI(),
    nonce,
    to: proxy.options.address,
    privateKey,
  })
}

async function upgradeProxyAndCall({ proxy, implementationAddress, version, data, nonce, network }) {
  await sendTx(network, {
    data: proxy.methods.upgradeToAndCall(version, implementationAddress, data).encodeABI(),
    nonce,
    to: proxy.options.address,
  })
}

async function transferProxyOwnership({ proxy, newOwner, nonce, network, privateKey }) {
  await sendTx(network, {
    data: proxy.methods.transferProxyOwnership(newOwner).encodeABI(),
    nonce,
    to: proxy.options.address,
    privateKey,
  })
}

async function transferOwnership({ contract, newOwner, nonce, network, privateKey = DEPLOYMENT_ACCOUNT_PRIVATE_KEY }) {
  await sendTx(network, {
    data: contract.methods.transferOwnership(newOwner).encodeABI(),
    nonce,
    to: contract.options.address,
    privateKey,
  })
}

async function setBridgeContract({ contract, bridgeAddress, nonce, network }) {
  await sendTx(network, {
    data: contract.methods.setBridgeContract(bridgeAddress).encodeABI(),
    nonce,
    to: contract.options.address,
  })
}

async function isContract(web3, address) {
  const code = await web3.eth.getCode(address)
  return code !== '0x' && code !== '0x0'
}

module.exports = {
  deployContract,
  sendRawTxHome,
  sendRawTxForeign,
  upgradeProxy,
  upgradeProxyAndCall,
  transferProxyOwnership,
  transferOwnership,
  setBridgeContract,
  isContract,
  deployContractByFactoryDeploymentAccount,
}
