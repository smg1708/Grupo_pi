const { listarFaixaEtariaZona } = require("../controllers/dashboardController");
var database = require("../database/config");

function listarZona() {
    var instrucaoSql = `
        SELECT * FROM view_zona_seguros;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarFaixaEtaria() {
    var instrucaoSql = `
        SELECT * FROM view_faixa_etaria;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarAnoVeiculo() {
    var instrucaoSql = `
        SELECT * FROM view_ano_veiculo;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarGenero() {
    var instrucaoSql = `
        SELECT * FROM view_genero;
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarFaixaEtariaRegiao(regiao) {
    var instrucaoSql = `
        SELECT * FROM view_faixa_etaria_regiao
        WHERE regiao = '${regiao}';
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarAnoVeiculoRegiao(regiao) {
    var instrucaoSql = `
    SELECT * FROM view_ano_veiculo_regiao
    WHERE regiao = '${regiao}';
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listaGeneroRegiao(regiao) {
    var instrucaoSql = `
    SELECT * FROM view_genero_regiao
    WHERE regiao = '${regiao}';
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarGraficoGenero(regiao) {
    var instrucaoSql = `
    SELECT * FROM view_genero_grafico
    WHERE regiao = '${regiao}';
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarGraficoFaixaEtaria(regiao) {
    var instrucaoSql = `
    SELECT * FROM view_faixa_etaria_grafico
    WHERE regiao = '${regiao}';
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarGraficoCondutorVeiculo(regiao) {
    var instrucaoSql = `
    SELECT * FROM view_condutores_veiculo_regiao
    WHERE regiao = '${regiao}';
        `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarGraficoIndividuoVeiculo(regiao) {
    var instrucaoSql = `
    SELECT * FROM view_individuo_seguro
    WHERE regiao = '${regiao}';	
        `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarGraficoOcupacao(regiao) {

    var sqlAtivo = `
        select l.regiao as regiao,
            sum(r.situacao = 1) as ocupados,
            r.dt_registro as data,
            count(*) as total_sensores
        from localizacao as l 
        join vaga as v  
            on l.id_localizacao = v.fk_localizacao
        join sensor as s 
            on v.fk_sensor = s.id_sensor
        join registro as r 
            on s.id_sensor = r.fk_sensor
        where l.regiao = '${regiao}'
        group by r.dt_registro
        order by r.dt_registro;
    `;

    var sqlTotal = `
        select l.regiao as regiao,
            count(distinct s.id_sensor) as total_sensores,
            max(r.dt_registro) as data
        from localizacao as l 
        join vaga as v 
            on l.id_localizacao = v.fk_localizacao
        join sensor as s 
            on v.fk_sensor = s.id_sensor
        join registro as r 
            on s.id_sensor = r.fk_sensor
        where l.regiao = '${regiao}'
        group by l.regiao;
    `;

    return database.executar(sqlAtivo).then(resultado1 => {
        return database.executar(sqlTotal).then(resultado2 => {
            return {
                sensores: resultado1,
                resumo: resultado2[0]
            };
        });
    });
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
    listarGraficoCondutorVeiculo,
    listarGraficoIndividuoVeiculo,
    listarGraficoOcupacao
}