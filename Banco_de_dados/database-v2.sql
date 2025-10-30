CREATE DATABASE VagasIQ;

USE VagasIQ;
   
CREATE TABLE seguradora (
	id_seguradora INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(80),
	cnpj CHAR(14) UNIQUE NOT NULL,
	email VARCHAR(80) UNIQUE NOT NULL,
	telefone VARCHAR(20) NOT NULL,
    codigo CHAR(6) NOT NULL
);

CREATE TABLE usuario (
	id_usuario INT AUTO_INCREMENT,
    fk_seguradora INT,
    CONSTRAINT fk_seguradora
		FOREIGN KEY (fk_seguradora)
		REFERENCES seguradora(id_seguradora),
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(45) NOT NULL,
    email VARCHAR(80) NOT NULL,
    senha VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_usuario, fk_seguradora)
);

CREATE TABLE localizacao (
	id_localizacao INT PRIMARY KEY AUTO_INCREMENT,
	logradouro VARCHAR(45) NOT NULL,
	cidade VARCHAR(45) NOT NULL,
	bairro VARCHAR(45) NOT NULL,
    acidentes INT
);

CREATE TABLE sensor (
	id_sensor INT PRIMARY KEY AUTO_INCREMENT,
	estado_sensor VARCHAR(20)
);

CREATE TABLE vaga (
	id_vaga INT PRIMARY KEY AUTO_INCREMENT,
	apelido VARCHAR(45) NOT NULL,
	fk_local INT,
	CONSTRAINT fk_local 
		FOREIGN KEY (fk_local)
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
	dt_nasc DATE NOT NULL,
    ano_veiculo YEAR NOT NULL,
    modelo_veiculo VARCHAR(45) NOT NULL,
	tipo VARCHAR(45),
		CONSTRAINT chk_tipo
        CHECK (tipo IN('Carro', 'Moto', 'Caminhão')),
	seguro TINYINT
);

