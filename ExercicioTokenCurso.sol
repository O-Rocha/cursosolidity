// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "https://github.com/jeffprestes/cursosolidity/blob/master/bradesco_token_aberto.sol";
// Endereço do contrato: 0x61861Fb08B1eF48A0bEdd211ad9740Db13088449

contract Custody {

    string nomeCliente;
    address payable clientAccount;

    ExercicioToken token;

    constructor (string memory _nomeCliente, address _tokenAddress) {
        nomeCliente = _nomeCliente;
        clientAccount = payable(msg.sender);
        token = ExercicioToken(_tokenAddress);
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
