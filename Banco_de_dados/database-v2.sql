CREATE DATABASE VagasIQ;

USE VagasIQ;
   
CREATE TABLE seguradora (
	id_seguradora INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(80),
	cnpj CHAR(14) UNIQUE NOT NULL,
	email VARCHAR(80) UNIQUE NOT NULL,
	telefone CHAR(11) NOT NULL,
    codigo CHAR(6) NOT NULL
);

CREATE TABLE usuario (
	id_usuario INT AUTO_INCREMENT,
    fk_seguradora INT,
    CONSTRAINT fk_seguradora_usuario
		FOREIGN KEY (fk_seguradora)
		REFERENCES seguradora(id_seguradora),
    nome VARCHAR(45) NOT NULL,
    cpf CHAR(11) NOT NULL,
    email VARCHAR(80) NOT NULL,
    senha VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_usuario, fk_seguradora)
);

CREATE TABLE localizacao (
	id_localizacao INT PRIMARY KEY AUTO_INCREMENT,
	logradouro VARCHAR(45) NOT NULL,
	cidade VARCHAR(45) NOT NULL,
	bairro VARCHAR(45) NOT NULL
);

CREATE TABLE sensor (
	id_sensor INT PRIMARY KEY AUTO_INCREMENT,
	estado_sensor VARCHAR(20)
);

CREATE TABLE vaga (
	id_vaga INT PRIMARY KEY AUTO_INCREMENT,
	apelido VARCHAR(45) NOT NULL,
	fk_localizacao INT,
	CONSTRAINT fk_localizacao_vaga
		FOREIGN KEY (fk_localizacao)
		REFERENCES localizacao(id_localizacao),
	fk_sensor INT,
    CONSTRAINT fk_sensor_vaga
		FOREIGN KEY (fk_sensor)
        REFERENCES sensor(id_sensor)
);

CREATE TABLE condutor (
	id_condutor INT PRIMARY KEY AUTO_INCREMENT,
	genero CHAR(1) NOT NULL,
		CONSTRAINT cnk_genero 
			CHECK (genero IN ('M', 'F')),
	dt_nasc DATE NOT NULL
);

CREATE TABLE veiculo (
	id_veiculo INT PRIMARY KEY AUTO_INCREMENT,
	ano_veiculo YEAR NOT NULL,
	modelo_veiculo VARCHAR(45) NOT NULL,
	tipo VARCHAR(45),
		CONSTRAINT chk_tipo
			CHECK (tipo IN('Carro', 'Moto', 'Caminhão')),
	seguro TINYINT
);

CREATE TABLE cadastro_veiculo (
	fk_condutor INT,
		CONSTRAINT fk_condutor_cadastro
			FOREIGN KEY (fk_condutor)
				REFERENCES condutor(id_condutor),
	fk_veiculo INT,
		CONSTRAINT fk_veiculo_cadastro
			FOREIGN KEY (fk_veiculo)
				REFERENCES veiculo(id_veiculo),
	dt_cadastro DATE,
	PRIMARY KEY (fk_condutor, fk_veiculo)
);

CREATE TABLE registro (
	id_registro INT,
    fk_sensor INT,
		CONSTRAINT fk_sensor_registro
			FOREIGN KEY (fk_sensor)
				REFERENCES sensor(id_sensor),
	situacao TINYINT,
	dt_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    cadastro_veiculo_fk_condutor INT,
		CONSTRAINT cadastro_veiculo_fk_condutor
			FOREIGN KEY (cadastro_veiculo_fk_condutor)
				REFERENCES cadastro_veiculo(fk_condutor),
	cadastro_veiculo_fk_veiculo INT,
		CONSTRAINT cadastro_veiculo_fk_veiculo
			FOREIGN KEY (cadastro_veiculo_fk_veiculo)
				REFERENCES cadastro_veiculo(fk_veiculo),
	PRIMARY KEY (id_registro, fk_sensor)
);

INSERT INTO seguradora (nome, cnpj, email, telefone, codigo) VALUES
	('Taui Seguros', '52865433233103', 'contato@tauiseguros.com', '11987654321', 'JS36T8'),
	('SeguroPorto', '84765433233103', 'contato@seguroporto.com', '11912345678', 'ME94L3');
    
