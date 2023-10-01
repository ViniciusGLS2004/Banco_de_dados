SET SQL_SAFE_UPDATES = 0;
-- criar um banco para um pastelaria mas de uma forma geral que sirva para ouros restaurantes

-- tabela clientes : Nome completo, Nome que gostaria de ser chamado, cpf, data de nascimento, telefone, e-mail, bairro, cidade e estado.
-- tabela pasteis(produto): cada pastel tem um recheio diferente e um tamanho diferente, além de nome e preço.
-- tabela pasteis categoria: diferentes categorias, como os pastéis veganos, vegetarianos e sem lactose. (id e nome)
-- tabela pedidos: Todos os pedidos devem ser registrados e para a pastelaria alem de qual cliente foi e a data.
-- tabela produtos vendidos: cada pedido tenha a lista de produtos vendidos (pastéis, sucos, refrigerantes, etc.).
-- tabela formas de pagamento: as formas de pagamento

create schema restaurante;
use restaurante;

create table cliente(
cli_id int primary key auto_increment,
cli_nome varchar(100) not null,
cli_nome_qgostaria varchar(100),
cli_cpf int not null,
cli_datenasc date not null, -- data de nascimento
cli_tell int,
cli_email varchar(100),
cli_bairro varchar(100),
cli_cidade varchar(100),
cli_estado varchar(100) 
); 

create table produto_categoria(
cat_id int primary key auto_increment,
cat_nome varchar(100) not null
);

create table produto( -- pasteis 
pro_id int primary key auto_increment,
pro_nome varchar(100) not null,
pro_tamanho varchar(100) not null,
pro_sabor varchar(100) not null,
pro_preco decimal (10,1) not null,
pro_cod_categoria int,
foreign key produto(pro_cod_categoria) references produto_categoria (cat_id)
);

create table bebida(
beb_id int primary key auto_increment,
beb_nome varchar(100) not null,
beb_tamanho varchar(100) not null,
beb_sabor varchar(100) not null,
beb_preco float not null
);

create table  forma_pagamento (
pag_id int primary key auto_increment,
pag_nome varchar(100) not null
); 

create table pedidos( -- na hora que tiver um pedido ele deve ir para produtos vendidos
ped_id int primary key auto_increment,
ped_cod_cliente int not null,
ped_cod_produto int not null,
ped_cod_bebida int,
ped_cod_pagamento int not null,
ped_data  timestamp default current_timestamp,
foreign key  (ped_cod_cliente) references cliente (cli_id),
foreign key  (ped_cod_produto) references produto (pro_id),
foreign key  (ped_cod_bebida) references bebida (beb_id),
foreign key  (ped_cod_pagamento) references forma_pagamento (pag_id)
);

show tables like 'pedidos';
drop table if exists pedidos;

create table produtos_vendidos(
ven_id int primary key auto_increment,
ven_cod_pedido int not null,
ven_cod_produto int not null,
foreign key  (ven_cod_pedido) references pedidos (ped_id),
foreign key  (ven_cod_produto) references produto (pro_id)
);

create trigger tgr_Pedidos_Insert_ProdutosVendidos after insert
on pedidos
for each row
insert into produtos_vendidos (ven_cod_pedido, ven_cod_produto)
value (new.ped_id, new.ped_cod_produto);

select * from produtos_vendidos;

-- insert cliente

insert into cliente (cli_nome, cli_nome_qgostaria, cli_cpf, cli_datenasc, cli_tell, cli_email, cli_bairro, cli_cidade, cli_estado)
value ('carlo', '', 999999999, '2000-05-15', 7777777,'','','feira de santana', 'bahia'),
	  ('luiza', '', 888888888, '2000-05-15', 8888888,'','','feira de santana', 'bahia'),
      ('marco', '', 777777777, '2006-09-07', 9999999,'','','feira de santana', 'bahia'),
      ('benta', '', 666666666, '2006-09-08', 1111111,'','','feira de santana', 'bahia');

-- insert categoria do produto

insert into produto_categoria (cat_nome)
value ('vegano'),
 ('vegetariano'),
 ('sem lactose');

-- insert de produto

insert into produto (pro_nome, pro_tamanho, pro_sabor, pro_preco, pro_cod_categoria)
value ('pastel', 'pequeno', 'carne', '1.7',null),
 ('pastel', 'medio', 'carne', '2.7', null ),
 ('pastel', 'grande', 'carne', '3.7', null ),
 ('pastel', 'pequeno', 'frango', '1.7', null ),
 ('pastel', 'medio', 'frango', '2.7', null ),
 ('pastel', 'grande', 'frango', '3.7', null),
 ('pastel', 'pequeno', 'bacon', '1.7', null),
 ('pastel', 'medio', 'bacon', '2.7', null),
 ('pastel', 'grande', 'bacon', '3.7', null),
 ('pastel', 'pequeno', 'camarao', '1.7', null),
 ('pastel', 'medio', 'camarao', '2.7', null),
 ('pastel', 'grande', 'camarao', '3.7', null),
 ('pastel', 'pequeno', 'tofu', '1.7', 1),
 ('pastel', 'medio', 'tofu', '2.7', 1),
 ('pastel', 'grande', 'tofu', '3.7', 1),
 ('pastel', 'pequene', 'queijo', '1.7', 2),
 ('pastel', 'medio', 'queijo', '2.7', 2),
 ('pastel', 'grande', 'queijo', '3.7', 2),
 ('pastel', 'grande', 'cogumelo', '1.7', 3),
 ('pastel', 'grande', 'cogumelo', '2.7', 3),
 ('pastel', 'grande', 'cogumelo', '3.7', 3);
 select * from produto;

