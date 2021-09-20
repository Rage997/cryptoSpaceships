// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract SpaceshipBase is Ownable, ERC721 {

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {
    
  }

  mapping (uint256 => address) internal contractOwner;
  
  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;
  uint cooldownTime = 1 days; // the cooldown for each spaceship to perform any action

  event NewSpaceship(uint shipId, string name, uint dna);

  struct Spaceship {
    string name;
    uint dna;
    uint32 level;
    uint32 readyTime;
    uint16 winCount;
    uint16 lossCount;
    // uint[] weapons;
  }

  uint currentId = 0;
  mapping (uint256 => Spaceship) spaceshipDetails;

  function getTokenDetails(uint256 _tokenId) public view returns(Spaceship memory){
    return spaceshipDetails[_tokenId];
  }

  function getAllTokensForUser(address user) public view returns (uint256[] memory){
    uint tokenCount = balanceOf(user);
    if(tokenCount == 0){
      return new uint256[](0);
    }else{
      uint[] memory UserSpaceships = new uint256[](tokenCount);
      uint256 totalSpaceships = currentId;
      uint256 idx = 0;
      for(uint256 i=0; i<totalSpaceships; i++) {
        if(ownerOf(i) == user){
          UserSpaceships[idx] = i;
          idx++;
        } 
      }
      return UserSpaceships;
    }
  }

  function mint(string memory _name, uint _dna) public onlyOwner{
    Spaceship memory newSpaceship = Spaceship(_name, _dna,
                                               0, 0, 0, 0);
    spaceshipDetails[currentId] = newSpaceship;
    _safeMint(msg.sender, currentId);
    currentId += 1;
  }

  function _generateRandomDna(string memory _str) private view returns (uint) {
    uint rand = uint(keccak256(abi.encodePacked(_str)));
    return rand % dnaModulus;
  }

  function createRandomSpaceship(string memory _name) public {
    require(balanceOf(msg.sender) == 0);
    uint randDna = _generateRandomDna(_name);
    randDna = randDna - randDna % 100;
    mint(_name, randDna);
  }
   

}
