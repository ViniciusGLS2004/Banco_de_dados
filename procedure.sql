create schema procedimento;
use procedimento;

create table cliente (
cli_id int primary key auto_increment,
cli_nome varchar(100) 
);

create table ordem_servico (
odm_id int primary key auto_increment,
odm_nome varchar(100),
ord_cli_id int,
foreign key (ord_cli_id) references cliente (cli_id)
);

delimiter //

create procedure GetOrdem_servico_cli(in cli_id int)
begin
	select * from ordem_servico where ord_cli_id = cli_id;
end //

delimiter ;

call GetOrdem_servico_cli(1);

insert into cliente (cli_nome)
value ('vini'),
 ('joao'),
 ('marco'),
 ('lari');


insert into ordem_servico (odm_nome, ord_cli_id)
value ('limpar', 1),
 ('cozinhar', 2),
 ('comprar', 3),
 ('vender', 4);



