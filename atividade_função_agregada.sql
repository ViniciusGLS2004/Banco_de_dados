create database escola;
use escola;

create table alunos (
alu_id int primary key auto_increment,
alu_nome varchar(100),
alu_curso varchar(80)
);

create table notas (
nota_id int primary key auto_increment,
alu_nota float,
cod_alu_fk_nota int
);

create table materias(
mat_id int primary key auto_increment,
mat_nome varchar(100)
);

create table Aluno_material(
amat_id int primary key auto_increment,
amat_fk_materia int not null,
amat_fk_aluno int not null, 
foreign key (amat_fk_materia) references materias(mat_id),
foreign key (amat_fk_aluno) references alunos(alu_id)
);

update notas
set cod_alu_fk_nota = 5
where nota_id = 5;

select alunos.*, notas.* from alunos -- tabela da chave estrangeira
inner join notas on (alunos.alu_id = notas.cod_alu_fk_nota); -- tabela da chave primaria = chave primaria = chave estrangeira da tabela estrangeira
			
update materias
set amat_fk_materia = 1
where mat_id = 1;

select alunos.alu_id, alunos.alu_nome, materias.mat_nome
from alunos
inner join Aluno_material on alunos.alu_id = Aluno_material.amat_fk_aluno
inner join materias on materias.mat_id = Aluno_material.amat_fk_materia;


alter table notas -- nome da tabela da chave estrangeira
add constraint FK_NOTAS -- a um objeto, não se refençia a nada
	foreign key (cod_alu_fk_nota) -- chave estrangeira
    references alunos (alu_id) -- referençia a tabela e a chave primaria
    on delete no action
    on update no action;

insert into alunos(alu_nome, alu_curso ) value ('vinicius', 'DS2' );
insert into alunos(alu_nome, alu_curso ) value ('juan', 'DS2');
insert into alunos(alu_nome, alu_curso ) value ('felix', 'DS2');
insert into alunos(alu_nome, alu_curso ) value ('leon', 'DS2');
insert into alunos(alu_nome, alu_curso ) value ('patrick', 'DS2');

insert into notas( alu_nota) value ( 8.0);
insert into notas( alu_nota) value (6.0);
insert into notas(alu_nota) value (1.0);
insert into notas(alu_nota) value ( 9.0);
insert into notas(alu_nota) value ( 7.0);

insert into materias(mat_nome) value ('banco de dados');
insert into materias(mat_nome) value ('linguagem de programação'); 
insert into materias(mat_nome) value ('matemática'); 
insert into materias(mat_nome) value ('história'); 
insert into materias(mat_nome) value ('geografia');

select count(*) from alunos;
select avg(alu_nota) from alunos;
select max(alu_nota) from alunos;
select min(alu_nota) from alunos;
select sum(alu_nota) from alunos;

select * from alunos;
select * from notas;
select * from materias;

delete from alunos;
delete from notas;
delete from materias;
set sql_safe_updates = 0;
    