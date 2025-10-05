create database pi;

use pi;

create table usuario (
	idUsuario int primary key auto_increment,
    genero char(1) not null,
    constraint cnkgenero
		check(genero in ('M', 'F')),
    dt_nasc date not null,
    modelo_carro varchar(45) not null,
    ano_carro year not null
);
    
create table seguradora (
	idSeguradora int primary key auto_increment,
    nome varchar(80),
    senha char(8) not null,
    cnpj char(14) unique not null,
    email varchar(80) unique not null,
    telefone varchar(20) not null
);

create table localizacao (
	idLocalizacao int primary key auto_increment,
	logradouro varchar(80) not null,
    cidade char(2) not null,
    bairro varchar(45) not null
);

create table vaga (
	idVaga int primary key auto_increment,
    nome varchar(100) not null,
    fkLocal int,
    constraint fklocal
		foreign key (fklocal)
        references localizacao(idLocalizacao)
);

create table sensor (
	idSensor int primary key auto_increment,
    estado_sensor varchar(20),
    fkVaga int,
    constraint fkVaga
		foreign key (fkVaga)
        references vaga(idVaga)
);

create table registro (
	idRegistro int primary key auto_increment,
    registro_entrada datetime,
    registro_saida datetime,
    situacao tinyint,
    fkSensor int,
	constraint fkSensor
        foreign key (fkSensor)
        references sensor(idSensor),
    fkUsuario int,
	constraint fkUsuario
        foreign key (fkUsuario)
        references usuario(idUsuario)
);

insert into usuario (genero, dt_nasc, modelo_carro, ano_carro) values
	('M', '1990-05-12', 'Gol', 2015),
	('F', '1985-11-23', 'Onix', 2018),
	('M', '2000-02-14', 'HB20', 2020),
	('F', '1995-07-30', 'Fiesta', 2017),
	('M', '1988-12-01', 'Civic', 2019);

INSERT INTO seguradora (nome, senha, cnpj, email, telefone) VALUES
	('Taui Seguros', '12345678', '52865433233103', 'contato@tauiseguros.com', '11987654321'),
	('SeguroPorto', '87654321', '84765433233103', 'contato@seguroporto.com', '11912345678');
    
INSERT INTO localizacao (logradouro, cidade, bairro) VALUES
	('Av. Paulista', 'SP', 'Bela Vista'),
	('Rua Augusta', 'SP', 'Consolação'),
	('Av. Faria Lima', 'SP', 'Itaim Bibi'),
	('Rua dos Três Irmãos', 'SP', 'Vila Madalena');
    
INSERT INTO vaga (nome, fkLocal) VALUES
	('1', 1),
	('2', 1),
	('3', 2),
	('4', 3),
	('5', 3),
	('6', 4);

INSERT INTO sensor (estado_sensor, fkVaga) VALUES
	('livre', 1),
	('ocupado', 2),
	('livre', 3),
	('ocupado', 4),
	('livre', 5),
	('livre', 6);

show tables;