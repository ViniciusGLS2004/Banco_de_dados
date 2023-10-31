CREATE TABLE Aluno 
( 
 alu_codigo INT PRIMARY KEY,  
 alu_nome VARCHAR(100) NOT NULL,  
  alu_idade INT NOT NULL,  
 alu_telefone INT,  
 alu_endereço VARCHAR(100) 
); 

CREATE TABLE Prof 
( 
 pro_nome VARCHAR(100) NOT NULL,  
 pro_codigo INT PRIMARY KEY,  
 idAluno INT NOT NULL  
); 

CREATE TABLE Disciplina 
( 
 disc_codigo INT PRIMARY KEY,  
 disc_prova INT,  
 disc_nome VARCHAR(100) NOT NULL,  
 idAluno INT NOT NULL,  
 idProf INT NOT NULL  
); 

CREATE TABLE Turma 
( 
 turm_codigo INT PRIMARY KEY,  
 tur_nome VARCHAR(100) NOT NULL,  
 idAluno INT NOT NULL,  
 idDisciplina INT NOT NULL,  
 idProf INT NOT NULL  
); 

ALTER TABLE Prof ADD FOREIGN KEY(idAluno) REFERENCES Aluno (idAluno);
ALTER TABLE Disciplina ADD FOREIGN KEY(idAluno) REFERENCES Aluno (idAluno);
ALTER TABLE Disciplina ADD FOREIGN KEY(idProf) REFERENCES Prof (idProf);
ALTER TABLE Turma ADD FOREIGN KEY(idAluno) REFERENCES Aluno (idAluno);
ALTER TABLE Turma ADD FOREIGN KEY(idDisciplina) REFERENCES Disciplina (idDisciplina);
ALTER TABLE Turma ADD FOREIGN KEY(idProf) REFERENCES Prof (idProf);


insert into Aluno(alu_nome, alu_idade, alu_telefone, alu_endereço)
values ('vinicius', '19', '99999999', 'ruaV');

select * from Aluno; 
