const depositInput = document.getElementById("deposit-input")
let account;


async function connect() {
        const accounts = await window.ethereum.request({method: 'eth_requestAccounts'});
        account = accounts[0];
        console.log(accounts)
        document.getElementById("connect").textContent = "Connected"
        return account
 
}





document.getElementById("connect").addEventListener("click", connect())

document.getElementById('deposit').addEventListener("click", async function() {
    let depositInputVal = depositInput.value * 10 ** 18
    console.log(depositInputVal)
    depositInputVal = depositInputVal.toString()
    console.log(depositInputVal)
    let approval = await wEthApproval(account)
    let txn = await LendingPool.methods.deposit(depositInputVal, lEthAddress).send({from:account})
})