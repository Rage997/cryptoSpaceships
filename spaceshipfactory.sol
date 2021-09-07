/*
A spaceship factory class. It handles the creation of new spaceships and monitoring of existing ones 
*/
pragma solidity >=0.5.0 <0.8.8;

import "./ownable.sol";
import "./safemath.sol";

contract SpaceshipFactory is Ownable {

  using SafeMath for uint256;
  using SafeMath32 for uint32;
  using SafeMath16 for uint16;

  event NewSpaceship(uint shipId, string name, uint dna);

  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;
  uint cooldownTime = 1 days; // the cooldown for each spaceship to perform any action

  struct Spaceship {
    string name;
    uint dna;
    uint32 level;
    uint32 readyTime;
    uint16 winCount;
    uint16 lossCount;
  }

  Spaceship[] public spaceships;

  mapping (uint => address) public SpaceshipToOwner;
  mapping (address => uint) ownerSpaceshipCount;

  function _createSpaceship(string memory _name, uint _dna) internal {
    uint id = spaceships.push(Spaceship(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) - 1;
    SpaceshipToOwner[id] = msg.sender;
    ownerSpaceshipCount[msg.sender] = ownerSpaceshipCount[msg.sender].add(1);
    emit NewSpaceship(id, _name, _dna);
  }

  function _generateRandomDna(string memory _str) private view returns (uint) {
    uint rand = uint(keccak256(abi.encodePacked(_str)));
    return rand % dnaModulus;
  }

  function createRandomSpaceship(string memory _name) public {
    require(ownerSpaceshipCount[msg.sender] == 0);
    uint randDna = _generateRandomDna(_name);
    randDna = randDna - randDna % 100;
    _createSpaceship(_name, randDna);
  }

}