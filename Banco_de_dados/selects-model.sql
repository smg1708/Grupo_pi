USE VagasIQ;

-- BUSCAR ZONA COM MENOS SEGURADOS
CREATE VIEW view_zona_seguros AS
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

SELECT * FROM view_zona_seguros;

-- BUSCAR FAIXA ETÁRIA MAIS NUMEROSA
CREATE VIEW view_faixa_etaria AS
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
    
SELECT * FROM view_faixa_etaria;
    
-- BUSCAR ANO DO VEÍCULO MAIS COMUM
CREATE VIEW view_ano_veiculo AS
SELECT ano_veiculo,
       COUNT(*) AS totalVeiculos
	FROM veiculo
	GROUP BY ano_veiculo
	ORDER BY totalVeiculos DESC;
    
SELECT * FROM view_ano_veiculo;	
    
-- BUSCAR GENERO MAIS NUMEROSO
CREATE VIEW view_genero AS
SELECT CASE
		WHEN genero = 'F' THEN 'Feminino'
		ELSE 'Masculino'
    END AS generoPredominante,
    COUNT(id_condutor) AS totalCondutores
    FROM condutor
    GROUP BY generoPredominante
	ORDER BY totalCondutores DESC
    LIMIT 1;
    
SELECT * FROM view_genero;
    
-- BUSCAR FAIXA ETÁRIA DE ACORDO COM UMA REGIÃO ESPECÍFICA
CREATE VIEW view_faixa_etaria_regiao AS
SELECT l.regiao AS Regiao,
		CASE
		    WHEN TIMESTAMPDIFF(YEAR, c.dt_nasc, now()) < 26 THEN '18-25'
		    WHEN TIMESTAMPDIFF(YEAR, dt_nasc, now()) < 36 THEN '26-35'
		    WHEN TIMESTAMPDIFF(YEAR, dt_nasc, now()) < 46 THEN '36-45'
		    WHEN TIMESTAMPDIFF(YEAR, dt_nasc, now()) < 60 THEN '46-59'
		    ELSE '+60'
	    END AS faixaEtaria,
	    COUNT(c.id_condutor) AS totalCondutores,
        genero
        FROM condutor AS c JOIN cadastro_veiculo AS cv
        ON c.id_condutor = cv.fk_condutor
        JOIN registro AS r 
        ON c.id_condutor = r.fk_condutor
        JOIN sensor AS s
        ON s.id_sensor = r.fk_sensor
        JOIN vaga AS v
        ON v.fk_sensor = s.id_sensor
        JOIN localizacao AS l
        ON l.id_localizacao = v.fk_localizacao
        GROUP BY regiao, faixaEtaria, genero
        ORDER BY totalCondutores DESC;

SELECT * FROM view_faixa_etaria_regiao
WHERE regiao = 'Sul';
        
-- BUSCAR ANO DO VEÍCULO MAIS COMUM POR REGIÃO ESPECÍFICA
CREATE VIEW view_ano_veiculo_regiao AS
SELECT ano_veiculo,
		regiao AS Regiao,
       COUNT(*) AS totalVeiculos
	FROM veiculo AS ve JOIN cadastro_veiculo AS cv
        ON ve.id_veiculo = cv.fk_veiculo
        JOIN registro AS r 
        ON ve.id_veiculo = r.fk_veiculo
        JOIN sensor AS s
        ON s.id_sensor = r.fk_sensor
        JOIN vaga AS v
        ON v.fk_sensor = s.id_sensor
        JOIN localizacao AS l
        ON l.id_localizacao = v.fk_localizacao
	GROUP BY ano_veiculo, regiao
	ORDER BY regiao, ano_veiculo, totalVeiculos DESC;
    
SELECT * FROM view_ano_veiculo_regiao
WHERE regiao = 'Centro';
    
-- BUSCAR GENERO MAIS NUMEROSO POR REGIÃO ESPECÍFICA
CREATE VIEW view_genero_regiao AS
SELECT l.regiao AS regiao,
		CASE
		WHEN genero = 'F' THEN 'Feminino'
		ELSE 'Masculino'
    END AS generoPredominante,
    COUNT(id_condutor) AS totalCondutores
    FROM condutor AS c JOIN cadastro_veiculo AS cv
        ON c.id_condutor = cv.fk_condutor
        JOIN registro AS r 
        ON c.id_condutor = r.fk_condutor
        JOIN sensor AS s
        ON s.id_sensor = r.fk_sensor
        JOIN vaga AS v
        ON v.fk_sensor = s.id_sensor
        JOIN localizacao AS l
        ON l.id_localizacao = v.fk_localizacao
    GROUP BY generoPredominante, regiao
	ORDER BY totalCondutores DESC;

