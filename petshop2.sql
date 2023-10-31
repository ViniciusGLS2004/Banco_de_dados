create database petshop2;
use petshop2;

create table cliente(
cli_id int primary key auto_increment,
cli_nome varchar(100) not null,
cli_tell int not null,
cli_endereco varchar(100) not null
);

create view vw_viewcliente as
select cli_id, cli_nome
from cliente;
select * from vw_viewcliente;

create table animal(
ani_id int primary key auto_increment,
ani_nome varchar(100) not null,
ani_idade int not null,
ani_sexo varchar(100) not null,
ani_raca varchar(100) not null,
ani_banhos int,
ani_fk_cliente int not null,
foreign key (ani_fk_cliente) references cliente (cli_id)
);

create table Vacina( -- relação com o animal e a data apicada
vac_id int primary key auto_increment,
vac_nome varchar(100) not null,
vac_tipo varchar(100) not null,
vac_data date not null
);

create table odm_servico ( -- mesma estrutura de venda e iten venda, 
ser_id int primary key auto_increment,
ser_nome varchar(100) not null,
ser_data date not null,
ser_estado varchar(100) not null,
ser_fk_prod int not null,
ser_fk_cliente int not null,
foreign key (ser_fk_prod) references produto_servico (prod_id),
foreign key (ser_fk_cliente) references cliente (cli_id)
);

create table inten_odm_servico (-- mesma estrutura de venda e iten venda dizer o que ele pogou
iten_id int primary key auto_increment,
iten_nome varchar(100) not null,
iten_data date not null,
iten_quantidade int,
iten_fk_ser int not null,
iten_fk_prod int not null,
iten_fk_cliente int not null,
foreign key (iten_fk_ser) references odm_servico (ser_id),
foreign key (iten_fk_prod) references produto_servico (prod_id),
foreign key (iten_fk_cliente) references cliente (cli_id)
);

create table produto_servico ( -- o que a loja vende
prod_id int primary key auto_increment,
prod_nome varchar(100) not null,
prod_data date not null,
prod_codbarras int,
custo float not null
);
drop table produto_servico;
truncate table produto_servico;

alter table produto_servico add column custo float;

create table itens_vendidos(
ven_id int primary key auto_increment,
ven_nome varchar(100) not null,
ven_data date not null,
ven_quantidade int not null,
ven_fk_cliente int not null,
ven_fk_prod int not null,
foreign key (ven_fk_cliente) references cliente (cli_id),
foreign key (ven_fk_prod) references produto_servico (prod_id)
);

create table vacinas_aplicadas( -- data das vacinas aplicadas
app_id int primary key auto_increment,
app_nome varchar(100) not null,
app_fk_vacina int not null,
foreign key (app_fk_vacina) references Vacina (vac_id)
);

create table forma_pagamento (
pag_id int primary key auto_increment,
pag_nome varchar(100) not null,
pag_valor decimal(10,2) not null
); 

create table funcionario (
fun_id int primary key auto_increment,
fun_nome varchar(100) not null,
fun_funcao varchar(100) not null
);

create table recebimento (
receb_id int primary key auto_increment,
receb_nome varchar(100) not null,
receb_fk_pag int not null,
receb_fk_cli int not null,
foreign key (receb_fk_pag) references forma_pagamento (pag_id),
foreign key (receb_fk_cli) references cliente (cli_id)
);

create table estoque (
est_id int primary key auto_increment,
est_estoqure float not null,
fk_prodserv int not null
);

insert into estoque (fk_prodserv, est_estoqure )
select prod_id,0 from produto_servico;

insert into lucro (fk_produto_serv, luc_ucro )
select prod_id,0 from produto_servico;

select * from produto_servico;

create table lucro (
luc_id int primary key auto_increment,
luc_ucro float not null,
fk_produto_serv int not null
);
-- a) Liste os animais que fizeram serviço no pet.

