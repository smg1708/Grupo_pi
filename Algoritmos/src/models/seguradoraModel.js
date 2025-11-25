var database = require("../database/config");

function listar() {
  var instrucaoSql = `SELECT id_seguradora, nome, cnpj, codigo FROM seguradora`;

  return database.executar(instrucaoSql);
}

module.exports = { listar };