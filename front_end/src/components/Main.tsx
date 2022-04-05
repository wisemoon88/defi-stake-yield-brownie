import { useEthers } from "@usedapp/core"
import helperConfig from "../helper-config.json"
import networkMapping from "../chain-info/deployments/map.json"
import { constants } from "ethers"
import brownieConfig from "../brownie-config.json"



export const Main = () => {
    // Show token values from wallet
    // Get the address of different tokens
    // Get the balance of the Users Wallets


    //send the brownie-config to our 'src folder'
    //send build folder to src to allow src to understand dapptoken and token farm address

    const { chainId } = useEthers()
    const networkName = chainId ? helperConfig(chainId) : "dev"
    const dappTokenAddress = chainId ? networkMapping[String(chainId)]["DappToken"][0] : constants.AddressZero   // look into that mapping : 000
    const wethTokenAddress = chainId ? brownieConfig["networks"][networkName]["weth_token"] : constants.AddressZero // brownie config
    const fauTokenAddress = chainId ? brownieConfig["networks"][networkName]["fau_token"] : constants.AddressZero

    return (<div>I Am Main!</div>)
}