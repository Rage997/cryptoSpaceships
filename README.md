# cryptoSpaceships

A WIP game on the Ethereum blockchain. The main goal of this repository is to self-taught blockchain development and maybe come up with something good. I've been following [Crypto Zombies Solidity tutorials](https://cryptozombies.io/) which I highly recommend to anyone interested in blockchain development. 

# 1. Set up your environment

First of all install testrpc (a test node for ethereum). It will save a lot of time while testing your smart contract

```npm install -g ethereumjs-testrpc```

Great tool. It will generate test address with doll money (i.e. fake money) to test your dApp.

Then, install truffle and initialise a new project. 

```
npm install -g truffle
mkdir solidity-experiments
cd solidity-experiments/
truffle init
```

You can create a smart contract by ```truffle create contract <contract_name>```.
To compile your project run ```truffle compile```.

# 2. Deploy to the network
I choose to use [Ganache](https://www.trufflesuite.com/ganache) to run an ethereum test blockchain. This is important when testing to avoid paying gas fees and slow transaction speed. When the test blockchain is running you can deploy your smart contract by modify <it>"./migrations/1_initial_migration.js"</it> to refer to your smart contract and then run ```truffle migrate --network development```. Remember to set the correct port in <it> truffle-config.js </it>. Add the <b>--reset</b> flag if you want to re-deploy.

# 3. Interact with your smart contract

For the client-side I've used Moralis for simplicity (It looked like a fast way to get started). You need to register for an account, get the [template](https://github.com/MoralisWeb3/demo-apps/tree/main/moralis-sign-in-boilerplate) and then put your own APP_ID and SERVER_ URl in <it>main.js</it>. You can then test by running the <it>index.html</it> with Live Server Visual Studio Code plugin.
Moralis easies you the pain of hosting an RPC node, interact with EVM, send transactions etc. Furthermore, Moralis offers a database of everything you may be interested in for each user. 

# Deploy to the <b>real</b> Ethereum network

TODO
# A final note on security.

Ethereum is like a big computer and smart contracts define how information flows. In particular, once a smart contract is deployed to the Ethereum mainet no further modification can be done. Once it's deployed, it's fixed and eternal. This makes security really important. For the best code pratice about security please take a look at https://consensys.github.io/smart-contract-best-practices/