CREATE TABLE Aluno 
( 
 alu_codigo INT PRIMARY KEY,  
 alu_nome VARCHAR(100) NOT NULL,  
 alu_idade INT NOT NULL,  
 alu_telefone INT,  
 alu_endereco VARCHAR(100) 
); 

CREATE TABLE Prof 
( 
 pro_codigo INT PRIMARY KEY,  
 pro_nome VARCHAR(100) NOT NULL,  
 alu_codigo INT NOT NULL
); 

CREATE TABLE Disciplina 
( 
 disc_codigo INT PRIMARY KEY,  
 disc_nome VARCHAR(100) NOT NULL,  
 alu_codigo INT NOT NULL,  
 pro_codigo INT NOT NULL
); 

CREATE TABLE Turma 
( 
 turm_codigo INT PRIMARY KEY,  
 turm_nome VARCHAR(100) NOT NULL,  
 alu_codigo INT NOT NULL,  
 disc_codigo INT NOT NULL,  
 pro_codigo INT NOT NULL
); 

-- Adicionando as chaves estrangeiras
ALTER TABLE Prof ADD FOREIGN KEY(alu_codigo) REFERENCES Aluno(alu_codigo);
ALTER TABLE Disciplina ADD FOREIGN KEY(alu_codigo) REFERENCES Aluno(alu_codigo);
ALTER TABLE Disciplina ADD FOREIGN KEY(pro_codigo) REFERENCES Prof(pro_codigo);
ALTER TABLE Turma ADD FOREIGN KEY(alu_codigo) REFERENCES Aluno(alu_codigo);
ALTER TABLE Turma ADD FOREIGN KEY(disc_codigo) REFERENCES Disciplina(disc_codigo);
ALTER TABLE Turma ADD FOREIGN KEY(pro_codigo) REFERENCES Prof(pro_codigo);

INSERT INTO Aluno(alu_codigo, alu_nome, alu_idade, alu_telefone, alu_endereco)
VALUES (1, 'Vinicius', 19, '99999999', 'Rua V');

SELECT * FROM Aluno;

