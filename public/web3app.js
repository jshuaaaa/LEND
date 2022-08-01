const depositInput = document.getElementById("deposit-input")
const borrowInput = document.getElementById("borrow-input")

async function onLoad() {
    let balance = await lEth.methods.balanceOf(account).call()
    balance = balance/10**18
    document.getElementById("user-weth").textContent += balance
    wEth("run")
}




async function connect() {
        const accounts = await window.ethereum.request({method: 'eth_requestAccounts'});
        account = accounts[0];
        console.log(accounts)
        document.getElementById("connect").textContent = "Connected"
        onLoad()
        return account
 
}





document.getElementById("connect").addEventListener("click", connect())

document.getElementById('deposit').addEventListener("click", async function() {
    let depositInputVal = depositInput.value * 10 ** 18
    console.log(depositInputVal)
    depositInputVal = depositInputVal.toString()
    console.log(depositInputVal)
    let approval = await wEth(account, depositInputVal)
    let txn = await LendingPool.methods.deposit(depositInputVal, lEthAddress).send({from:account})
})

document.getElementById('borrow').addEventListener("click", async function() {
    let borrowInputVal = borrowInput.value * 10 ** 18
    borrowInputVal = borrowInputVal.toString()
    let txn = await LendingPool.methods.borrow(borrowInputVal).send({from: account})
})


onLoad()