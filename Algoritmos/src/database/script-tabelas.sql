-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql server
*/
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