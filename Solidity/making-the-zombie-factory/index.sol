pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    //6.Event
    event NewZombie(uint256 zombieId, string name, uint256 dna);

    // 1.State variables
    //State variables are permanently stored in contract storage. This means they're written to the Ethereum blockchain. Think of them like writing to a DB.
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    //2.Struct
    struct Zombie {
        string name;
        uint256 dna;
    }

    //3.array
    // public make other can read but can't write
    Zombie[] public zombies;

    //3.Function
    //Keyword memory to pass by value. This is required for all reference types such as arrays, structs, mappings, and strings
    function createZombie(string memory _name, uint256 _dna) public {
        zombies.push(Zombie(_name, _dna));
    }

    //4. Private/Public function
    //This mean only other function within our contract will be able to call this
    function _createZombie(string memory _name, uint256 _dna) private {
        uint256 id = zombies.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna);
    }

    //5.More on Functions
    function _generateRandomDna(string memory _str)
        private
        view
        returns (uint256)
    {
        uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
