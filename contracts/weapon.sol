/*
Implementation of weapons NFT. Each spaceship can have different types of weapons
*/

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Weapon is ERC721{
    
    struct Weapon{
        string name;
        uint level;
        uint damage;
        uint dmg_type;
        uint rarityLevel;
    }
    
    Weapon[] public weapons; // First Weapon has Index 0
    address public owner;
    
    function Weapon() public {
        owner = msg.sender;
    }
    
    function createWeapon(string _name, address _to) public{
        require(owner == msg.sender);
        uint id = weapons.length;
        weapons.push(Weapon(_name,5,1, 5, 5))
        _mint(_to, id);
    }
    
}