insert into cliente  (cli_nome, cli_tell, cli_endereco)
values ('luiz', 759111999, 'Rua D');
select * from cliente;



insert into animal (ani_nome, ani_idade, ani_sexo, ani_raca, ani_fk_cliente, ani_banhos)
values ('xix', 5, 'feminino', 'gato', 4, 1);

create view vw_animal as
select ani_nome, ani_idade, ani_sexo, ani_raca, ani_fk_cliente, ani_banhos
from animal;
select * from vw_animal;

delete from animal;
SET SQL_SAFE_UPDATES = 0;

DROP VIEW vw_animal;

-- B) Liste produtos que irão vencer no próximo mês.

insert into vacina (vac_nome, vac_tipo, vac_data)
value ('carrapato', 'agulha', '2023-10-11'); -- se colocar uma data com mes anterior a atual ele não ira printar

select * from vacina; -- para ver todas as vacinas

create view vw_vacina as 
select vac_nome, vac_tipo, vac_data
from vacina
where month(vac_data) = month(curdate() + interval 1 month);
select * from vw_vacina;

DROP VIEW vw_vacina;
-- C) Atualize a quantidade de banhos tomando no cadastro do animal.

insert into animal (ani_nome, ani_idade, ani_sexo, ani_raca, ani_fk_cliente, ani_banhos)
values ('lesgo', 1, 'masculino', 'cachorro', 4, 1);
select * from vw_animal;

update animal
set ani_banhos = 2
where ani_id = 5;

-- D) Totalize quantidade de produtos vendidos no mês.

insert into produto_servico (prod_nome, prod_data)
values ('exame','2023-09-12');
select * from produto_servico;

create view vw_serviprod as 
select prod_nome, prod_data
from produto_servico;
select * from vw_serviprod;

delete from produto_servico
where prod_id = 5;

update produto_servico
set prod_id = 5
where prod_nome = 'exame';

insert into itens_vendidos( ven_nome, ven_data, ven_quantidade, ven_fk_cliente, ven_fk_prod)
values ('ração', '2023-09-10', 20, 4, 2);

create view vw_vendidos as 
select iv.ven_nome, iv.ven_data, iv.ven_quantidade, iv.ven_fk_cliente, iv.ven_fk_prod,
	sum(ven_quantidade) as total_produtos_vendidos
from itens_vendidos
GROUP BY iv.ven_nome, iv.ven_data, iv.ven_quantidade, iv.ven_fk_cliente, iv.ven_fk_prod
HAVING YEAR(iv.ven_data) = 2023 AND MONTH(iv.ven_data) = 9; -- Filtrar por ano e mês
select * from vw_vendidos;

-- E) Totalize quantidade de serviço feito no mês.

insert into odm_servico(ser_nome, ser_data, ser_estado,ser_fk_prod , ser_fk_cliente )
values ('tosa', '2023-09-10','concluido',4, 4);

create view vw_odmservico as 
select ser_nome, ser_data, ser_estado,ser_fk_prod , ser_fk_cliente
from odm_servico;
select * from vw_odmservico;

insert into inten_odm_servico(iten_nome,iten_data,iten_quantidade, iten_fk_ser, iten_fk_prod, iten_fk_cliente)
values ('banho','2023-09-05',1,3,4,4 );

create view vw_itenodmservico as 
select iv.iten_nome, iv.iten_data, iv.iten_quantidade, iv.iten_fk_ser, iv.iten_fk_prod, iv.iten_fk_cliente,
	sum(iten_quantidade) as total_servico_vendidos -- a soma das quantidades vendidas de acordo com o mes
from inten_odm_servico
GROUP BY iv.iten_nome, iv.iten_data, iv.iten_quantidade, iv.iten_fk_ser, iv.iten_fk_prod, iv.iten_fk_cliente
HAVING YEAR(iv.iten_data) = 2023 AND MONTH(iv.iten_data) = 9; -- Filtrar por ano e mês

select * from vw_itenodmservico;


DROP VIEW vw_odmservico;
