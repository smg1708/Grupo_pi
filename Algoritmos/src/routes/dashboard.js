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

router.get("/kpiFaixaEtaria/:regiao", function(req, res){
    dashboardController.listarFaixaEtariaRegiao(req, res);
})

router.get("/kpiAnoVeiculoRegiao/:regiao", function(req, res){
    dashboardController.listarAnoVeiculoRegiao(req, res);
})

router.get("/kpiGeneroRegiao/:regiao", function(req, res){
    dashboardController.listaGeneroRegiao(req, res);
})

router.get("/obterGraficoGeneroRegiao/:regiao", function(req, res){
    dashboardController.listarGraficoGenero(req, res);
})

router.get("/obterGraficoFaixaEtariaRegiao/:regiao", function(req, res){
    dashboardController.listarGraficoFaixaEtaria(req, res);
})

module.exports = router;