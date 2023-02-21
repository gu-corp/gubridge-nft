## Gas Consumption `GUBRIDGE_NFT` contracts

#### Deployment

##### Home

- Eth current price (21/02/2023):
  - slow: 23 gwei
  - average: 24 gwei
  - fast: 24 gwei

DEVELOPMENT_FACTORY_ACCOUNT

| Contract               | Method                 | Min     | Max     | Avg     |
| ---------------------- | ---------------------- | ------- | ------- | ------- |
| HomeERC721BridgeToken  | deployment             | 2237011 | 2237011 | 2237011 |
| HomeERC721NativeToken  | deployment             | 1798181 | 1798181 | 1798181 |
| EternalStorageProxy    | deployment             | 360523  | 360523  | 360523  |
| HomeERC721TokenFactory | deployment             | 1309938 | 1309938 | 1309938 |
| HomeERC721TokenFactory | initialize             | 156424  | 156448  | 156446  |
| EternalStorageProxy    | transferProxyOwnership | 31113   | 31113   | 31113   |
| Total                  |                        | 5893190 | 5893214 | 5893212 |

- Estimate:
  - min: 23 \* 5893190 = 135543370 gwei (~0,135543370 ETH)
  - max: 24 \* 5893214 = 141437136 gwei (~0,141437136 ETH)
  - average: (23 \* 5893190 + 24 \* 5893190 + 24 \* 5893190 + 5893214 \* 23 + 5893214 \* 24 + 5893214 \* 24 + 5893212 \* 23 + 5893212 \* 24 + 5893212 \* 24) / 9 = 139472526.222 gwei (~0,139472526222 ETH)

DEPLOYMENT_ACCOUNT

| Contract                     | Method                 | Min     | Max     | Avg     |
| ---------------------------- | ---------------------- | ------- | ------- | ------- |
| EternalStorageProxy          | deployment             | 360523  | 360523  | 360523  |
| OwnedUpgradeabilityProxy     | deployment             | 360523  | 360523  | 360523  |
| SelectorTokenGasLimitManager | deployment             | 950440  | 950440  | 950440  |
| OwnedUpgradeabilityProxy     | upgradeProxyAndCall    | 93441   | 136788  | 124967  |
| HomeNFTOmnibridge            | deploy                 | 4829013 | 4829013 | 4829013 |
| EternalStorageProxy          | upgradeTo              | 37661   | 37661   | 37661   |
| HomeNFTOmnibridge            | initialize             | 160844  | 163741  | 160976  |
| EternalStorageProxy          | transferProxyOwnership | 31113   | 31113   | 31113   |
| Total                        |                        | 6823558 | 6869802 | 6855216 |

- Estimate:
  - min: 23 \* 6823558 = 156941834 gwei (~0,156941834 ETH)
  - max: 24 \* 6869802 = 164875248 gwei (~0,164875248 ETH)
  - average: (23 \* 6823558 + 24 \* 6823558 + 24 \* 6823558 + 6869802 \* 23 + 6869802 \* 24 + 6869802 \* 24 + 6855216 \* 23 + 6855216 \* 24 + 6855216 \* 24) / 9 = 162105432.889 gwei (~0,162105432889 ETH)

TOTAL (DEVELOPMENT_FACTORY_ACCOUNT + DEPLOYMENT_ACCOUNT)

| Contract                     | Method                 | Min      | Max      | Avg      |
| ---------------------------- | ---------------------- | -------- | -------- | -------- |
| HomeERC721BridgeToken        | deployment             | 2237011  | 2237011  | 2237011  |
| HomeERC721NativeToken        | deployment             | 1798181  | 1798181  | 1798181  |
| EternalStorageProxy          | deployment             | 360523   | 360523   | 360523   |
| HomeERC721TokenFactory       | deployment             | 1309938  | 1309938  | 1309938  |
| HomeERC721TokenFactory       | initialize             | 156424   | 156448   | 156446   |
| EternalStorageProxy          | transferProxyOwnership | 31113    | 31113    | 31113    |
| EternalStorageProxy          | deployment             | 360523   | 360523   | 360523   |
| OwnedUpgradeabilityProxy     | deployment             | 360523   | 360523   | 360523   |
| SelectorTokenGasLimitManager | deployment             | 950440   | 950440   | 950440   |
| OwnedUpgradeabilityProxy     | upgradeProxyAndCall    | 93441    | 136788   | 124967   |
| HomeNFTOmnibridge            | deploy                 | 4829013  | 4829013  | 4829013  |
| EternalStorageProxy          | upgradeTo              | 37661    | 37661    | 37661    |
| HomeNFTOmnibridge            | initialize             | 160844   | 163741   | 160976   |
| EternalStorageProxy          | transferProxyOwnership | 31113    | 31113    | 31113    |
| Total                        |                        | 12716748 | 12763016 | 12748428 |

- Estimate:
  - min: 23 \* 12716748 = 292485204 gwei (~0,292485204 ETH)
  - max: 24 \* 7376863 = 177044712 gwei (~0,306312384 ETH)
  - average: (23 \* 12716748 + 24 \* 12716748 + 24 \* 12716748 + 12763016 \* 23 + 12763016 \* 24 + 12763016 \* 24 + 12748428 \* 23 + 12748428 \* 24 + 12748428 \* 24) / 9 = 301577959.111 gwei (~0,301577959111 ETH)