-- insert bebidas a venda
insert into bebida (beb_nome, beb_tamanho, beb_sabor, beb_preco)
value ('refrigerante', 'pequeno', 'coca-cola', 0.30),
 ('refrigerante', 'medio', 'coca-cola', 0.40),
 ('refrigerante', 'grande', 'coca-cola', 0.50),
 ('refrigerante', 'pequeno', 'pepsi', 0.30),
 ('refrigerante', 'medio', 'cpepsi', 0.40),
 ('refrigerante', 'grande', 'pepsi', 0.50),
 ('refrigerante', 'pequeno', 'fanta', 0.30),
 ('refrigerante', 'medio', 'fanta', 0.40),
 ('refrigerante', 'grande', 'fanta', 0.50),
 ('suco', 'pequeno', 'manga', 0.30),
 ('suco', 'medio', 'manga', 0.40),
 ('suco', 'grande', 'manga', 0.50),
 ('suco', 'pequeno', 'goiaba', 0.30),
 ('suco', 'medio', 'goiaba', 0.40),
 ('suco', 'grande', 'goiaba', 0.50);

-- insert forma de pagamento

insert into forma_pagamento (pag_nome)
value ('dinheiro fisico'),
	  ('pix'),
      ('cartão');

-- insert de pedidos

insert into pedidos (ped_cod_cliente, ped_cod_produto, ped_cod_bebida, ped_cod_pagamento)
value (1, 13, 3, 1),
 (1, 13, 4, 1),
 (1, 13, null ,1),
 (2, 14, null ,2 ),
 (2, 14, 6, 2 ),
 (2, 14, null , 3 ),
 (2, 14, null , 3 ),
 (2, 14, null , 3 ),
 (3, 3, 1, 2),
 (4, 6, 2, 3);
select * from pedidos;

-- BI do banco de dados
-- 1. Liste os nomes de todos os pastéis veganos vendidos para pessoas com mais de 18 anos.
create view view_pasteisVeganosVendidos as
SELECT c.cli_nome as NomeCliente, p.pro_nome as NomeProduto, p.pro_tamanho as Tamanho, p.pro_sabor as Recheio
from cliente c
inner join pedidos pd on c.cli_id = pd.ped_cod_cliente
inner join produto p on pd.ped_cod_produto = p.pro_id
inner join produto_categoria pc on p.pro_cod_categoria = pc.cat_id
where pc.cat_nome = 'vegano' and (year(CURDATE()) - year(c.cli_datenasc)) > 18;

select * from view_pasteisVeganosVendidos;

drop view view_pasteisVeganosVendidos;

-- 2. Liste os clientes com maior número de pedidos realizados em 1 ano agrupados por mês.
create view view_ClientemaiorPedidos as 
select c.cli_nome as NomeCliente, year (pd.ped_data) as Ano, month (pd.ped_data) as Mes, count(*) as NumerosPedidos
from cliente c
inner join pedidos pd on c.cli_id = pd.ped_cod_cliente
where 
	pd.ped_data >= date_sub(current_date(), interval 1 year) -- -- Filtra apenas pedidos dos últimos 12 meses
group by
	NomeCliente, Mes, Ano
Order by 
	NumerosPedidos desc;

select * from  view_ClientemaiorPedidos;

-- 3. Liste todos os pastéis que possuem bacon e queijo em seu recheio.
create view view_TotalSabores as 
select pro_sabor as NomeSabor, count(*) as NumeroSabores
from produto 
where 
	pro_sabor in ('bacon', 'queijo')
group by
	NomeSabor;
    
select * from  view_TotalSabores;

drop view view_TotalSabores;

-- 4. Mostre o valor de venda total de todos os pastéis cadastrados no sistema.
create view view_VendaTotal as
select pro_nome as NomeProduto, sum(pro_preco) as ValorTotal
from produto
group by NomeProduto;

select * from view_VendaTotal;

-- 5. Liste todos os pedidos onde há pelo menos um pastel e uma bebida.
create view view_PastelComBebida as
select p.ped_cod_cliente as CodCliente, p.ped_id as CodPedido
from pedidos p
where 
(exists (select 1 from produtos_vendidos pv where pv.ven_cod_pedido = p.ped_id and pv.ven_cod_produto in (select pro_id from produto))
and
p.ped_cod_bebida is not null)
group by 
	CodCliente, CodPedido;

select * from view_PastelComBebida;

drop view view_PastelComBebida;
-- 6. Liste quais são os pastéis mais vendidos, incluindo a quantidade de vendas em ordem crescente.
create view view_pasteisVendidos as
SELECT p.pro_nome as NomeProduto, p.pro_sabor as Sabor, count(*) as QtdVendidos
from produtos_vendidos pv
inner join produto p on p.pro_id = pv.ven_cod_produto
group by
	NomeProduto, Sabor
Order by 
	QtdVendidos desc;

select * from view_pasteisVendidos;