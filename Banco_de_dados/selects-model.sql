USE VagasIQ;

-- BUSCAR ZONA COM MENOS SEGURADOS
SELECT l.regiao, 
	(SELECT COUNT(DISTINCT id_veiculo) FROM veiculo WHERE seguro = 1) AS temSeguro,
	(SELECT COUNT(DISTINCT id_veiculo) FROM veiculo WHERE seguro = 0) AS naoTemSeguro
FROM localizacao AS l JOIN vaga AS v
	ON fk_localizacao = id_localizacao
JOIN sensor
	ON v.fk_sensor = id_sensor
JOIN registro AS r
	ON r.fk_sensor = id_sensor
JOIN cadastro_veiculo AS cv
	ON cv.fk_veiculo = r.fk_veiculo
JOIN veiculo
	ON cv.fk_veiculo = id_veiculo
GROUP BY l.regiao
ORDER BY naoTemSeguro DESC
LIMIT 1;

-- BUSCAR FAIXA ETÁRIA MAIS NUMEROSA
SELECT CASE
		WHEN TIMESTAMPDIFF(YEAR, dt_nasc, now()) < 26 THEN '18-25'
		WHEN TIMESTAMPDIFF(YEAR, dt_nasc, now()) < 36 THEN '26-35'
		WHEN TIMESTAMPDIFF(YEAR, dt_nasc, now()) < 46 THEN '36-45'
		WHEN TIMESTAMPDIFF(YEAR, dt_nasc, now()) < 60 THEN '46-59'
		ELSE '+60'
	END AS faixaEtaria,
	COUNT(id_condutor) AS totalCondutores
    FROM condutor
    GROUP BY faixaEtaria
    ORDER BY totalCondutores DESC
    LIMIT 1;
    
-- BUSCAR GENERO MAIS NUMEROSO
SELECT CASE
		WHEN genero = 'F' THEN 'Feminino'
		ELSE 'Masculino'
    END AS generoPredominante,
    COUNT(id_condutor) AS totalCondutores
    FROM condutor
    GROUP BY generoPredominante
	ORDER BY totalCondutores DESC
    LIMIT 1;

-- BUSCAR ANO DO VEÍCULO MAIS COMUM
SELECT ano_veiculo,
       COUNT(*) AS totalVeiculos
	FROM veiculo
	GROUP BY ano_veiculo
	ORDER BY totalVeiculos DESC
	LIMIT 1;