##### Foreign

DEVELOPMENT_FACTORY_ACCOUNT

| Contract                  | Method                 | Min     | Max     | Avg     |
| ------------------------- | ---------------------- | ------- | ------- | ------- |
| ForeignERC721NativeToken  | deployment             | 1798181 | 1798181 | 1798181 |
| ForeignERC721BridgeToken  | deployment             | 2237011 | 2237011 | 2237011 |
| EternalStorageProxy       | deployment             | 360523  | 360523  | 360523  |
| ForeignERC721TokenFactory | deployment             | 1309938 | 1309938 | 1309938 |
| ForeignERC721TokenFactory | initialize             | 156424  | 156448  | 156446  |
| EternalStorageProxy       | transferProxyOwnership | 31113   | 31113   | 31113   |
| Total                     |                        | 6823558 | 6869802 | 6855216 |

- Estimate:
  - min: 23 \* 5893190 = 135543370 gwei (~0,135543370 ETH)
  - max: 24 \* 5893214 = 141437136 gwei (~0,141437136 ETH)
  - average: (23 \* 5893190 + 24 \* 5893190 + 24 \* 5893190 + 5893214 \* 23 + 5893214 \* 24 + 5893214 \* 24 + 5893212 \* 23 + 5893212 \* 24 + 5893212 \* 24) / 9 = 139472526.222 gwei (~0,139472526222 ETH)

DEPLOYMENT_ACCOUNT

| Contract             | Method                 | Min     | Max     | Avg     |
| -------------------- | ---------------------- | ------- | ------- | ------- |
| EternalStorageProxy  | deployment             | 360523  | 360523  | 360523  |
| ForeignNFTOmnibridge | deployment             | 4644844 | 4644844 | 4644844 |
| EternalStorageProxy  | upgradeTo              | 360523  | 360523  | 360523  |
| ForeignNFTOmnibridge | initialize             | 179928  | 182840  | 180076  |
| EternalStorageProxy  | transferProxyOwnership | 31113   | 31113   | 31113   |
| Total                |                        | 4646563 | 4603255 | 4615075 |

- Estimate:
  - min: 23 \* 5893190 = 128269413 gwei (~0,128269413 ETH)
  - max: 24 \* 5893214 = 133916232 gwei (~0,141437136 ETH)
  - average: (23 \* 5893190 + 24 \* 5893190 + 24 \* 5893190 + 5893214 \* 23 + 5893214 \* 24 + 5893214 \* 24 + 5893212 \* 23 + 5893212 \* 24 + 5893212 \* 24) / 9 = 132011507 gwei (~0,132011507 ETH)

TOTAL (DEVELOPMENT_FACTORY_ACCOUNT + DEPLOYMENT_ACCOUNT)

| Contract                  | Method                 | Min      | Max      | Avg      |
| ------------------------- | ---------------------- | -------- | -------- | -------- |
| ForeignERC721NativeToken  | deployment             | 1798181  | 1798181  | 1798181  |
| ForeignERC721BridgeToken  | deployment             | 2237011  | 2237011  | 2237011  |
| EternalStorageProxy       | deployment             | 360523   | 360523   | 360523   |
| ForeignERC721TokenFactory | deployment             | 1309938  | 1309938  | 1309938  |
| ForeignERC721TokenFactory | initialize             | 156424   | 156448   | 156446   |
| EternalStorageProxy       | transferProxyOwnership | 31113    | 31113    | 31113    |
| EternalStorageProxy       | deployment             | 360523   | 360523   | 360523   |
| ForeignNFTOmnibridge      | deployment             | 4644844  | 4644844  | 4644844  |
| EternalStorageProxy       | upgradeTo              | 360523   | 360523   | 360523   |
| ForeignNFTOmnibridge      | initialize             | 179928   | 182840   | 180076   |
| EternalStorageProxy       | transferProxyOwnership | 31113    | 31113    | 31113    |
| Total                     |                        | 11470121 | 11473057 | 11470291 |

- Estimate:
  - min: 23 \* 11470121 = 263812783 gwei (~0,263812783 ETH)
  - max: 24 \* 11473057 = 275353368 gwei (~0,149769576 ETH)
  - average: (23 \* 11470121 + 24 \* 11470121 + 24 \* 11470121 + 11473057 \* 23 + 11473057 \* 24 + 11473057 \* 24 + 11470291 \* 23 + 11470291 \* 24 + 11470291 \* 24) / 9 = 271484033.222 gwei (~0,271484033222 ETH)

#### Test on Goerli & G.U.Sandbox

- Network gas price:
  - Sepolia: 1 Gwei
  - G.U.Sandbox: 10 Gwei
- Balance before:
  - Development account:
    - Sepolia:
    - G.U.Sandbox:
  - Development factory account:
    - Sepolia:
    - G.U.Sandbox:
- Balance after:
  - Development account:
    - Sepolia:
    - G.U.Sandbox:
  - Development factory account:
    - Sepolia:
    - G.U.Sandbox:
