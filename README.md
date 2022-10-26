# Layer Zero Hello World
All this does is send and receive a cross chain payload including a string message that's mapped to the sender.

## Using
First thing you have to do is deploy, of course. you can deploy with:

```
npx hardhat deploy --network fantom-testnet --tags HelloWorldMessageLZ
npx hardhat deploy --network moonbeam-testnet --tags HelloWorldMessageLZ
```

Then you'll have to set your two deployments as trusting each other.

```
npx hardhat --network fantom-testnet hwSetTrustedRemote  --target-network moonbeam-testnet 
npx hardhat --network moonbeam-testnet hwSetTrustedRemote  --target-network fantom-testnet 
```

Finally, you can send a cross chain message.
```
npx hardhat --network fantom-testnet hwSend --target-network moonbeam-testnet --m "MESSAGE"
```