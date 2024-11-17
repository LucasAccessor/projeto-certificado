// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CertificadoCurso {
    // Estrutura do Certificado
    struct Certificado {
        uint id;
        string nomeAluno;
        string curso;
        string dataEmissao;
        bool valido;
    }

    // Mapeamento de certificados por ID
    mapping(uint => Certificado) public certificados;

    // Evento para notificar ações
    event CertificadoRegistrado(uint id, string nomeAluno, string curso, string dataEmissao);
    event CertificadoRevogado(uint id);

    // Função para registrar um novo certificado
    function registrarCertificado(
        uint _id,
        string memory _nomeAluno,
        string memory _curso,
        string memory _dataEmissao
    ) public {
        require(certificados[_id].id == 0, "Certificado com este ID ja existe.");

        certificados[_id] = Certificado({
            id: _id,
            nomeAluno: _nomeAluno,
            curso: _curso,
            dataEmissao: _dataEmissao,
            valido: true
        });

        emit CertificadoRegistrado(_id, _nomeAluno, _curso, _dataEmissao);
    }

    // Função para consultar a validade de um certificado pelo ID
    function consultarCertificado(uint _id) public view returns (
        string memory nomeAluno,
        string memory curso,
        string memory dataEmissao,
        bool valido
    ) {
        require(certificados[_id].id != 0, "Certificado nao encontrado.");
        Certificado memory cert = certificados[_id];
        return (cert.nomeAluno, cert.curso, cert.dataEmissao, cert.valido);
    }

    // Função para revogar um certificado
    function revogarCertificado(uint _id) public {
        require(certificados[_id].id != 0, "Certificado nao encontrado.");
        require(certificados[_id].valido == true, "Certificado ja esta revogado.");

        certificados[_id].valido = false;

        emit CertificadoRevogado(_id);
    }
}
