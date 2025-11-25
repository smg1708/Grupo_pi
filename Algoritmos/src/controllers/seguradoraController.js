var seguradoraModel = require("../models/seguradoraModel");

function listar(req, res) {
  seguradoraModel.listar().then((resultado) => {
    res.status(200).json(resultado);
  });
}

module.exports = {
  listar
};