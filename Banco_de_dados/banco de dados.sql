create database pi;

use pi;

create table condutor (
	idPessoa int primary key auto_increment,
    nome varchar(80) ,
	cpf char(11) not null,
    dt_nas date,
    email varchar(80) unique not null,
    telefone varchar(20)
);
    
create table seguradoras (
	idSeguradora int primary key auto_increment,
    nome varchar(80),
    cnpj char(14) unique not null,
    telefone varchar(20) not null
);

create table sensor (
	idSensor int primary key auto_increment,
    dt_atual datetime,
    situacao tinyint
);
    
create table regioes (
	logradouro varchar(80),
    cep char(8) not null
);