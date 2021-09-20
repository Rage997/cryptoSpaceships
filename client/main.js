Moralis.initialize("UAMI5ptoxZTAuAouQZuyXQ3YI4huKb79gvSPXqNU"); // Application id from moralis.io
Moralis.serverURL = "https://qrgaztcmcggo.bigmoralis.com:2053/server"; //Server url from moralis.io
const CONTRACT_ADDRESS = "0x4Db98692e1a6A6c7f485ca7E693fb79EDdcB7f9E"

async function init() {
    try {
        user = await Moralis.Web3.authenticate();
        if (!user){
            $("login_button").click( async ()=>{
                user = await Moralis.Web3.authenticate()
            })
        }
        renderGame();
    } catch (error) {
        console.log(error);
    }
}

init();

// document.getElementById("login_button").onclick = login;
async function renderGame(){
    $("#login_button").hide();
    // Feth NFT properties
    window.web3 = await Moralis.Web3.enable();
    let abi = await getAbi();
    let contract = new web3.eth.Contract(abi, CONTRACT_ADDRESS)
    let spaceships_array = await contract.methods.getAllTokensForUser(ethereum.selectedAddress).call({from: ethereum.selectedAddress});
    console.log(spaceships_array)
    if(spaceships_array.length == 0) return;
    spaceships_array.forEach(async shipId => {
        let data = await contract.methods.getTokenDetails(shipId).call({from: ethereum.selectedAddress});    
        renderShip(shipId, data);
    });   
    $("#game").show();
}

function renderShip(id, data){
    let html = `
    <div class="col-md-4 card" id="ship_${id}">

        <img class="card-img-top img-ship" src="images/odyssey.png">
        <div class="card-body">
        <div>Id: <span class="ship_id">${id}</span> </div>
        <div>DNA: <span class="ship_dna">${data.dna}</span> </div>
        </div>
        `
    let el = $.parseHTML(html);
    $("#ship_row").append(el);
}

function getAbi(){
    // The ABI is a json file containing the specifications of a contract (functions etc)
    return new Promise( (res)=>{
        $.getJSON("SpaceshipBase.json", (json)=>{
            res(json.abi);
        } )
    })
}