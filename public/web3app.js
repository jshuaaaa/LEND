console.log(lEth)

async function connect() {
    
        const accounts = await window.ethereum.request({method: 'eth_requestAccounts'});
        const account = accounts[0];
        console.log(accounts)
        document.getElementById("connect").textContent = "Connected"
        return account
  
}

document.getElementById("connect").addEventListener("click", connect())