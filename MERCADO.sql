create database mercado;
use mercado;

create table cliente (
cli_codigo int primary key auto_increment,
cli_nome varchar(100) not null,
cli_email varchar(50),
cli_tel varchar(15),
total_compra float
);

select * from cliente;

select cli_codigo, cli_nome, total_compra from cliente;
insert into cliente (cli_nome,cli_email,total_compra)
value ('RUKIA', 'rukia.biakuya@ba.estudante.senai.br', 70.00);
insert into cliente (cli_nome,cli_email,total_compra)
value ('ICHIGO', 'ichigo.kurosaki@ba.estudante.senai.br', 10.00);

update cliente
set cli_nome = 'renji', cli_email = 'renji@gmail.com'
where cli_codigo = 1;

update cliente
set cli_nome = 'kenpachi', cli_email = 'kenpachi@gmail.com'
where cli_codigo = 2;


DELETE FROM cliente
where cli_codigo = 2;

SET SQL_SAFE_UPDATES = 0;