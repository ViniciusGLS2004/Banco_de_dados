create database BD_SEM_NORMALIZAÇÃO;
create database NORMALIZADO;
use BD_SEM_NORMALIZAÇÃO;


-- tabela de cliente
create table cliente (
cli_codigo int primary key auto_increment,
cli_nome varchar(100) not null,
cli_email varchar(50),
cli_tel varchar(15),
total_compra float
);

-- tabela de produto
CREATE table produto (
pro_codigo int primary key auto_increment,
pro_nome varchar(100) not null,
pro_categoria varchar(50),
pro_preco_unitario decimal(10, 2),
pro_fabricante varchar(50)
);

insert into produto (pro_nome, pro_categoria, pro_preco_unitario, pro_fabricante)
values 
('Arroz', 'Alimentos', 5.99, 'Marca A'),
('TV 42 polegadas', 'Eletronicos', 1299.99, 'Marca B'),
('shampoo', 'higiene', 3.50, 'Marca C'),
('Camiseta', 'Vestuário', 15.99, 'Marca A');
-- tabela de vendas
create table vendas (
ven_codigo int primary key auto_increment
);