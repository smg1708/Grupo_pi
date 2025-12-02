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
	bairro VARCHAR(45) NOT NULL,
    regiao VARCHAR(10) NOT NULL
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
    fk_condutor INT,
		CONSTRAINT fk_condutor
			FOREIGN KEY (fk_condutor)
				REFERENCES cadastro_veiculo(fk_condutor),
	fk_veiculo INT,
		CONSTRAINT fk_veiculo
			FOREIGN KEY (fk_veiculo)
				REFERENCES cadastro_veiculo(fk_veiculo),
	PRIMARY KEY (id_registro, fk_sensor)
);

INSERT INTO seguradora (nome, cnpj, email, telefone, codigo) VALUES
	('Taui Seguros', '52865433233103', 'contato@tauiseguros.com', '11987654321', 'JS36T8'),
	('SeguroPorto', '84765433233103', 'contato@seguroporto.com', '11912345678', 'ME94L3'),
    ('Seguradora Atlas', '12345678000190', 'contato@atlas.com', '11934567810', 'JS36T8'),
	('ProtegeMax Seguros', '98765432000112', 'suporte@protegmax.com', '21988224501', 'KQ92F7'),
	('Guardian Life Brasil', '45123987000155', 'atendimento@guardianlife.com', '31985413290', 'PL73A9'),
	('ForteMais Seguradora', '33221554000144', 'contato@fortemais.com', '51997410065', 'RX84Z2'),
	('SeguroViva Brasil', '77889441000110', 'suporte@seguroviva.com', '41996007412', 'BM57W4'),
	('Prisma Seguros', '10200330000170', 'info@prismaseguros.com', '61994008874', 'ZL29T6'),
	('NovaProteção Seguradora', '55600441000108', 'contato@novaprotecao.com', '71982345561', 'HT48Q3'),
	('AlphaCare Seguros', '29558123000166', 'suporte@alphacare.com', '85995442033', 'FD60B7'),
	('VitaSeg Premium', '66440220000191', 'atendimento@vitaseg.com', '91988804110', 'MC81R9'),
	('BrasilTotal Seguros', '88321567000133', 'contato@brasiltotal.com', '27997881092', 'WN54X1');
    
INSERT INTO usuario (fk_seguradora, nome, cpf, email, senha) VALUES
	(1, 'Maria', '11111111111', 'maria.menezes@gmail.com', '123456'),
	(2, 'Lucas', '22222222222', 'lucas.lopes@gmail.com', '098765'),
	(1, 'Aline', '33333333333', 'aline.alvarenga@gmail.com', '135791'),
	(2, 'Gabriel', '44444444444', 'gabriel.gomes@gmail.com', '864286'),
    (1, 'Marcos Andrade', '12345678910', 'marcos.andrade@atlas.com', 'A9fkT73LpQ'),
	(1, 'Juliana Barbosa', '32165498700', 'juliana.barbosa@atlas.com', 'pQ81LsZ0mn'),
	(2, 'Ricardo Souza', '14725836911', 'ricardo.souza@protegmax.com', 'X7mPa94Qte'),
	(2, 'Paula Mendes', '96385274122', 'paula.mendes@protegmax.com', 'Kq92LmT4sa'),
	(3, 'Fernanda Costa', '15975348633', 'fernanda.costa@guardianlife.com', 'Zt44HbP9qL'),
	(3, 'Daniel Ribeiro', '95135786444', 'daniel.ribeiro@guardianlife.com', 'sD83QwP1nx'),
	(4, 'Amanda Pereira', '11122233355', 'amanda.pereira@fortemais.com', 'Lm72Qp9Bfs'),
	(4, 'Thiago Martins', '44455566677', 'thiago.martins@fortemais.com', 'Tr59NsQ4ve'),
	(5, 'Beatriz Silva', '22233344488', 'beatriz.silva@seguroviva.com', 'Hf81LpS7zt'),
	(5, 'Lucas Fernandes', '77788899900', 'lucas.fernandes@seguroviva.com', 'Qw95NtB2hl'),
	(6, 'Carolina Torres', '15948762319', 'carolina.torres@prismaseguros.com', 'Fp60LqA9vr'),
	(6, 'Eduardo Lima', '25836914725', 'eduardo.lima@prismaseguros.com', 'MZ73sD20qf'),
	(7, 'Patrícia Gomes', '74185296336', 'patricia.gomes@novaprotecao.com', 'Bx82NpF4ak'),
	(7, 'João Vitor Santos', '36925814741', 'joao.santos@novaprotecao.com', 'Kc91ZtH7pw'),
	(8, 'Renata Carvalho', '65498732152', 'renata.carvalho@alphacare.com', 'Tg85QmL1vr'),
	(8, 'Gabriel Azevedo', '85274196363', 'gabriel.azevedo@alphacare.com', 'Vh77BnP3lx'),
	(9, 'Larissa Nogueira', '95145675374', 'larissa.nogueira@vitaseg.com', 'Lp93RtA5mw'),
	(9, 'Matheus Rocha', '35715925885', 'matheus.rocha@vitaseg.com', 'Sd60NmG8kw'),
	(10, 'Clara Moreira', '25814736996', 'clara.moreira@brasiltotal.com', 'Gx72WqT1fs'),
	(10, 'Hugo Almeida', '14736925809', 'hugo.almeida@brasiltotal.com', 'Nz88LcP4am');
    