SELECT * FROM view_genero_regiao
WHERE regiao = 'Sul';

-- BUSCAR GENERO MAIS NUMEROSO POR REGIÃO ESPECÍFICA GRÁFICO
CREATE VIEW view_genero_grafico AS
SELECT l.regiao AS regiao,
	CASE
		WHEN genero = 'F' THEN 'Feminino'
		ELSE 'Masculino'
    END AS generoPredominante,
    COUNT(id_condutor) AS totalCondutores
    FROM condutor AS c JOIN cadastro_veiculo AS cv
        ON c.id_condutor = cv.fk_condutor
        JOIN registro AS r 
        ON c.id_condutor = r.fk_condutor
        JOIN sensor AS s
        ON s.id_sensor = r.fk_sensor
        JOIN vaga AS v
        ON v.fk_sensor = s.id_sensor
        JOIN localizacao AS l
        ON l.id_localizacao = v.fk_localizacao
    GROUP BY generoPredominante, regiao
	ORDER BY totalCondutores DESC;
    
SELECT * FROM view_genero_grafico
WHERE regiao = 'Centro';

-- BUSCAR FAIXA ETÁRIA DE ACORDO COM UMA REGIÃO ESPECÍFICA
CREATE VIEW view_faixa_etaria_grafico AS
SELECT l.regiao AS regiao,
	CASE
		WHEN c.genero = 'F' THEN 'Feminino'
		ELSE 'Masculino'
		END AS genero,
	CASE
		    WHEN TIMESTAMPDIFF(YEAR, c.dt_nasc, now()) < 26 THEN '18-25'
		    WHEN TIMESTAMPDIFF(YEAR, dt_nasc, now()) < 36 THEN '26-35'
		    WHEN TIMESTAMPDIFF(YEAR, dt_nasc, now()) < 46 THEN '36-45'
		    WHEN TIMESTAMPDIFF(YEAR, dt_nasc, now()) < 60 THEN '46-59'
		    ELSE '+60'
	    END AS faixaEtaria,
	    COUNT(c.id_condutor) AS totalCondutores
        FROM condutor AS c JOIN cadastro_veiculo AS cv
        ON c.id_condutor = cv.fk_condutor
        JOIN registro AS r 
        ON c.id_condutor = r.fk_condutor
        JOIN sensor AS s
        ON s.id_sensor = r.fk_sensor
        JOIN vaga AS v
        ON v.fk_sensor = s.id_sensor
        JOIN localizacao AS l
        ON l.id_localizacao = v.fk_localizacao
        GROUP BY 
        genero,
        regiao,
        faixaEtaria
        ORDER BY totalCondutores DESC;
	
SELECT * FROM view_faixa_etaria_grafico
WHERE regiao = 'Sul';
    
-- Ocupação das vagas por intervalo de tempo

-- Distribuição de condutores por tipo de veículo
CREATE VIEW view_condutores_veiculo_regiao AS
SELECT 
	l.regiao AS regiao,
    v.tipo AS tipo_veiculo,
    COUNT(DISTINCT c.id_condutor) AS total_condutores
	FROM condutor AS c
	JOIN cadastro_veiculo AS cv
	ON c.id_condutor = cv.fk_condutor
	JOIN veiculo AS v
	ON v.id_veiculo = cv.fk_veiculo
	JOIN registro AS r
	ON r.fk_condutor = c.id_condutor
	JOIN sensor AS s
	ON s.id_sensor = r.fk_sensor
	JOIN vaga AS va
	ON va.fk_sensor = s.id_sensor
	JOIN localizacao AS l
	ON l.id_localizacao = va.fk_localizacao
	GROUP BY v.tipo, regiao
	ORDER BY total_condutores DESC;

SELECT * FROM view_condutores_veiculo_regiao
WHERE regiao = 'Sul';

-- Proporção de indivíduos com e sem seguros
CREATE VIEW view_individuo_seguro AS
SELECT
		l.regiao AS regiao,
    CASE 
        WHEN v.seguro = 1 THEN 'Com seguro'
        ELSE 'Sem seguro'
    END AS status_seguro,
    COUNT(DISTINCT c.id_condutor) AS total_condutores
FROM condutor AS c
JOIN cadastro_veiculo AS cv
    ON cv.fk_condutor = c.id_condutor
JOIN veiculo AS v
    ON v.id_veiculo = cv.fk_veiculo
JOIN registro AS r
    ON r.fk_condutor = c.id_condutor
JOIN sensor AS s
    ON s.id_sensor = r.fk_sensor
