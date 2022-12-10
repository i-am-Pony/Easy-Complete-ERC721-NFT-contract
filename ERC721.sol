// this is where you state your license
// SPDX-License-Identifier: MIT

// state your compiler
pragma solidity ^0.8.13;

// here is where you import your parent / inherited contracts
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// identify your contract and parents inherited from as "is"
contract YOUR_NFT is ERC721, Ownable {
    using Counters for Counters.Counter;

     Counters.Counter private _tokenIds;

// these are your variables / strings / constants 
     uint256 public constant MAX_SUPPLY = 0;
     uint256 public constant COST = 0;
     string constant TOKEN_URI ="ipfs://YOUR_IPFS_ADDRESS_HERE";

// a constructor is a line of code used only 1 time, at deployment
    constructor() ERC721("YOUR NFT", "SYMB") {}

// add any events here
    event Withdraw(address, uint256 balance);

// begin adding your functions
// this is your mint function / main work load 
    function mint() public payable {
       require(msg.value >= COST, "Insufficient funds");
       require (MAX_SUPPLY >= _tokenIds.current(), "You cannot mint anymore");

       _tokenIds.increment();
       _safeMint(msg.sender, _tokenIds.current());
    }


// sets your ipfs address / where your collection resides
    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://YOUR_IPFS_ADDRESS_HERE";
    }

// sets total NFT supply
    function totalSupply() public view returns (uint256) {
        return _tokenIds.current();
    }

// here is your withdraw function to extract funds from contract
   function withdrawFunds() external onlyOwner {
       uint256 balance = address(this).balance;
       require(balance > 0, "Nothing left to withdraw");
       (bool success, ) = (msg.sender).call{value: balance} ("");
       require(success, "Withdraw Failed");
       emit Withdraw(msg.sender, balance);
    }  

}
