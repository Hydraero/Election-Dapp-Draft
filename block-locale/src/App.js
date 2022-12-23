import './App.css';
import {useState} from 'react';
import {ethers} from 'ethers';
import Election from './artifacts/contracts/Election.sol/Election.json'

const ballotAddress = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512"

function App() {
  async function requestAccount(){ //connect to the metamask wallet of a user
    await window.ethereum.request({method: 'eth_requestAccounts'}); //request account info and promp connection of a metamask account
  }

  /*
  async function whoIsOwner(){ //who is the owner of the contract
    const provider = new ethers.providers.Web3Provider(window.ethereum)
    const contract = new ethers.Contract(ballotAddress, Election.abi, provider)
    try {
      const data = await contract.chairperson()
      console.log('Chairperson: ', data)
    } catch (err) {
      console.log("Error: ", err)
    }
  }
  */

  return (
    <div className="App">
      <header className="App-header">
        <h1>Voting Application </h1>
        <h3>Contract Address: {ballotAddress}</h3>
      </header>
    </div>
  );
}

export default App;
