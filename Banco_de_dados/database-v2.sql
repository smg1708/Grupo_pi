CREATE DATABASE VagasIQ;

USE VagasIQ;

CREATE TABLE condutor (
	id_condutor INT PRIMARY KEY AUTO_INCREMENT,
	genero CHAR(1) NOT NULL,
	CONSTRAINT cnk_genero 
		CHECK (genero IN ('M', 'F')),
	dt_nasc DATE NOT NULL
);

CREATE TABLE veiculo (
	id_veiculo INT AUTO_INCREMENT,
	fk_condutor INT,
    PRIMARY KEY (id_veiculo, fk_condutor),
	ano YEAR NOT NULL,
	modelo VARCHAR(45) NOT NULL,
	tipo VARCHAR(45),
		CONSTRAINT chk_tipo
        CHECK (tipo IN('Carro', 'Moto', 'Caminhão')),
	seguro TINYINT,
	CONSTRAINT fk_condutor 
		FOREIGN KEY (fk_condutor)
		REFERENCES condutor(id_condutor)
);
    
CREATE TABLE seguradora (
	id_seguradora INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(80),
	senha VARCHAR(20) NOT NULL,
	cnpj CHAR(14) UNIQUE NOT NULL,
	email VARCHAR(80) UNIQUE NOT NULL,
	telefone VARCHAR(20) NOT NULL
);

CREATE TABLE localizacao (
	id_localizacao INT PRIMARY KEY AUTO_INCREMENT,
	logradouro VARCHAR(80) NOT NULL,
	cidade VARCHAR(45) NOT NULL,
	bairro VARCHAR(45) NOT NULL
);

CREATE TABLE vaga (
	id_vaga INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(100) NOT NULL,
	fk_local INT,
	CONSTRAINT fk_local 
		FOREIGN KEY (fk_local)
		REFERENCES localizacao(id_localizacao)
);

CREATE TABLE sensor (
	id_sensor INT PRIMARY KEY AUTO_INCREMENT,
	estado_sensor VARCHAR(20),
	fk_vaga INT,
	CONSTRAINT fk_vaga 
		FOREIGN KEY (fk_vaga)
		REFERENCES vaga(id_vaga)
);

CREATE TABLE registro (
	id_registro INT PRIMARY KEY AUTO_INCREMENT,
	dt_registro DATETIME,
	situacao TINYINT,
	fk_sensor INT,
	CONSTRAINT fk_sensor 
		FOREIGN KEY (fk_sensor)
		REFERENCES sensor(id_sensor),
	fk_usuario INT,
	CONSTRAINT fk_usuario 
		FOREIGN KEY (fk_usuario)
		REFERENCES condutor(id_condutor)
);

INSERT INTO condutor (genero, dt_nasc) VALUES
	('M', '1990-05-12'),
	('F', '1985-11-23'),
	('M', '2000-02-14'),
	('F', '1995-07-30'),
	('M', '1988-12-01');
    
INSERT INTO veiculo (fk_condutor, ano, modelo, tipo, seguro) VALUES
	(2, 2018, 'Onix', 'Carro', 1),
	(3, 2020, 'HB20', 'Carro', 0),
	(4, 2017, 'Honda Biz', 'Moto', 1),
	(5, 2019, 'Scania', 'Caminhão', 1),
	(1, 2012, 'Avelloz', 'Moto', 0); 

INSERT INTO seguradora (nome, senha, cnpj, email, telefone) VALUES
	('Taui Seguros', '12345678', '52865433233103', 'contato@tauiseguros.com', '11987654321'),
	('SeguroPorto', '87654321', '84765433233103', 'contato@seguroporto.com', '11912345678');
    
INSERT INTO localizacao (logradouro, cidade, bairro) VALUES
	('Av. Paulista', 'São Paulo', 'Bela Vista'),
	('Rua Augusta', 'São Paulo', 'Consolação'),
	('Av. Faria Lima', 'São Paulo', 'Itaim Bibi'),
	('Rua dos Três Irmãos', 'São Paulo', 'Vila Madalena');
    
INSERT INTO vaga (nome, fk_local) VALUES
	('A1', 1),
	('A2', 1),
	('B3', 2),
	('C4', 3),
	('C5', 3),
	('D6', 4);

INSERT INTO sensor (estado_sensor, fk_vaga) VALUES
	('Ativo', 1),
	('Ativo', 2),
	('Ativo', 3),
	('Ativo', 4),
	('Ativo', 5),
	('Ativo', 6);
    
INSERT INTO registro (dt_registro, situacao, fk_sensor, fk_usuario) VALUES
	('2025-10-14 08:15:00', 0, 2, 1),
	('2025-10-14 09:00:00', 1, 4, 2),
	('2025-10-14 07:45:00', 0, 1, 3),
	('2025-10-14 11:00:00', 1, 5, 4),
	('2025-10-14 08:40:00', 0, 3, 5),
	('2025-10-14 12:10:00', 1, 6, 1);

SHOW TABLES;

-- Disponibilidade das vagas de determinada localização
SELECT vaga.nome AS Vaga,
	CASE
		WHEN registro.situacao = 1 THEN 'Ocupado'
        ELSE 'Livre'
	END AS 'Situação'
FROM localizacao JOIN vaga ON id_localizacao = fk_local
    JOIN sensor ON id_vaga = fk_vaga
    JOIN registro ON id_sensor = fk_sensor
WHERE id_localizacao = 1 AND estado_sensor = 'Ativo';

-- Relação entre o condutor e o seu veículo
SELECT condutor.genero AS Gênero_Condutor,
    condutor.dt_nasc AS Data_Nascimento_Condutor,
    veiculo.ano AS Ano_Veículo,
    veiculo.modelo AS Modelo_Veículo,
    veiculo.tipo AS Tipo_Veículo,
    CASE
		WHEN veiculo.seguro = '1'
		THEN 'Tem seguro'
		ELSE 'Não tem'
    END AS 'Seguro'
FROM condutor JOIN veiculo
	ON condutor.id_condutor = veiculo.fk_condutor;

-- Todas as vagas de uma determinada rua
SELECT vaga.nome, 
	logradouro, 
    sensor.estado_sensor 
FROM 
	vaga JOIN localizacao
    ON fk_local = id_localizacao 
    JOIN sensor
    ON id_vaga = fk_vaga;