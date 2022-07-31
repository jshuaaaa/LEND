let web3 = new Web3('ws://localhost:7545');
console.log(web3);

document.getElementById('enter-app').addEventListener("click", function(){
    window.location.href = '/app'
})