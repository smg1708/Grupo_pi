var express = require("express");
var router = express.Router();

var seguradoraController = require("../controllers/seguradoraController");

router.get("/listar", function (req, res) {
  seguradoraController.listar(req, res);
});

module.exports = router;