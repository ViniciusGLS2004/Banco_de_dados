create schema estaciona_aluguel;
use estaciona_aluguel;    
                                                                                                                                                                                                                                                                               
create table cliente (                                                                                                                                                                                                                                                                                                            
cli_id int primary key auto_increment,
cli_nome varchar(100) not null,
cli_endereco varchar(100) not null,
cli_tell int not null
);

create table veiculo( -- chave estrangeira para cliente
vei_id int primary key auto_increment,
vei_tipo varchar(100) not null,
vei_marca varchar(100) not null,
vei_modelo varchar(100) not null,
vei_placa int not null,
vei_hora_entrada time not null,
vei_hora_saida time not null,
vei_cod_cliente int not null,
vei_espaco int not null,
fk_espaco_id int not null,
foreign key (fk_espaco_id) references espaco_disponivel (espac_id),
foreign key (vei_cod_cliente) references cliente (cli_id)
);

create table espaco_disponivel( 
espac_id int primary key auto_increment,
espac_disponivel int not null
);

create table preco ( 
preco_id int primary key auto_increment,
preco_descricao varchar(100) not null, -- descrição do veiculo ex carro moto
preco_valor decimal(10, 2) not null
);

create table  forma_pagamento ( -- chave estrangeira para cliente e preco
pag_id int primary key auto_increment,
pag_nome varchar(100) not null,
pag_cod_cliente int not null,
pag_cod_preco int not null,
foreign key (pag_cod_cliente) references cliente (cli_id),
foreign key (pag_cod_preco) references preco (preco_id)
); 

create table funcionario (
func_id int primary key auto_increment,
func_nome varchar(100) not null,
func_funcao varchar(100) not null
);

create table aluguel_servico (-- chave estrangeira para funcionario
servi_id int primary key auto_increment,
servi_nome varchar(100) not null,
servi_cod_func int not null,
foreign key aluguel_servico (servi_cod_func) references funcionario (func_id)
);

create table aluguel_historico ( 
hist_id int primary key auto_increment,
hist_cod_veiculo int not null,
hist_nome_veiculo varchar(100) not null,
hist_data timestamp default current_timestamp
);

create table aluguel_agendamento ( 
agen_id int primary key auto_increment,
agen_cod_veiculo int not null,
agen_hora_entrada time not null,
agen_hora_saida time not null,
agen_data timestamp default current_timestamp
);

create table avaliacao ( -- chave estrangeira para cliente
  avaliacao_id int primary key auto_increment,
  avaliacao_cod_cliente int not null, 
  avaliacao_classificacao int not null, -- Classificação de 1 a 5
  avaliacao_comentario text,
  avaliacao_data timestamp default current_timestamp,
  foreign key avaliacao (avaliacao_cod_cliente) references cliente (cli_id)
);

create table avaliacao_historico (
  historico_id int primary key auto_increment,
  historico_cod_avaliacao int not null,  -- A chave estrangeira para a avaliação original
  data_insercao timestamp default current_timestamp
);

-- views criadas

create view view_cliente as
select cli_id, cli_nome, cli_endereco
from cliente;

create view view_veiculo as
select vei_id, vei_tipo, vei_marca, vei_modelo, vei_placa, vei_data_entrada vei_data_saida, vei_cod_cliente
from veiculo;

create view view_preco as
select preco_id, preco_descricao, preco_valor
from preco;

create view funcionario as
select func_id, func_nome, func_funcao
from funcionario;

-- triggers criados

create trigger tgr_Veiculo_insert_EspacoDisponivel after insert
on veiculo
for each row
update espaco_disponivel set espac_disponivel = espac_disponivel - new.vei_espaco
where espac_id = new.fk_espaco_id;

create trigger tgr_Veiculo_Insert_Historico after insert 
on veiculo 
for each row
insert into aluguel_historico (hist_cod_veiculo, hist_nome_veiculo )
values (new.vei_id, new.vei_nome);

create trigger tgr_Veiculo_Insert_Aluguel_Agendamento after insert
on veiculo
for each row
insert into aluguel_agendamento (agen_cod_veiculo, agen_hora_entrada, agen_hora_saida)
values (new.vei_id, new.vei_hora_entrada, new.vei_hora_saida );

create trigger tgr_Avaliacao_Insert_AvaliacaoHistorico after insert 
on avaliacao 
for each row
insert into avaliacao_historico (historico_cod_avaliacao, data_insercao)
values (new.avaliacao_id, new.avaliacao_data);