INSERT INTO usuario (fk_seguradora, nome, cpf, email, senha) VALUES
	(1, 'Maria', '11111111111', 'maria.menezes@gmail.com', '123456'),
	(2, 'Lucas', '22222222222', 'lucas.lopes@gmail.com', '098765'),
	(1, 'Aline', '33333333333', 'aline.alvarenga@gmail.com', '135791'),
	(2, 'Gabriel', '44444444444', 'gabriel.gomes@gmail.com', '864286');
    
INSERT INTO localizacao (logradouro, cidade, bairro) VALUES
	('Av. Paulista', 'São Paulo', 'Bela Vista'),
	('Rua Augusta', 'São Paulo', 'Consolação'),
	('Av. Faria Lima', 'São Paulo', 'Itaim Bibi'),
	('Rua dos Três Irmãos', 'São Paulo', 'Vila Madalena');
    
INSERT INTO sensor (estado_sensor) VALUES
	('Ativo'),
	('Ativo'),
	('Ativo'),
	('Ativo'),
	('Ativo'),
	('Ativo');

INSERT INTO vaga (apelido, fk_localizacao, fk_sensor) VALUES
	('A1', 1, 4),
	('A2', 1, 3),
	('B3', 2, 6),
	('C4', 3, 2),
	('C5', 3, 1),
	('D6', 4, 5);

INSERT INTO condutor (genero, dt_nasc) VALUES
	('M', '1990-05-12'),
	('F', '1985-11-23'),
	('M', '2000-02-14'),
	('F', '1995-07-30'),
	('M', '1988-12-01');
    
INSERT INTO veiculo (ano_veiculo, modelo_veiculo, tipo, seguro) VALUES 
	(2018, 'Onix', 'Carro', 1),
    (2020, 'HB20', 'Carro', 0),
    (2017, 'Honda Biz', 'Moto', 1),
    (2019, 'Scania', 'Caminhão', 1),
    (2012, 'Avelloz', 'Moto', 0);
    
INSERT INTO cadastro_veiculo (fk_condutor, fk_veiculo, dt_cadastro) VALUES
	(1, 5, '2025-11-01'),
	(2, 4, '2025-10-31'),
	(3, 3, '2025-10-26'),
	(4, 2, '2025-11-09'),
	(5, 1, '2025-11-03');
    
INSERT INTO registro (id_registro, fk_sensor, situacao, cadastro_veiculo_fk_condutor, cadastro_veiculo_fk_veiculo) VALUES
	(1, 1, 0, 1, 1), 
	(2, 2, 1, 2, 2), 
	(3, 3, 1, 3, 3), 
	(4, 4, 1, 4, 4), 
	(5, 5, 0, 5, 5);

SELECT * FROM condutor;
SELECT * FROM veiculo;
SELECT * FROM cadastro_veiculo;
SELECT * FROM seguradora;
SELECT * FROM usuario;
SELECT * FROM localizacao; 
SELECT * FROM sensor;
SELECT * FROM registro;

SHOW TABLES;

-- Disponibilidade das vagas de determinada localização
SELECT vaga.apelido AS Vaga,
	CASE
		WHEN registro.situacao = 1 THEN 'Ocupado'
        ELSE 'Livre'
	END AS 'Situação'
FROM localizacao JOIN vaga 
	ON localizacao.id_localizacao = vaga.fk_localizacao
    JOIN sensor 
    ON sensor.id_sensor = vaga.fk_sensor
    JOIN registro 
    ON sensor.id_sensor = registro.fk_sensor
WHERE id_localizacao = 1 AND estado_sensor = 'Ativo';


-- Relação entre o condutor e o seu veículo
SELECT c.genero AS Gênero_Condutor,
    c.dt_nasc AS Data_Nascimento_Condutor,
    v.ano_veiculo AS Ano_Veículo,
    v.modelo_veiculo AS Modelo_Veículo,
    v.tipo AS Tipo_Veículo,
    cv.dt_cadastro AS Data_Cadastro,
    CASE
		WHEN v.seguro = '1' THEN 'Tem seguro'
		ELSE 'Não tem'
    END AS 'Seguro'
FROM condutor AS c JOIN cadastro_veiculo AS cv
ON c.id_condutor = cv.fk_condutor
JOIN veiculo AS v
ON v.id_veiculo = cv.fk_veiculo;
    

-- Todas as vagas de uma determinada rua
SELECT v.apelido AS vaga, 
	logradouro
FROM vaga AS v JOIN localizacao AS l
    ON v.fk_localizacao = l.id_localizacao 
    JOIN sensor AS s
    ON s.id_sensor = v.fk_sensor
    JOIN registro AS r
    ON s.id_sensor = r.fk_sensor
