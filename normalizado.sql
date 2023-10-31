create database NORMALIZADO;
use normalizado;

CREATE TABLE usuario (
    user_codigo INT PRIMARY KEY AUTO_INCREMENT,
    user_nome VARCHAR(100),
    user_senha VARCHAR(100),
    user_nivel INT
);

CREATE TABLE produtos (
    prod_codigo INT PRIMARY KEY AUTO_INCREMENT,
    prod_nome VARCHAR(100),
    prod_preco FLOAT,
    prod_unidade_media INT,
    prod_codigo_barra VARCHAR(13),
    prod_departamento INT,
    prod_estoque DECIMAL(15 , 4 )
);

insert into unidade_media(uni_nome) value ('KG'), ('LT'),('UN'), ('NT');

insert into departamento(dep_nome) value ('Alimentos'), ('Limpeza');

insert into produtos(prod_codigo, prod_nome, prod_preco, prod_unidade_media, prod_codigo_barra, prod_departamento, prod_estoque) 
value(2, 'Sabão em pó', 7.00, 2,7132780234, 2, 24);

select produtos.*, departamento.dep_nome
from produtos
inner join departamento on produtos.prod_departamento = departamento.dep_codigo;

select * from unidade_media;
select * from departamento;

update produtos
set prod_departamento = 1
where prod_codigo = 1;


alter table produtos -- nome da tabela da chave estrangeira
add constraint FK_UNIDADE_MEDIA -- nome a um objeto, não se refençia a nada
	foreign key (prod_unidade_media) -- chave estrangeira
    references unidade_media (uni_codigo) -- referençia a tabela e a chave primaria
    on delete no action
    on update no action;

alter table produtos -- nome da tabela da chave estrangeira
add constraint FK_DEPARTAMENTO -- nome a um objeto, não se refençia a nada
	foreign key (prod_departamento) -- chave estrangeira
    references departamento (dep_codigo) -- referençia a tabela e a chave primaria
    on delete no action
    on update no action;


create table unidade_media (
	uni_codigo int primary key auto_increment,
    uni_nome varchar(100)
);



create table departamento (
	dep_codigo int primary key auto_increment,
    dep_nome varchar(100)
);


create table itens_venda (
	iven_codigo int primary key auto_increment,
    iven_valor decimal(15,4),
    iven_desconto decimal(15,4),
    iven_total decimal(15,4),
    iven_produto int,
    ven_fk_venda int
);

alter table itens_venda -- nome da tabela da chave estrangeira
add constraint FK_PRODUTOS  -- nome a um objeto, se refençia a chave estrangeira
foreign key (iven_produto) -- chave estrangeira
references produtos (prod_codigo) -- referençia a tabela e a chave primaria
on delete no action
on update no action;

alter table itens_venda
add constraint FK_VENDAS
foreign key (ven_fk_venda)
references vendas (ven_codigo)
on delete no action
on update no action;

create table cliente (
	cli_codigo int primary key auto_increment,
    cli_nome varchar(100),
    cli_endereco varchar(100),
    cli_cpf decimal(10,0),
    cli_tel decimal(10,0),
    cli_bairro varchar(100),
    cli_num_casa varchar(10),
    cli_fk_cidade_codigo int
);

insert into cliente(cli_nome, cli_endereco, cliente.cli_fk_cidade_codigo) value('sino', 'rua a',3);

select cliente.*, cidade.cid_nome
from cliente
inner join cidade on cliente.cli_fk_cidade_codigo = cidade.cid_codigo;

select * from cidade;

alter table cliente
add constraint FK_CIDADE 
foreign key (cli_fk_cidade_codigo)
references cidade (cid_codigo)
on delete no action
on update no action;

create table vendas (
	ven_codigo int primary key auto_increment,
    ven_data date,
    ven_total decimal(15,4),
    ven_cliente int,
    ven_status boolean
);

insert into vendas(ven_codigo, ven_data, ven_total) value (3, 2023-08-22, 6.0);
select * from  vendas;

update vendas
set ven_cliente = 1
where ven_codigo = 1;


alter table vendas
add constraint FK_CLIENTE
foreign key (ven_cliente)
references cliente (cli_codigo)
on delete no action
on update no action;

create table cidade (
	cid_codigo int primary key auto_increment,
	cid_nome varchar(100),
	cid_fk_estado int
);

insert into cidade(cid_codigo, cid_nome,cid_fk_estado) value (4, 'camaçari',2);

select cidade.*, estados.est_nome
from cidade
inner join estados on cidade.cid_fk_estado = estados.est_codigo;

alter table cidade
add constraint FK_ESTADOS
foreign key (cid_fk_estado)
references estados (est_codigo)
on delete no action
on update no action;

create table estados (
	est_codigo int primary key auto_increment,
    est_nome varchar(100)
);

insert into estados(est_codigo, est_nome) value (2, 'São paulo');
select * from estados;


create table recebimento (
	rec_codigo int primary key auto_increment,
    rec_data date,
    rc_valor decimal(15,4),
    rec_fk_codigo_venda int,
    rec_fk_codigo_formapag int
);

alter table recebimento
add constraint FK_RECEBIMENTO
foreign key (rec_fk_codigo_venda)
references vendas (ven_codigo)
on delete no action
on update no action;

alter table recebimento
add constraint FK_FORMA_PAGAMENTOS
foreign key (rec_fk_codigo_formapag)	
references forma_pagamentos (fpag_codigo)
on delete no action
on update no action;

create table forma_pagamentos (
	fpag_codigo int primary key auto_increment,
    fpag_nome varchar(30)
);
