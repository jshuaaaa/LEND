const depositInput = document.getElementById("deposit-input")
const borrowInput = document.getElementById("borrow-input")
const repayBorrowInput = document.getElementById("repay-borrow-input")
const withdrawInput = document.getElementById('withdraw-input')
async function onLoad() {
    let balance = await LendingPool.methods.getDepositAmountOfUser(account).call()
    balance = balance/10**18
    document.getElementById("user-weth").textContent = balance

    let borrowBalance = await LendingPool.methods.getBorrowAmountOfUser(account).call()
    borrowBalance = borrowBalance/10**18
    document.getElementById("user-borrow").textContent = borrowBalance

    wEth("run")


    let borrowContract = await LendingPool.methods.getBorrowAmountOfUser(LendingPoolAddress).call()
    borrowContract = borrowContract/10**18
    document.getElementById("borrow-contract").textContent = borrowContract

    let wethDeposited = await LendingPool.methods.getDepositAmountOfUser(LendingPoolAddress).call()
    wethDeposited = wethDeposited/10**18
    document.getElementById("weth-deposited").textContent = wethDeposited

    let leftToBorrow = wethDeposited * 0.7
    leftToBorrow = leftToBorrow - borrowBalance 
    document.getElementById("leftto-borrow").textContent = leftToBorrow
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

document.getElementById("connect").addEventListener("click", connect)

document.getElementById('deposit').addEventListener("click", async function() {
        let depositInputVal = depositInput.value * 10 ** 18
        console.log(depositInputVal)
        depositInputVal = depositInputVal.toString()

        let approval = await wEth(account, depositInputVal)

        setTimeout(async () => {
            let txn = await LendingPool.methods.deposit(depositInputVal, lEthAddress).send({from:account})
          }, "15000")
          onLoad()
        
    })




document.getElementById('borrow').addEventListener("click", async function() {
    let borrowInputVal = borrowInput.value * 10 ** 18
    borrowInputVal = borrowInputVal.toString()
    let txn = await LendingPool.methods.borrow(borrowInputVal).send({from: account})
    onLoad()
})

document.getElementById('repay-borrow').addEventListener("click", async function() {
    let repayBorrowInputVal = repayBorrowInput.value * 10 ** 18
    repayBorrowInputVal = repayBorrowInputVal.toString()
    let approval = await wEth(account, repayBorrowInputVal)
    setTimeout(async () => {
    let txn = await LendingPool.methods.repayBorrow(repayBorrowInputVal).send({from: account})
    }, "15000")
    onLoad()
})

document.getElementById('withdraw').addEventListener("click", async function() {
    let withdrawInputVal = withdrawInput.value * 10 ** 18
    withdrawInputVal = withdrawInputVal.toString()
    console.log(withdrawInputVal)
    let txn = await LendingPool.methods.withdraw(withdrawInputVal, lEthAddress).send({from: account})

          
    onLoad()
})


onLoad()