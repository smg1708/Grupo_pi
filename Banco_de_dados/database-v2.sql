CREATE DATABASE vagasIQ;
USE vagasIQ;

CREATE TABLE condutor(
id_condutor INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
sobrenome VARCHAR(45),
genero CHAR(1),
dt_nasc DATE,
CONSTRAINT chkGenero CHECK(genero IN('M', 'F', 'N'))
);

CREATE TABLE veiculo(
id_veiculo INT,
fk_condutor INT,
ano YEAR,
modelo VARCHAR(45),
tipo VARCHAR(45),
seguro TINYINT,
PRIMARY KEY (id_veiculo, fk_condutor),
CONSTRAINT chkSeguro CHECK(seguro IN(0, 1)),
FOREIGN KEY (fk_condutor)
	REFERENCES condutor(id_condutor)
);

CREATE TABLE localizacao(
id_localizacao INT PRIMARY KEY AUTO_INCREMENT,
logradouro VARCHAR(45),
cidade VARCHAR(45),
bairro VARCHAR(45)
);

CREATE TABLE vagas(
id_vaga INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100),
fk_local INT,
FOREIGN KEY (fk_local)
	REFERENCES localizacao(id_localizacao)
);

CREATE TABLE sensor(
id_sensor INT PRIMARY KEY AUTO_INCREMENT,
estado_sensor VARCHAR(20),
fk_vaga INT,
FOREIGN KEY (fk_vaga)
	REFERENCES vagas(id_vaga)
);

CREATE TABLE registro(
id_registro INT,
situacao TINYINT,
dt_registro DATETIME,
fk_sensor INT,
fk_condutor INT,
FOREIGN KEY (fk_sensor)
	REFERENCES sensor(id_sensor),
FOREIGN KEY (fk_condutor)
	REFERENCES condutor(id_condutor)
);

CREATE TABLE seguradoras(
id_seguradora INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(80),
senha VARCHAR(20),
cnpj CHAR(14),
email VARCHAR(80),
telefone VARCHAR(20)
);