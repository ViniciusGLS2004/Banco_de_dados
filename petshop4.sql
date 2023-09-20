create database petshop4;
use petshop4;

create table cliente(
cli_id int primary key auto_increment,
cli_nome varchar(100) not null,
cli_tell int not null,
cli_endereco varchar(100) not null
);

create view vw_viewcliente as
select cli_id, cli_nome, cli_tell, cli_endereco
from cliente;


create table animal(
ani_id int primary key auto_increment,
ani_tipo varchar(100) not null,
ani_nome varchar(100) not null,
ani_idade int not null,
ani_sexo varchar(100) not null,
ani_raca varchar(100) not null,
ani_servico varchar(100) not null,
ani_fk_cliente int not null,
foreign key (ani_fk_cliente) references cliente (cli_id)
);

create view vw_animal as
select ani_id, ani_tipo, ani_nome, ani_idade, ani_sexo, ani_raca, ani_servico, ani_fk_cliente
from animal;

drop view vw_animal;

create table Vacina( -- relação com o animal e a data apicada
vac_id int primary key auto_increment,
vac_nome varchar(100) not null,
vac_tipo varchar(100) not null,
vac_data date not null
);

create view vw_vacina as
select vac_id, vac_nome, vac_tipo, vac_data
from Vacina;


create table odm_servico ( -- mesma estrutura de venda e iten venda, 
ser_id int primary key auto_increment,
ser_data date not null,
ser_estado varchar(100) not null,
ser_fk_prod int not null,
ser_fk_animal int not null,
foreign key (ser_fk_prod) references produto_servico (prod_id),
foreign key (ser_fk_animal) references animal (ani_id)
);

ALTER TABLE odm_servico
DROP COLUMN id_animal;

create view vw_odmservico as
select ser_id, ser_data, ser_estado, ser_fk_prod, ser_fk_animal
from odm_servico;


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

create view vw_prodservico as
select prod_id, prod_nome, prod_data, prod_codbarras, custo
from produto_servico;


create table itens_vendidos(
ven_id int primary key auto_increment,
ven_nome varchar(100) not null,
ven_data date not null,
ven_quantidade int not null,
ven_fk_animal int not null,
ven_fk_prod int not null,
foreign key (ven_fk_animal) references animal (ani_id),
foreign key (ven_fk_prod) references produto_servico (prod_id)
);

create view vw_itensvendidos as
select ven_id, ven_nome, ven_data, ven_quantidade, ven_fk_animal, ven_fk_prod
from itens_vendidos;

create table vacinas_aplicadas( -- data das vacinas aplicadas
app_id int primary key auto_increment,
app_fk_animal int not null,
app_data date not null,
app_fk_vacina int not null,
foreign key (app_fk_animal) references animal (ani_id),
foreign key (app_fk_vacina) references Vacina (vac_id)
);

create view vw_vacinasAplicadas as
select app_id, app_fk_animal, app_data, app_fk_vacina
from vacinas_aplicadas;

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
est_estoque float not null,
fk_prodserv int not null
);

create table lucro (
luc_id int primary key auto_increment,
luc_lucro float not null,
fk_produto_serv int not null
);


create table agendamento (
agen_id int primary key auto_increment,
agen_cod_pet varchar(100) not null,
agen_nome_pet varchar(100) not null,
agen_servico varchar(100) not null,
agen_data timestamp default current_timestamp
);

-- criar um trriger insert de animal para agendamento, e depopis criar um view de agendamento dessa semana

create trigger tgr_Animal_insert_Agendamento after insert
on animal
for each row
insert into agendamento (agen_cod_pet, agen_nome_pet, agen_servico)
value(new.ani_id, new.ani_nome, new.ani_servico);

DROP TRIGGER tgr_Animal_insert_Agendamento;



create view vw_agendamento as
select agen_id, agen_cod_pet, agen_nome_pet, agen_servico, agen_data
from agendamento;

select*from vw_agendamento;

create table ranking (
rank_id int primary key auto_increment,
rank_cod_ani int not null,
rank_nome_prod varchar(100) not null,
rank_qtd_prod int not null,
rank_total float not null
);

alter table ranking drop column rank_total;

create trigger tgr_ItensVendidos_insert_Ranking after insert
on itens_vendidos
for each row
insert into ranking (rank_cod_ani, rank_nome_prod, rank_qtd_prod)
value(new.ven_fk_animal, new.ven_nome, new.ven_quantidade);