WHERE fk_localizacao = 1;


-- Relação do condutor e as demais tabelas
SELECT c.genero AS Genero,
	c.dt_nasc AS Data_Nascimento,
	v.modelo_veiculo AS Veiculo,
	v.ano_veiculo AS Ano,
	v.tipo AS Tipo,
	r.dt_registro AS Data_Ocupacao,
	va.apelido AS Vaga,
	l.logradouro AS Localizacao,
    cv.dt_cadastro AS Data_Cadastro
FROM veiculo AS v
JOIN cadastro_veiculo AS cv 
	ON v.id_veiculo = cv.fk_condutor
JOIN condutor AS c 
	ON c.id_condutor = cv.fk_condutor
JOIN registro AS r
	ON r.id_registro = cv.fk_condutor
JOIN sensor AS s
	ON r.fk_sensor = s.id_sensor
JOIN vaga AS va
	ON va.fk_sensor = s.id_sensor
JOIN localizacao AS l
	ON va.fk_localizacao = l.id_localizacao;
    
    
-- Relação do condutor e o veículo e registro com um tipo de veículo específico
SELECT c.genero AS 'Gênero',
	v.ano_veiculo AS 'Ano do veículo',
    v.modelo_veiculo AS 'Modelo do veículo',
    v.tipo AS 'Tipo de veículo',
    r.situacao AS 'Situacao',
    r.dt_registro AS 'Data do registro',
    cv.dt_cadastro AS 'Data do cadastro'
    FROM condutor AS c JOIN cadastro_veiculo AS cv
    ON c.id_condutor = cv.fk_condutor 
    JOIN veiculo AS v
    ON v.id_veiculo = cv.fk_veiculo
    JOIN registro AS r
    ON r.id_registro = cv.fk_condutor
    WHERE v.tipo = 'carro';


-- Relação entre o genêro e os registros
SELECT CASE 
	WHEN c.genero = 'M' THEN 'Homem'
	ELSE 'Mulher'
	END AS 'Gênero',
	r.dt_registro AS 'Data do Registro'
	FROM condutor AS c JOIN cadastro_veiculo AS cv
	ON cv.fk_condutor = c.id_condutor
    JOIN registro AS r
    ON cv.fk_condutor = r.id_registro;
    
select * from registro;


-- Condutores estacionados em uma determinada localização que possuem ou não seguro
SELECT c.*,
    r.dt_registro,
    l.logradouro
FROM 
	condutor AS c JOIN cadastro_veiculo AS cv
		ON c.id_condutor = cv.fk_condutor
    JOIN registro AS r
		ON r.id_registro = cv.fk_condutor
    JOIN sensor AS s
		ON r.fk_sensor = s.id_sensor
    JOIN vaga AS va
		ON s.id_sensor = va.fk_sensor
    JOIN localizacao AS l
		ON va.fk_localizacao = l.id_localizacao
	WHERE l.logradouro = 'Av. Paulista';
    
-- Qual gênero possui mais ou menos seguro
SELECT c.genero, 
		v.seguro 
		FROM condutor AS c JOIN cadastro_veiculo AS cv
        ON c.id_condutor = cv.fk_condutor
        JOIN veiculo AS v
        ON v.id_veiculo = cv.fk_veiculo;

-- Qual faixa etária possui mais ou menos seguro
SELECT c.dt_nasc, 
		v.seguro 
		FROM condutor AS c JOIN cadastro_veiculo AS cv
        ON c.id_condutor = cv.fk_condutor
        JOIN veiculo AS v
        ON v.id_veiculo = cv.fk_veiculo;

-- Qual gênero de determinada localização possui mais seguro
SELECT c.genero,
	v.seguro,
	l.logradouro,
	l.cidade,
	l.bairro
FROM 
	localizacao AS l JOIN vaga AS va
		ON l.id_localizacao = va.fk_sensor
	JOIN sensor AS s
		ON s.id_sensor = va.fk_sensor
	JOIN registro AS r
		ON s.id_sensor = r.fk_sensor
	JOIN cadastro_veiculo AS cv
		ON r.id_registro = cv.fk_condutor
	JOIN condutor AS c
		ON c.id_condutor = cv.fk_condutor
    JOIN veiculo AS v
		ON v.id_veiculo = cv.fk_veiculo;
    
    
select localizacao.*,
	vaga.apelido
FROM
	localizacao JOIN vaga
		ON id_localizacao = fk_localizacao; 
	