// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "https://github.com/jeffprestes/cursosolidity/blob/master/bradesco_token_aberto.sol";
// Endereço do contrato: 0xb45D965b8a4DdB72D96de0098dD3936700DFC81a

contract Custody {

    string nomeCliente;
    address payable clientAccount;

    ExercicioToken token;

    constructor (string memory _nomeCliente) {
        nomeCliente = _nomeCliente;
        clientAccount = payable(msg.sender);
        token = new ExercicioToken();
    }

    function meuSaldo() view public returns(uint256) {
        return token.balanceOf(address(this));
    }

    function gerarTokenParaEuCliente(uint256 _amount) public returns(bool) {
        require(msg.sender == clientAccount);
        return token.mint(address(this), _amount);
    }

    function transferTokens(address payable _to, uint256 _amount) public returns(bool) {
        require(msg.sender == clientAccount);
        return token.transfer(_to, _amount);
    } 

    function saldoContrato() public view returns (uint256) {
        return address(this).balance;
    }

    function transfereMoedaNativa(address payable _to, uint256 _amount) public  {
        require(msg.sender == clientAccount);
        _to.transfer(_amount);
    }

    receive() external payable {}

}