INSERT INTO localizacao (logradouro, cidade, bairro, regiao) VALUES
	('Av. Paulista', 'São Paulo', 'Bela Vista', 'Centro'),
	('Rua Augusta', 'São Paulo', 'Consolação', 'Centro'),
	('Av. Faria Lima', 'São Paulo', 'Itaim Bibi', 'Sul'),
	('Rua dos Três Irmãos', 'São Paulo', 'Vila Madalena', 'Sul'),
	('Rua Cerro Corá', 'São Paulo', 'Vila Romana', 'Oeste'),
	('Av. Interlagos', 'São Paulo', 'Interlagos', 'Sul'),
	('Rua Itinguçu', 'São Paulo', 'Vila Ré', 'Leste'),
	('Rua Voluntários da Pátria', 'São Paulo', 'Santana', 'Norte'),
	('Rua Amador Bueno', 'São Paulo', 'Santo Amaro', 'Sul'),
	('Av. Sapopemba', 'São Paulo', 'Sapopemba', 'Leste'),
	('Rua Maria Cândida', 'São Paulo', 'Vila Guilherme', 'Norte'),
	('Av. Brigadeiro Luís Antônio', 'São Paulo', 'Bela Vista', 'Centro'),
	('Rua Frei Caneca', 'São Paulo', 'Consolação', 'Centro'),
	('Av. Ibirapuera', 'São Paulo', 'Moema', 'Sul'),
	('Rua Harmonia', 'São Paulo', 'Vila Madalena', 'Oeste'),
	('Rua Clélia', 'São Paulo', 'Lapa', 'Oeste'),
	('Av. Washington Luís', 'São Paulo', 'Campo Belo', 'Sul'),
	('Rua Antônio de Barros', 'São Paulo', 'Tatuapé', 'Leste'),
	('Rua Alfredo Pujol', 'São Paulo', 'Santana', 'Norte'),
	('Av. João Dias', 'São Paulo', 'Santo Amaro', 'Sul'),
	('Av. Aricanduva', 'São Paulo', 'Aricanduva', 'Leste'),
	('Rua Conselheiro Moreira de Barros', 'São Paulo', 'Santana', 'Norte'),
	('Av. Rebouças', 'São Paulo', 'Pinheiros', 'Oeste'),
	('Rua Cardoso de Almeida', 'São Paulo', 'Perdizes', 'Oeste'),
	('Av. Eng. George Corbisier', 'São Paulo', 'Jabaquara', 'Sul'),
	('Rua Cantagalo', 'São Paulo', 'Tatuapé', 'Leste'),
	('Rua Dr. Zuquim', 'São Paulo', 'Santana', 'Norte'),
	('Av. Morumbi', 'São Paulo', 'Morumbi', 'Oeste'),
	('Rua Heitor Penteado', 'São Paulo', 'Sumaré', 'Oeste'),
	('Av. Nossa Senhora do Sabará', 'São Paulo', 'Cidade Dutra', 'Sul'),
	('Rua Azevedo Soares', 'São Paulo', 'Vila Gomes Cardim', 'Leste'),
	('Rua Voluntários da Pátria', 'São Paulo', 'Santana', 'Norte'),
	('Av. Pacaembu', 'São Paulo', 'Pacaembu', 'Centro'),
	('Rua Domingos de Morais', 'São Paulo', 'Vila Mariana', 'Sul'),
	('Av. Celso Garcia', 'São Paulo', 'Brás', 'Leste'),
	('Rua Ataliba Leonel', 'São Paulo', 'Santana', 'Norte'),
	('Av. Francisco Matarazzo', 'São Paulo', 'Barra Funda', 'Oeste'),
	('Rua Tito', 'São Paulo', 'Vila Romana', 'Oeste'),
	('Av. dos Bandeirantes', 'São Paulo', 'Brooklin', 'Sul'),
	('Rua Serra de Bragança', 'São Paulo', 'Vila Gomes Cardim', 'Leste');

    