CREATE TABLE registro (
	id_registro INT PRIMARY KEY AUTO_INCREMENT,
    fk_sensor INT,
	CONSTRAINT fk_sensor_registro
		FOREIGN KEY (fk_sensor)
		REFERENCES sensor(id_sensor),
	fk_condutor INT,
    CONSTRAINT fk_condutor
		FOREIGN KEY (fk_condutor)
		REFERENCES condutor(id_condutor),
    situacao TINYINT,
	dt_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO seguradora (nome, cnpj, email, telefone, codigo) VALUES
	('Taui Seguros', '52865433233103', 'contato@tauiseguros.com', '11987654321', 'JS36T8'),
	('SeguroPorto', '84765433233103', 'contato@seguroporto.com', '11912345678', 'ME94L3');
    
INSERT INTO usuario (fk_seguradora, nome, sobrenome, email, senha) VALUES
	(1, 'Maria', 'Menezes', 'maria.menezes@gmail.com', '123456'),
	(2, 'Lucas', 'Lopes', 'lucas.lopes@gmail.com', '098765'),
	(1, 'Aline', 'Alvarenga', 'aline.alvarenga@gmail.com', '135791'),
	(2, 'Gabriel', 'Gomes', 'gabriel.gomes@gmail.com', '864286');
    
INSERT INTO localizacao (logradouro, cidade, bairro, acidentes) VALUES
	('Av. Paulista', 'São Paulo', 'Bela Vista', 2),
	('Rua Augusta', 'São Paulo', 'Consolação', 5),
	('Av. Faria Lima', 'São Paulo', 'Itaim Bibi', 0),
	('Rua dos Três Irmãos', 'São Paulo', 'Vila Madalena', 1);
    
INSERT INTO sensor (estado_sensor) VALUES
	('Ativo'),
	('Ativo'),
	('Ativo'),
	('Ativo'),
	('Ativo'),
	('Ativo');

INSERT INTO vaga (apelido, fk_local, fk_sensor) VALUES
	('A1', 1, 4),
	('A2', 1, 3),
	('B3', 2, 6),
	('C4', 3, 2),
	('C5', 3, 1),
	('D6', 4, 5);

INSERT INTO condutor (genero, dt_nasc, ano_veiculo, modelo_veiculo, tipo, seguro) VALUES
	('M', '1990-05-12', 2018, 'Onix', 'Carro', 1),
	('F', '1985-11-23', 2020, 'HB20', 'Carro', 0),
	('M', '2000-02-14', 2017, 'Honda Biz', 'Moto', 1),
	('F', '1995-07-30', 2019, 'Scania', 'Caminhão', 1),
	('M', '1988-12-01', 2012, 'Avelloz', 'Moto', 0);
    
INSERT INTO registro (fk_sensor, fk_condutor, situacao) VALUES
	(1, NULL, 0), 
	(2, 4, 1), 
	(3, 5, 1), 
	(4, 3, 1), 
	(5, NULL, 0);

SELECT * FROM condutor;
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
	ON localizacao.id_localizacao = vaga.fk_local
    JOIN sensor 
    ON sensor.id_sensor = vaga.fk_sensor
    JOIN registro 
    ON sensor.id_sensor = registro.fk_sensor
WHERE id_localizacao = 1 AND estado_sensor = 'Ativo';


-- Relação entre o condutor e o seu veículo
SELECT condutor.genero AS Gênero_Condutor,
    condutor.dt_nasc AS Data_Nascimento_Condutor,
    condutor.ano_veiculo AS Ano_Veículo,
    condutor.modelo_veiculo AS Modelo_Veículo,
    condutor.tipo AS Tipo_Veículo,
    CASE
		WHEN condutor.seguro = '1' THEN 'Tem seguro'
		ELSE 'Não tem'
    END AS 'Seguro'
FROM condutor JOIN registro
	ON condutor.id_condutor = registro.fk_condutor;
    

-- Todas as vagas de uma determinada rua
SELECT v.apelido AS vaga, 
	logradouro
FROM vaga AS v JOIN localizacao AS l
    ON v.fk_local = l.id_localizacao 
    JOIN sensor AS s
    ON s.id_sensor = v.fk_sensor
    JOIN registro AS r
    ON s.id_sensor = r.fk_sensor
WHERE fk_local = 1;


-- Relação do condutor e as demais tabelas
SELECT c.genero AS Genero,
	c.dt_nasc AS Data_Nascimento,
	c.modelo_veiculo AS Veiculo,
	c.ano_veiculo AS Ano,
	c.tipo AS Tipo,
	r.dt_registro AS Data,
	s.estado_sensor AS Estado,
	v.apelido AS Vaga,
	l.logradouro AS Localizacao
FROM registro AS r
JOIN condutor AS c
	ON r.fk_condutor = c.id_condutor
JOIN sensor AS s
	ON r.fk_sensor = s.id_sensor
JOIN vaga AS v
	ON v.fk_sensor = s.id_sensor
JOIN localizacao AS l
	ON v.fk_local = l.id_localizacao;
    
    
-- Relação do condutor e o veículo e registro com um tipo de veículo específico
SELECT c.genero AS 'Gênero',
	c.ano_veiculo AS 'Ano do veículo',
    c.modelo_veiculo AS 'Modelo do veículo',
    c.tipo AS 'Tipo de veículo',
    r.situacao AS 'Situacao',
    r.dt_registro AS 'Data do registro'
    FROM condutor AS c JOIN registro AS r
    ON c.id_condutor = r.fk_condutor 
    WHERE c.tipo = 'moto';


-- Relação entre o genêro e os registros
SELECT CASE 
	WHEN c.genero = 'M' THEN 'Homem'
	ELSE 'Mulher'
	END AS 'Gênero',
	r.dt_registro AS 'Data do Registro'
	FROM condutor AS c JOIN registro AS r
	ON r.fk_condutor = c.id_condutor;
