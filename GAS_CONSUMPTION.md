## Gas Consumption `GUBRIDGE_NFT` contracts

#### Deployment

##### Home

- Eth current price (21/02/2023):
  - slow: 23 gwei
  - average: 24 gwei
  - fast: 24 gwei

DEVELOPMENT_FACTORY_ACCOUNT

| Contract            | Method                 | Min     | Max     | Avg     |
| ------------------- | ---------------------- | ------- | ------- | ------- |
| ERC721BridgeToken   | deployment             | 2237011 | 2237011 | 2237011 |
| ERC721NativeToken   | deployment             | 1798181 | 1798181 | 1798181 |
| EternalStorageProxy | deployment             | 360523  | 360523  | 360523  |
| EternalStorageProxy | upgradeTo              | 36738   | 66738   | 56737   |
| ERC721TokenFactory  | initialize             | 156424  | 156448  | 156446  |
| EternalStorageProxy | transferProxyOwnership | 31113   | 31113   | 31113   |
| Total               |                        | 4619990 | 4650014 | 5949949 |

- Estimate:
  - min: 23 \* 4619990 = 106259770 gwei (~0,106259770 ETH)
  - max: 24 \* 4650014 = 111600336 gwei (~0,111600336 ETH)

DEPLOYMENT_ACCOUNT

| Contract                     | Method                 | Min      | Max      | Avg      |
| ---------------------------- | ---------------------- | -------- | -------- | -------- |
| ERC721TokenFactory           | deployment             | 1309938  | 1309938  | 1309938  |
| EternalStorageProxy          | deployment             | 360523   | 360523   | 360523   |
| ERC1155BridgeToken           | deployment             | 2384628  | 2384628  | 2384628  |
| OwnedUpgradeabilityProxy     | deployment             | 360523   | 360523   | 360523   |
| SelectorTokenGasLimitManager | deployment             | 950440   | 950440   | 950440   |
| OwnedUpgradeabilityProxy     | upgradeProxyAndCall    | 93441    | 136788   | 124967   |
| HomeNFTOmnibridge            | deploy                 | 4829013  | 4829013  | 4829013  |
| EternalStorageProxy          | upgradeTo              | 37661    | 37661    | 37661    |
| HomeNFTOmnibridge            | initialize             | 160844   | 163741   | 160976   |
| EternalStorageProxy          | transferProxyOwnership | 31113    | 31113    | 31113    |
| Total                        |                        | 10518124 | 10564368 | 10549782 |

- Estimate:
  - min: 23 \* 10518124 = 241916852 gwei (~0,241916852 ETH)
  - max: 24 \* 10564368 = 253544832 gwei (~0,253544832 ETH)

TOTAL (DEVELOPMENT_FACTORY_ACCOUNT + DEPLOYMENT_ACCOUNT)

| Contract                     | Method                 | Min      | Max      | Avg      |
| ---------------------------- | ---------------------- | -------- | -------- | -------- |
| HomeERC721BridgeToken        | deployment             | 2237011  | 2237011  | 2237011  |
| HomeERC721NativeToken        | deployment             | 1798181  | 1798181  | 1798181  |
| EternalStorageProxy          | deployment             | 360523   | 360523   | 360523   |
| HomeERC721TokenFactory       | deployment             | 1309938  | 1309938  | 1309938  |
| HomeERC721TokenFactory       | initialize             | 156424   | 156448   | 156446   |
| EternalStorageProxy          | upgradeTo              | 36738    | 66738    | 56737    |
| EternalStorageProxy          | transferProxyOwnership | 31113    | 31113    | 31113    |
| EternalStorageProxy          | deployment             | 360523   | 360523   | 360523   |
| OwnedUpgradeabilityProxy     | deployment             | 360523   | 360523   | 360523   |
| SelectorTokenGasLimitManager | deployment             | 950440   | 950440   | 950440   |
| OwnedUpgradeabilityProxy     | upgradeProxyAndCall    | 93441    | 136788   | 124967   |
| HomeNFTOmnibridge            | deploy                 | 4829013  | 4829013  | 4829013  |
| EternalStorageProxy          | upgradeTo              | 37661    | 37661    | 37661    |
| HomeNFTOmnibridge            | initialize             | 160844   | 163741   | 160976   |
| EternalStorageProxy          | transferProxyOwnership | 31113    | 31113    | 31113    |
| Total                        |                        | 15138114 | 15214382 | 15189793 |

- Estimate:
  - min: 106259770 + 241916852 = 348176622 gwei (~0,348176622 ETH)
  - max: 111600336 + 253544832 = 365145168 gwei (~0,306312384 ETH)

##### Foreign

DEVELOPMENT_FACTORY_ACCOUNT

| Contract            | Method                 | Min     | Max     | Avg     |
| ------------------- | ---------------------- | ------- | ------- | ------- |
| ERC721BridgeToken   | deployment             | 2237011 | 2237011 | 2237011 |
| ERC721NativeToken   | deployment             | 1798181 | 1798181 | 1798181 |
| EternalStorageProxy | deployment             | 360523  | 360523  | 360523  |
| EternalStorageProxy | upgradeTo              | 36738   | 66738   | 56737   |
| ERC721TokenFactory  | initialize             | 156424  | 156448  | 156446  |
| EternalStorageProxy | transferProxyOwnership | 31113   | 31113   | 31113   |
| Total               |                        | 4619990 | 4650014 | 5949949 |

- Estimate:
  - min: 23 \* 4619990 = 106259770 gwei (~0,106259770 ETH)
  - max: 24 \* 4650014 = 111600336 gwei (~0,111600336 ETH)

DEPLOYMENT_ACCOUNT

| Contract             | Method                 | Min     | Max     | Avg     |
| -------------------- | ---------------------- | ------- | ------- | ------- |
| ERC721TokenFactory   | deployment             | 1309938 | 1309938 | 1309938 |
| EternalStorageProxy  | deployment             | 360523  | 360523  | 360523  |
| ForeignNFTOmnibridge | deployment             | 4644844 | 4644844 | 4644844 |
| EternalStorageProxy  | upgradeTo              | 360523  | 360523  | 360523  |
| ForeignNFTOmnibridge | initialize             | 179928  | 182840  | 180076  |
| EternalStorageProxy  | transferProxyOwnership | 31113   | 31113   | 31113   |
| Total                |                        | 6886869 | 6889781 | 6887017 |

- Estimate:
  - min: 23 \* 6886869 = 158397987 gwei (~0,158397987 ETH)
  - max: 24 \* 6889781 = 165354744 gwei (~0,165354744 ETH)

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
  - min: 4619990 + 158397987 = 163017977 gwei (~0,163017977 ETH)
  - max: 4650014 + 11473057 = 16123071 gwei (~0,16123071 ETH)

#### Test on Goerli & G.U.Sandbox

- Network gas price:
  - Sepolia: 1 Gwei
  - G.U.Sandbox: 10 Gwei
- Balance before:
  - Development account:
    - Sepolia:0.4549
    - G.U.Sandbox: 7.611
  - Development factory account:
    - Sepolia: 0.5341
    - G.U.Sandbox: 0.7436
- Balance after:
  - Development account:
    - Sepolia: 0.3654 (0.0895 ETH )
    - G.U.Sandbox: 7.5055 (0.1055 ETH)
  - Development factory account:
    - Sepolia: 0.4871 (0.047 ETH)
    - G.U.Sandbox: 0.6968 (0.0468 ETH)