INSERT INTO sensor (estado_sensor) VALUES
('Ativo'),
('Ativo'),
('Ativo'),
('Ativo'),
('Ativo'),
('Ativo'),
('Ativo'),
('Desativo'),
('Ativo'),
('Ativo'),
('Desativo'),
('Ativo'),
('Desativo'),
('Ativo'),
('Ativo'),
('Desativo'),
('Ativo'),
('Desativo'),
('Ativo'),
('Ativo'),
('Desativo'),
('Desativo'),
('Ativo'),
('Ativo'),
('Desativo'),
('Ativo'),
('Ativo'),
('Desativo'),
('Ativo'),
('Ativo'),
('Desativo'),
('Ativo'),
('Desativo'),
('Ativo'),
('Ativo'),
('Desativo'),
('Ativo'),
('Ativo'),
('Desativo'),
('Ativo');


INSERT INTO vaga (apelido, fk_localizacao, fk_sensor) VALUES
('A1', 1, 4),
('A2', 1, 3),
('A3', 1, 7),
('A4', 1, 2),
('A5', 1, 8),
('B1', 2, 4),
('B2', 2, 9),
('B3', 2, 6),
('B4', 2, 1),
('B5', 2, 7),
('C1', 3, 8),
('C2', 3, 3),
('C3', 3, 5),
('C4', 3, 2),
('C5', 3, 1),
('C6', 3, 10),
('D1', 4, 6),
('D2', 4, 1),
('D3', 4, 9),
('D4', 4, 7),
('D5', 4, 2),
('D6', 4, 5),
('E1', 5, 5),
('E2', 5, 3),
('E3', 5, 7),
('E4', 5, 9),
('E5', 5, 2),
('F1', 6, 8),
('F2', 6, 2),
('F3', 6, 4),
('F4', 6, 6),
('G1', 7, 9),
('G2', 7, 4),
('G3', 7, 1),
('H1', 8, 6),
('H2', 8, 10),
('H3', 8, 3),
('I1', 9, 1),
('I2', 9, 7),
('J1', 10, 5),
('J2', 10, 2);

INSERT INTO condutor (genero, dt_nasc) VALUES
('M', '1990-05-12'),
('F', '1985-11-23'),
('M', '2000-02-14'),
('F', '1995-07-30'),
('M', '1988-12-01'),
('M', '1992-03-18'),
('F', '1987-09-25'),
('M', '2001-11-04'),
('F', '1999-06-10'),
('M', '1983-01-29'),
('F', '1996-04-17'),
('M', '1994-08-02'),
('F', '2002-12-22'),
('M', '1989-10-11'),
('F', '1993-03-05'),
('M', '2000-07-18'),
('F', '1997-02-28'),
('M', '1984-09-09'),
('F', '1991-05-14'),
('M', '1998-11-30'),
('F', '1986-08-21'),
('M', '1993-12-15'),
('F', '1990-04-09'),
('M', '1987-07-02'),
('F', '1995-01-19'),
('M', '2001-03-27'),
('F', '1989-06-05'),
('M', '1997-11-11'),
('F', '1984-02-20'),
('M', '1992-09-08'),
('F', '1998-12-30'),
('M', '1985-10-25'),
('F', '2000-05-07'),
('M', '1996-07-13'),
('F', '1988-03-29'),
('M', '1999-01-22'),
('F', '1983-11-17'),
('M', '1994-06-28'),
('F', '2002-08-16'),
('M', '1986-12-03');

