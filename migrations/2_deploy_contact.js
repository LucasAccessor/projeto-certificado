const CertificadoCurso = artifacts.require("CertificadoCurso");

module.exports = function (deployer) {
  deployer.deploy(CertificadoCurso);
};