JOIN vaga AS va
    ON va.fk_sensor = s.id_sensor
JOIN localizacao AS l
    ON l.id_localizacao = va.fk_localizacao 
GROUP BY status_seguro, regiao
ORDER BY total_condutores DESC;

SELECT * FROM view_individuo_seguro
WHERE regiao = 'Sul';	
        
SHOW TABLES;
        
        select l.regiao as regiao,
            sum(r.situacao = 1) as ocupados,
            extract(hour from r.dt_registro) as data,
            count(*) as total_sensores
        from localizacao as l 
        join vaga as v  
            on l.id_localizacao = v.fk_localizacao
        join sensor as s 
            on v.fk_sensor = s.id_sensor
        join registro as r 
            on s.id_sensor = r.fk_sensor
        where l.regiao = 'sul'
        group by r.dt_registro
        order by r.dt_registro;
        
        select l.regiao as regiao,
            (sum(distinct(r.situacao))) as ultimo,
            extract(hour from r.dt_registro) as data,
            (select count(id_sensor) from sensor) as total_sensores
        from localizacao as l 
        join vaga as v  
            on l.id_localizacao = v.fk_localizacao
        join sensor as s 
            on v.fk_sensor = s.id_sensor
        join registro as r 
            on s.id_sensor = r.fk_sensor
        where l.regiao = 'sul'
        group by r.dt_registro
        order by r.dt_registro;
        
select count(distinct fk_sensor) from registro order by dt_registro;
        
select l.regiao, 
(select count(id_sensor) as total_sensores_regiao
	from sensor join vaga on fk_sensor = id_sensor
		join localizacao on fk_localizacao = id_localizacao
        where regiao = 'centro') as total_sensores,
(select count(distinct fk_sensor) from registro where situacao = 1 order by dt_registro desc) as total_ocupados,
date_format(dt_registro, '%H:%i') as data
from localizacao as l 
        join vaga as v  
            on l.id_localizacao = v.fk_localizacao
        join sensor as s 
            on v.fk_sensor = s.id_sensor
        join registro as r 
            on s.id_sensor = r.fk_sensor
		where l.regiao = 'Centro'
		group by l.regiao, total_ocupados, data;
        
select count(id_sensor) as total_sensores_regiao
	from sensor join vaga on fk_sensor = id_sensor
		join localizacao on fk_localizacao = id_localizacao
        where regiao = 'centro';
-- 1,2,12,13,33

select * from vaga;
select * from usuario;
select count(distinct(r.situacao)),
	l.regiao 
from localizacao as l 
        join vaga as v  
            on l.id_localizacao = v.fk_localizacao
        join sensor as s 
            on v.fk_sensor = s.id_sensor
        join registro as r 
            on s.id_sensor = r.fk_sensor
		where l.regiao = 'Centro';
        
        SELECT * FROM view_condutores_veiculo_regiao
    WHERE regiao = 'Norte';
select count(distinct fk_sensor) from registro where situacao = 1 order by dt_registro desc;


SELECT fk_sensor, situacao, dt_registro
FROM registro
ORDER BY dt_registro DESC
LIMIT 20;

select * from registro;

SELECT 
    ultimo_registro.horario,

    -- total de sensores fixo
    (
        SELECT COUNT(id_sensor)
        FROM sensor 
        JOIN vaga ON fk_sensor = id_sensor
        JOIN localizacao ON fk_localizacao = id_localizacao
        WHERE regiao = 'Sul'
    ) AS total_sensores,

    -- quantos estão ocupados
    SUM(ultimo_registro.situacao = 1) AS total_ocupados

FROM (
    SELECT 
        fk_sensor,
        situacao,
        DATE_FORMAT(dt_registro, '%H:%i') AS horario
    FROM registro r1
    WHERE dt_registro = (
        SELECT MAX(r2.dt_registro)
        FROM registro r2
        WHERE r2.fk_sensor = r1.fk_sensor
    )
) AS ultimo_registro

JOIN sensor s ON ultimo_registro.fk_sensor = s.id_sensor
JOIN vaga v ON s.id_sensor = v.fk_sensor
JOIN localizacao l ON v.fk_localizacao = l.id_localizacao

WHERE l.regiao = 'Sul'

GROUP BY ultimo_registro.horario
ORDER BY ultimo_registro.horario;

select l.regiao,
	v.apelido
        from localizacao as l 
        join vaga as v  
            on l.id_localizacao = v.fk_localizacao
        join sensor as s 
            on v.fk_sensor = s.id_sensor
        join registro as r 
            on s.id_sensor = r.fk_sensor
        where l.regiao = 'sul';
        
        select * from vaga;
        select * from registro;