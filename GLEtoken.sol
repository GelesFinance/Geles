pragma solidity ^0.4.26;

import "openzeppelin-solidity/contracts/utils/math/SafeMath.sol";

 // Creating a contract 
contract Gelestoken {
    string public constant name = "Geles Token"; // full coin name
    string public constant symbol = "GLE";       // abbreviated coin name-symbol
    uint32 public constant decimals = 18;        // number of decimal places in the blockchain
    uint256 public constant initialSupply = 12500000*(10**uint256(decimals)); //total supply is 12 500 000 GLE
    uint256 public constant decimal_mod = 10**uint256(decimals);

    address owner;                            //contract owner's address
    
    function Gletoken() public {               
        owner = msg.sender;                  //assigning the contract creator address 
    }

    mapping (address => uint) balances;       // array that stores pairs (key => value)
    mapping (address => mapping(address => uint)) allowed; // array that stores pairs (key => value)

//CrowdSale structure for iCO
struct CrowdSale {
uint stage;          //ICO Stages 1..3
uint srart;          //ICO start date for each ICO stage in UNIX
uint end;            //ICO finish date for each ICO stage in UNIX
uint256 total;       //GLE amount for each ICO stage
uint min;            //min GLE amount to buy
uint max;            //max GLE amount to buy
uint price;          //GLE price in BUSD mult 10
}

//ICO stages
//First
/*
Stage 1,
Launch date 06/05/2022 (mm/dd/yyyy) in Unix,
Finih date 06/19/2022 (mm/dd/yyyy) in Unix,
Sold volume is 2 000 000 GLE,
Min to buy is 10 GLE,
Max to buy is 200 000 GLE,
GLE price is 0,3 in BUSD equivalent.
*/
CrowdSale ICO_1 = CrowdSale(1,1654430400,1655640000, 2000000*decimal_mod, 10*decimal_mod, 200000*decimal_mod,3);

//Second
/*
Stage 2,
Launch date 06/26/2022 (mm/dd/yyyy) in Unix,
Finih date 07/10/2022 (mm/dd/yyyy) in Unix,
Sold volume is 4 000 000 GLE,
Min to buy is 10 GLE,
Max to buy is 400 000 GLE,
GLE price is 0,4 in BUSD equivalent.
*/
CrowdSale ICO_2 = CrowdSale(2,1656072000,1657454400, 4000000*decimal_mod, 10*decimal_mod, 400000*decimal_mod,4);

//Second
/*
Stage 3,
Launch date 07/17/2022 (mm/dd/yyyy) in Unix,
Finih date 07/31/2022 (mm/dd/yyyy) in Unix,
Sold volume is 5 000 000 GLE,
Min to buy is 10 GLE,
Max to buy is 500 000 GLE,
GLE price is 0,5 in BUSD equivalent.
*/
CrowdSale ICO_3 = CrowdSale(3,1658059200,1659268800, 5000000*decimal_mod, 10*decimal_mod, 500000*decimal_mod,5);

//Token freez/unlock

uint public constant date_team_free = 1704024000;  //Tokens will be unlock 12/31/2023 in Unix
uint public constant date_adv_free = 1704024000;   //Tokens will be unlock 12/31/2023 in Unix
uint public constant date_marketing_free = 1652616000;   //Tokens will be unlock 05/15/2022 in Unix
uint public constant date_platform_free = 1659355200;   //Tokens will be unlock 08/01/2022 in Unix
uint public constant date_otherExp_free = 1659355200;   //Tokens will be unlock 08/01/2022 in Unix

uint256 public constant Team_revard = 500000*decimal_mod;  //Team revard is 500 000 GLE 
uint256 public constant Adv_revard = 200000*decimal_mod;  //Advisors revard is 200 000 GLE
uint256 public constant Marketing = 500000*decimal_mod;  //Marketing is 200 000 GLE
uint256 public constant Platform = 200000*decimal_mod;   //Platform needs 200 000 GLE
uint256 public constant otherExp = 100000*decimal_mod;   //Other expressions is 100 000 GLE


 //function sends Team reward after 1.5 years
    function transfer_Team_Revards(address _to) public returns (bool success) {
          require(msg.sender == owner);   //Only contracts owner can use it
          require(now > date_team_free);  //If tokens are unlcked               
        if(balances[msg.sender] >= Team_revard && balances[_to] + Team_revard >= balances[_to]) {  //balance check
            balances[msg.sender] -= Team_revard;                                       //subtraction Team_revard from sender balance
            balances[_to] += Team_revard;                                             //replenishment Team_revard of the _to balance 
         emit   Transfer(msg.sender, _to, Team_revard);                                     //function execution
            return true;           //returns true if successful
        } 
        return false;              //returns false on error
    }

     //function sends Advisors reward after 1.5 years
    function transfer_Advisors_Revards(address _to) public returns (bool success) {
          require(msg.sender == owner);   //Only contracts owner can use it
          require(now > date_adv_free);  //If tokens are unlcked               
        if(balances[msg.sender] >= Adv_revard && balances[_to] + Adv_revard >= balances[_to]) {  //balance check
            balances[msg.sender] -= Adv_revard;                                       //subtraction Adv_revard from sender balance
            balances[_to] += Adv_revard;                                             //replenishment Adv_revard of the _to balance 
         emit   Transfer(msg.sender, _to, Adv_revard);                                     //function execution
            return true;           //returns true if successful
        } 
        return false;              //returns false on error
    }

 //function unlock GLE for Marketing
    function transfer_Marketing_Unlock(address _to) public returns (bool success) {
          require(msg.sender == owner);   //Only contracts owner can use it
          require(now > date_marketing_free);  //If tokens are unlcked               
        if(balances[msg.sender] >= Marketing && balances[_to] + Marketing >= balances[_to]) {  //balance check
            balances[msg.sender] -= Marketing;                                       //subtraction Marketing from sender balance
            balances[_to] += Marketing;                                             //replenishment Marketing of the _to balance 
         emit   Transfer(msg.sender, _to, Marketing);                                     //function execution
            return true;           //returns true if successful
        } 
        return false;              //returns false on error
    }

    //function unlock GLE for Platform
    function transfer_Platform_Unlock(address _to) public returns (bool success) {
          require(msg.sender == owner);   //Only contracts owner can use it
          require(now > date_platform_free);  //If tokens are unlcked               
        if(balances[msg.sender] >= Platform && balances[_to] + Platform >= balances[_to]) {  //balance check
            balances[msg.sender] -= Platform;                                       //subtraction Platform from sender balance
            balances[_to] += Platform;                                             //replenishment Platform of the _to balance 
         emit   Transfer(msg.sender, _to, Platform);                                     //function execution
            return true;           //returns true if successful
        } 
        return false;              //returns false on error
    }

    //function unlock GLE for Other expressions
    function transfer_OtherExp_Unlock(address _to) public returns (bool success) {
          require(msg.sender == owner);   //Only contracts owner can use it
          require(now > date_otherExp_free);  //If tokens are unlcked               
        if(balances[msg.sender] >= otherExp && balances[_to] +otherExp >= balances[_to]) {  //balance check
            balances[msg.sender] -= otherExp;                                       //subtraction otherExp from sender balance
            balances[_to] += otherExp;                                             //replenishment otherExp of the _to balance 
         emit   Transfer(msg.sender, _to, otherExp);                                     //function execution
            return true;           //returns true if successful
        } 
        return false;              //returns false on error
    }


    
    //function returns the number of coins owned by _owner
    function balanceOf(address _owner) public constant returns (uint balance) {
        return balances[_owner];
    }

    //function sends _value coins to address _to.
    function transfer(address _to, uint _value) public returns (bool success) {
        if(balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {  //balance check
            balances[msg.sender] -= _value;                                       //subtraction _value from sender balance
            balances[_to] += _value;                                             //replenishment _value of the _to balance 
         emit   Transfer(msg.sender, _to, _value);                                     //function execution
            return true;           //returns true if successful
        } 
        return false;              //returns false on error
    }
    
    //function sends _value coins _from adress to address _to
    function transferFrom(address _from, address _to, uint _value) public returns (bool success) {
        if( allowed[_from][msg.sender] >= _value && balances[_from] >= _value   && balances[_to] + _value >= balances[_to]) {  //balance check and overflow check
            allowed[_from][msg.sender] -= _value;                              //_from address validation
            balances[_from] -= _value;                                         //subtraction _value from sender balance
            balances[_to] += _value;                                           //replenishment _value of the _to balance 
      emit  Transfer(_from, _to, _value);                                       //function execution
            return true;                                //returns true if successful
        } 
        return false;                                    //returns false on error
    }

    //Allows the user _spender to withdraw funds from the account no more than _value
    function approve(address _spender, uint _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
      emit  Approval(msg.sender, _spender, _value);
        return true;
    }
    
    //Returns amount of coins from the user _owner account allowed to withdraw from the user _spender account.
    function allowance(address _owner, address _spender) public constant returns (uint remaining) {
        return allowed[_owner][_spender];
    }
    
    //Event when coins are moving 
    event Transfer(address indexed _from, address indexed _to, uint _value);
    //Event when coins are allowed to be withdrawn
    event Approval(address indexed _owner, address indexed _spender, uint _value);
    
//coefficients compensation algorithms coefficients
uint256 public constant k1 = 356;    //user transactions volume
uint256 public constant k2 = 640;     //user transactions number
uint256 public constant k3 = 711;    //user GLE balance

uint256 P;         //compensation percentage
uint256 R;         //transaction fee in used token
uint256 C;         //average ratio coefficient of the used token to GLE

//transaction fee compensation
function compensation(address _from, address _to, uint _value, uint256 _L, uint256 _M,uint256 _B) private returns (bool success) {
require(msg.sender == owner);              //Only contracts owner can perform it
P = (k1*_L)+(k2*_M)+(k3*_B);               //User activity calculation
if (P < 200000) P = 0;                      //First boundary condition
if (P > 5000000) P = 5000000;               //Second boundary condition
_value = (P*R*C)/100;                       //Amount of compensation in GLE
if (_value>0)                               //Amount check
emit  Transfer(_from, _to, _value);         //Compensation transfer 
return true;                                //returns true if successful
}

//CrowdSale data
uint256 public constant SoftCap = 2971370;    //SoftCap value in BUSD 
uint256 public constant HardCap = 4650000;     //HardCap value in BUSD
uint256 public constant Stages = 3;            //Total ICO stages

mapping (bytes32 => string) ratio;       //array of pairs (any coin ratio => BUSD), required for conversion

//Ratio setting function
 function setRatio(string _key,string _value) public {
        require(msg.sender == owner);                      //Only contracts owner can use it
        ratio[keccak256(abi.encode(_key))] = _value;      //write any coin ratio => BUSD    
    }

 //Ratio read function   
    function getRatio(string _key) public constant returns(string) {
        return ratio[keccak256(abi.encode(_key))];       //read any coin ratio => BUSD  
    }

}

 library SafeMath {
    
  function mul(uint256 a, uint256 b) internal  constant returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }
 
  function div(uint256 a, uint256 b) internal constant returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }
 
  function sub(uint256 a, uint256 b) internal constant returns (uint256) {
    assert(b <= a);
    return a - b;
  }
 
  function add(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
  
}