INSERT INTO veiculo (ano_veiculo, modelo_veiculo, tipo, seguro) VALUES
(2018, 'Onix', 'Carro', 1),
(2020, 'HB20', 'Carro', 0),
(2017, 'Honda Biz', 'Moto', 1),
(2019, 'Scania', 'Caminhão', 1),
(2012, 'Avelloz', 'Moto', 0),
(2021, 'Corolla', 'Carro', 1),
(2015, 'Civic', 'Carro', 0),
(2019, 'Yamaha Factor', 'Moto', 1),
(2014, 'Ford Cargo', 'Caminhão', 0),
(2022, 'Tracker', 'Carro', 1),
(2016, 'Kwid', 'Carro', 0),
(2018, 'CG 160', 'Moto', 1),
(2013, 'Volkswagen Delivery', 'Caminhão', 1),
(2020, 'Creta', 'Carro', 1),
(2011, 'Fox', 'Carro', 0),
(2017, 'Titan 150', 'Moto', 0),
(2023, 'S10', 'Caminhão', 1),
(2014, 'Gol', 'Carro', 1),
(2018, 'Honda PCX', 'Moto', 1),
(2012, 'Uno', 'Carro', 0),
(2019, 'Renegade', 'Carro', 1),
(2015, 'Palio', 'Carro', 0),
(2017, 'Fazer 250', 'Moto', 1),
(2016, 'Volvo FH', 'Caminhão', 1),
(2010, 'Celta', 'Carro', 0),
(2021, 'Hilux', 'Caminhão', 1),
(2013, 'Sandero', 'Carro', 0),
(2018, 'Biz 125', 'Moto', 1),
(2014, 'Mercedes Actros', 'Caminhão', 1),
(2019, 'Argo', 'Carro', 1),
(2012, 'Classic', 'Carro', 0),
(2017, 'NXR Bros', 'Moto', 1),
(2015, 'Iveco Daily', 'Caminhão', 0),
(2022, 'Compass', 'Carro', 1),
(2011, 'Punto', 'Carro', 0),
(2016, 'Hornet 600', 'Moto', 1),
(2013, 'MAN TGX', 'Caminhão', 1),
(2020, 'Kicks', 'Carro', 1),
(2014, 'Fiesta', 'Carro', 0),
(2018, 'XRE 300', 'Moto', 1);
    
INSERT INTO cadastro_veiculo (fk_condutor, fk_veiculo, dt_cadastro) VALUES
(1, 5, '2025-11-01'),
(2, 4, '2025-10-31'),
(3, 3, '2025-10-26'),
(4, 2, '2025-11-09'),
(5, 1, '2025-11-03'),
(6, 6, '2025-11-05'),
(7, 7, '2025-11-02'),
(8, 8, '2025-11-10'),
(9, 9, '2025-10-29'),
(10, 10, '2025-11-08'),
(11, 11, '2025-10-27'),
(12, 12, '2025-11-06'),
(13, 13, '2025-11-11'),
(14, 14, '2025-10-30'),
(15, 15, '2025-11-04'),
(16, 3, '2025-10-22'),
(17, 7, '2025-11-12'),
(18, 1, '2025-10-21'),
(19, 4, '2025-11-07'),
(20, 9, '2025-10-25'),
(21, 16, '2025-11-13'),
(22, 17, '2025-11-14'),
(23, 18, '2025-11-15'),
(24, 19, '2025-11-16'),
(25, 20, '2025-11-17'),
(26, 5, '2025-11-18'),
(27, 6, '2025-11-19'),
(28, 7, '2025-11-20'),
(29, 8, '2025-11-21'),
(30, 9, '2025-11-22'),
(31, 10, '2025-11-23'),
(32, 11, '2025-11-24'),
(33, 12, '2025-11-25'),
(34, 13, '2025-11-26'),
(35, 14, '2025-11-27'),
(36, 15, '2025-11-28'),
(37, 16, '2025-11-29'),
(38, 17, '2025-11-30'),
(39, 18, '2025-12-01'),
(40, 19, '2025-12-02');
    
INSERT INTO registro (id_registro, fk_sensor, situacao, fk_condutor, fk_veiculo) VALUES
(1, 1, 0, 1, 1),
(2, 2, 1, 2, 2),
(3, 3, 1, 3, 3),
(4, 4, 1, 4, 4),
(5, 5, 0, 5, 5),
(6, 6, 1, 6, 6),
(7, 7, 0, 7, 7),
(8, 8, 1, 8, 8),
(9, 9, 1, 9, 9),
(10, 10, 0, 10, 10),
(11, 3, 1, 11, 11),
(12, 5, 0, 12, 12),
(13, 2, 1, 13, 13),
(14, 8, 1, 14, 14),
(15, 1, 0, 15, 15),
(16, 4, 1, 16, 3),
(17, 7, 0, 17, 7),
(18, 9, 1, 18, 1),
(19, 6, 1, 19, 4),
(20, 2, 0, 20, 9),
(21, 1, 1, 21, 5),
(22, 2, 0, 22, 6),
(23, 3, 1, 23, 7),
(24, 4, 0, 24, 8),
(25, 5, 1, 25, 9),
(26, 6, 0, 26, 10),
(27, 7, 1, 27, 11),
(28, 8, 0, 28, 12),
(29, 9, 1, 29, 13),
(30, 10, 0, 30, 14),
(31, 1, 1, 31, 15),
(32, 2, 0, 32, 16),
(33, 3, 1, 33, 17),
(34, 4, 0, 34, 18),
(35, 5, 1, 35, 19),
(36, 6, 0, 36, 20),
(37, 7, 1, 37, 1),
(38, 8, 0, 38, 2),
(39, 9, 1, 39, 3),
(40, 10, 0, 40, 4);

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
	