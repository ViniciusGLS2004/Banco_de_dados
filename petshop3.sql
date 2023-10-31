create database petshop3;
use petshop3;

create table produto_venda (
prod_id int primary key auto_increment,
prod_nome varchar(100) not null,
prod_qtd int not null,
fk_estoque_id int not null,
foreign key (fk_estoque_id) references estoque (est_id)
);

create table estoque (
est_id int primary key auto_increment,
est_nome varchar(100) not null,
est_estoque float not null
);

insert into produto_venda (prod_nome,prod_qtd, fk_estoque_id)
value ('ração', 30, 1);

insert into estoque (est_nome, est_estoque)
value ('ração',50),
	  ('brinqudos',50), 
	  ('vacinas',50);
	  

delete from produto_venda
where prod_id = 1;

select * from produto_venda;
select * from estoque;

create trigger tgr_ProdutoVenda_insert_BaixarEstoque after insert
on produto_venda
for each row
update estoque set est_estoque = est_estoque - new.prod_qtd
where est_id = new.fk_estoque_id;

create trigger tgr_ProdutoVenda_insert_AumentarEstoque after delete
on produto_venda
for each row
update estoque set est_estoque = est_estoque + old.prod_qtd
where est_id = old.fk_estoque_id;


SET SQL_SAFE_UPDATES = 0;
