create database pi;

use pi;

create table condutor (
	idPessoa int primary key auto_increment,
    nome varchar(80) ,
	cpf char(11) not null,
    email varchar(80) unique not null,
	senha char(8) not null,
    telefone varchar(20),
    dt_nas date
);
    
create table seguradoras (
	idSeguradora int primary key auto_increment,
    nome varchar(80),
    cnpj char(14) unique not null,
    telefone varchar(20) not null,
    senha char(8) not null
);

create table sensor (
	idSensor int primary key auto_increment,
    dt_atual datetime,
    situacao tinyint
);

create table vagas (
	idVagas int primary key auto_increment,
    qtdVagas int
);
    
create table localizacao (
	idLocalizacao int primary key,
	logradouro varchar(80),
    zona varchar(20),
    cep char(9) not null
);
