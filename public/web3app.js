const depositInput = document.getElementById("deposit-input")
const borrowInput = document.getElementById("borrow-input")

async function onLoad() {
    let balance = await LendingPool.methods.getDepositAmountOfUser(account).call()
    balance = balance/10**18
    document.getElementById("user-weth").textContent += balance

    let borrowBalance = await LendingPool.methods.getBorrowAmountOfUser(account).call()
    borrowBalance = borrowBalance/10**18
    document.getElementById("user-borrow").textContent += borrowBalance

    wEth("run")


    let borrowContract = await LendingPool.methods.getBorrowAmountOfUser(LendingPoolAddress).call()
    borrowContract = borrowContract/10**18
    document.getElementById("borrow-contract").textContent += borrowContract

    let wethDeposited = await LendingPool.methods.getDepositAmountOfUser(LendingPoolAddress).call()
    wethDeposited = wethDeposited/10**18
    document.getElementById("weth-deposited").textContent += wethDeposited

    let leftToBorrow = wethDeposited * 0.7
    leftToBorrow = leftToBorrow - borrowBalance 
    document.getElementById("leftto-borrow").textContent += leftToBorrow
}




async function connect() {
        const accounts = await window.ethereum.request({method: 'eth_requestAccounts'});
        account = accounts[0];
        console.log(accounts)
        document.getElementById("connect").textContent = "Connected"
        onLoad()
        return account
 
}



let isApprove = false

document.getElementById("connect").addEventListener("click", connect())

document.getElementById('deposit').addEventListener("click", async function() {
        let depositInputVal = 999999999999999999
        console.log(depositInputVal)
        depositInputVal = depositInputVal.toString()
        let approval = await wEth(account, depositInputVal)
        document.getElementById("deposit").textContent = "Deposit"
        localStorage.approve = "Approved"

    if (localStorage.approve === "Approved") {
        let depositInputVal = depositInput.value * 10 ** 18
        console.log(depositInputVal)
        depositInputVal = depositInputVal.toString()
        let txn = await LendingPool.methods.deposit(depositInputVal, lEthAddress).send({from:account})
    }

})




document.getElementById('borrow').addEventListener("click", async function() {
    let borrowInputVal = borrowInput.value * 10 ** 18
    borrowInputVal = borrowInputVal.toString()
    let txn = await LendingPool.methods.borrow(borrowInputVal).send({from: account})
})


onLoad()