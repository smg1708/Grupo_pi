var dashboardModel = require("../models/dashboardModel");

function listarZona(req, res) {

    dashboardModel.listarZona().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao listar Zona: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    })
}

function listarFaixaEtaria(req, res) {

    dashboardModel.listarFaixaEtaria().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao listar FaixaEtaria: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    })
}

function listarAnoVeiculo(req, res) {

    dashboardModel.listarAnoVeiculo().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao listar Ano Veículo: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    })
}

function listarGenero(req, res) {
    dashboardModel.listarGenero().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao listar Ano Veículo: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    })
}

function listarFaixa(req, res) {
    dashboardModel.listarFaixa().then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao listar Faixa Etaria: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    })
}

module.exports = {
    listarZona,
    listarFaixaEtaria,
    listarAnoVeiculo,
    listarGenero,
    listarFaixa
}
