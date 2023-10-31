create database DB_supermercado;
use DB_supermercado;

create table produto (
pro_id int primary key auto_increment,
pro_nome varchar(100),
pro_valor float not null
);

update produto set pro_valor = 2
where pro_nome = 'chocolate';

select * from produto;
