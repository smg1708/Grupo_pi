var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

router.get("/kpiZona", function(req, res){
    dashboardController.listarZona(req, res);
})

router.get("/kpiFaixaEtaria", function(req, res){
    dashboardController.listarFaixaEtaria(req, res);
})

router.get("/kpiAnoVeiculo", function(req, res){
    dashboardController.listarAnoVeiculo(req, res);
})

router.get("/kpiGenero", function(req, res){
    dashboardController.listarGenero(req, res);
})

module.exports = router;