create schema localizacao;
use localizacao;

create table estado (
est_id int primary key auto_increment,
est_nome varchar(100) not null
);

create table cidade (
cid_id int primary key auto_increment,
cid_nome varchar(100) not null,
cid_fk_estado int,
foreign key (cid_fk_estado) references estado (est_id)
);

insert into estado (est_nome) values ('Bahia'), ('Pernambuco'), ('Ceará'), ('Sergipe'), ('Paraiba'), ('Rio Grande do Norte'), ('Piauí'), ('Maranhão');
select * from estado;

insert into cidade (cid_nome, cid_fk_estado) 
value ('feira de santana', 1),
 ('recife', 2),
 ('fortaleza', 3),
 ('aracaju', 4),
 ('cuite', 5),
 ('natal', 6),
 ('teresina', 7),
 ('São luiz', 8);

select * from cidade;

delimiter //

create function qtd_cidades(estado varchar(50))
returns int
begin
	declare num_cidades int;
    select count(*) into num_cidades from cidade
    inner join estado on (est_id = cid_fk_estado)
    where est_nome = estado ;
    return num_cidades;
end //

delimiter ;

select qtd_cidades('Pernambuco');