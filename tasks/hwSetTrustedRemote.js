const CHAIN_ID = require("../constants/chainIds.json")
const { getDeploymentAddresses } = require("../utils/readStatic")

module.exports = async function (taskArgs, hre) {
    const dstChainId = CHAIN_ID[taskArgs.targetNetwork]
    const dstAddr = getDeploymentAddresses(taskArgs.targetNetwork)["HelloWorldMessageLZ"]
    // get local contract instance
    const helloWorld = await ethers.getContract("HelloWorldMessageLZ")
    console.log(`[source] helloWorldMessageLZ.address: ${helloWorld.address}`)

    // setTrustedRemote() on the local contract, so it can receive message from the source contract
    try {
        let tx = await (await helloWorld.setTrustedRemote(dstChainId, dstAddr)).wait()
        console.log(`✅ [${hre.network.name}] setTrustedRemote(${dstChainId}, ${dstAddr})`)
        console.log(` tx: ${tx.transactionHash}`)
    } catch (e) {
        if (e.error?.message.includes("The source address has already been set for the chainId")) {
            console.log("*source already set*")
        } else {
            console.log(e)
        }
    }
}