create view vw_ranking as
select rank_id, rank_cod_ani, rank_nome_prod, rank_qtd_prod
from ranking
order by rank_qtd_prod desc;

select rank_nome_prod, rank_qtd_prod from vw_ranking;

create table animal_historico (
hist_id int primary key auto_increment,
hist_cod_ani int not null,
hist_data date not null,
hist_cod_servico int not null,
hist_vac_aplicada int
);


ALTER TABLE animal_historico
DROP COLUMN hist_ordem_servico;

create trigger tgr_Insert_Historico after insert on odm_servico for each row
    insert into animal_historico (hist_cod_ani, hist_data, hist_cod_servico, hist_vac_aplicada)
    values (new.ser_fk_animal, new.ser_data, new.ser_fk_prod, null);

-- não consegui juntar os dois trigger em uma tabela só, ficava dando erro por causa do valor, se eu inseria dados dizia que não tinha o dado da outra tabela e vise e versa
create trigger tgr_Insert_Historico_Vacinas after insert on vacinas_aplicadas for each row
    insert into animal_historico (hist_vac_aplicada)
    values (new.app_fk_vacina);

drop trigger tgr_Insert_Historico;
drop trigger tgr_Insert_Historico_Vacinas;

create view vw_AnimalHistorico as
select hist_id, hist_cod_ani, hist_data, hist_cod_servico, hist_vac_aplicada
from animal_historico;

select * from animal_historico;

SET SQL_SAFE_UPDATES = 0;


-- insert cliente

insert into cliente  (cli_nome, cli_tell, cli_endereco)
values ('Bia', 759999, 'Rua A'),
	   ('ruan', 666666, 'Rua B'),
	   ('caio', 333333, 'Rua C');

delete from cliente;

select * from vw_viewcliente;

-- insert animal 

insert into animal (ani_tipo, ani_nome, ani_idade, ani_sexo, ani_raca, ani_servico, ani_fk_cliente)
value ('gato', 'laika', 7, 'feminino', 'gato', 'banho', 1),
('cachorro', 'fiz', 2, 'masculino', 'pequeno', 'tosa', 2),
('gato', 'luke', 5, 'feminino', 'grande', 'exame', 3);

delete from animal;

select * from vw_animal;

-- adcionar dados no produto servico, itens vendidos 

-- inser produto_servico

insert into  produto_servico (prod_nome, prod_data, prod_codbarras, custo)
value ('ração', '2023-09-18', 1111111, 50),
('brinquedos', '2023-09-18', 2222222, 10),
('banhos', '2023-09-18', 2222222, 10),
('tosas', '2023-09-18', 2222222, 10),
('vacinas', '2023-09-18', 2222222, 10),
('exames', '2023-09-18', 3333333, 40);

select * from vw_prodservico;

-- insert itens vendidos

insert into itens_vendidos (ven_nome, ven_data, ven_quantidade, ven_fk_animal, ven_fk_prod)
value ('ração', '19-09-19',10, 1, 1),
 ('brinquedo', '19-09-19',20, 2, 2),
 ('vacina', '19-09-19',1, 3, 3);

select * from vw_itensvendidos;

-- insert ordem serviços

insert into odm_servico ( ser_data, ser_estado, ser_fk_prod, ser_fk_animal)
values ('2023-09-18', 'concluido', 3, 1),
 ('2023-09-18', 'em andamento', 4, 2),
 ('2023-09-18', 'atrasado', 5, 3);
 
 select * from vw_odmservico;
 
 -- insert vacinas 
 
insert into Vacina (vac_nome,vac_tipo, vac_data)
values ('vacina', 'carrapato', '2023-09-19'),
 ('vacina', 'verme', '2023-09-19'),
 ('vacina', 'hepatite', '2023-09-19');
 
 select * from vw_vacina;
 
 -- insert vacinas aplicadas

insert into vacinas_aplicadas (app_fk_animal, app_data, app_fk_vacina)
values(1, '2023-09-19', 1),
(2, '2023-09-19', 2),
(3, '2023-09-19', 3);

select * from vw_vacinasAplicadas;



SHOW CREATE TABLE odm_servico;

-- Remover a restrição de chave estrangeira existente
ALTER TABLE odm_servico
DROP FOREIGN KEY ser_fk_animal;

-- Adicionar a nova restrição de chave estrangeira corrigida
ALTER TABLE odm_servico
ADD CONSTRAINT nova_fk_animal
FOREIGN KEY (ser_fk_animal) REFERENCES animal (ani_id);
