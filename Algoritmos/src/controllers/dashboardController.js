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

function listarFaixaEtariaRegiao(req, res) {
    var regiao = req.params.regiao;

    dashboardModel.listarFaixaEtariaRegiao(regiao).then(function (resultado) {
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

function listarAnoVeiculoRegiao(req, res) {
    var regiao = req.params.regiao;

    dashboardModel.listarAnoVeiculoRegiao(regiao).then(function (resultado) {
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

function listaGeneroRegiao(req, res) {
    var regiao = req.params.regiao;

    dashboardModel.listaGeneroRegiao(regiao).then(function (resultado) {
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

function listarGraficoGenero(req, res) {
    var regiao = req.params.regiao;

    dashboardModel.listarGraficoGenero(regiao).then(function (resultado) {
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

function listarGraficoFaixaEtaria(req, res) {
    var regiao = req.params.regiao;

    dashboardModel.listarGraficoFaixaEtaria(regiao).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao listar Faixa Etária: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    })
}

function listarGraficoCondutorVeiculo(req, res) {
    var regiao = req.params.regiao;

    dashboardModel.listarGraficoCondutorVeiculo(regiao).then(function (resultado) {
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

module.exports = {
    listarZona,
    listarFaixaEtaria,
    listarAnoVeiculo,
    listarGenero,
    listarFaixaEtariaRegiao,
    listarAnoVeiculoRegiao,
    listaGeneroRegiao,
    listarGraficoGenero,
    listarGraficoFaixaEtaria,
    listarGraficoCondutorVeiculo
}
