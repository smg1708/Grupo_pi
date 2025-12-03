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

    var instrucaoSql = `

SELECT 
    DATE_FORMAT(r.dt_registro, '%H:%i') AS horario,

    (
        SELECT COUNT(id_sensor)
        FROM sensor 
        JOIN vaga ON fk_sensor = id_sensor
        JOIN localizacao ON fk_localizacao = id_localizacao
        WHERE regiao = '${regiao}'
    ) AS total_sensores,

    SUM(r.situacao = 1) AS total_ocupados

FROM registro r
JOIN sensor s ON r.fk_sensor = s.id_sensor
JOIN vaga v ON s.id_sensor = v.fk_sensor
JOIN localizacao l ON v.fk_localizacao = l.id_localizacao

WHERE l.regiao = '${regiao}'

GROUP BY horario
ORDER BY horario;


    `;

   console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
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