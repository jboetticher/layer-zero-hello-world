const CHAIN_ID = require("../constants/chainIds.json")

module.exports = async function (taskArgs, hre) {
    const dstChainId = CHAIN_ID[taskArgs.targetNetwork]
    const message = taskArgs.m;

    // get local contract instance
    const helloWorld = await ethers.getContract("HelloWorldMessageLZ")
    console.log(`[source] HelloWorldMessageLZ.address: ${helloWorld.address}`)

    // set the config for this UA to use the specified Oracle
    for (let i = 0; i < taskArgs.n; ++i) {
        let tx = await (
            await helloWorld.sendMessage(
                message,
                dstChainId,
                { value: ethers.utils.parseEther("0.1") } // estimate/guess
            )
        ).wait()
        console.log(`✅ Message Sent [${hre.network.name}] sendMessage on destination HelloWorldMessageLZ @ [${dstChainId}]`)
        console.log(`[${i}] tx: ${tx.transactionHash}`)
    }
}
