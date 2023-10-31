Use loja;

CREATE TABLE Cliente 
( 
 Cod_Client INT PRIMARY KEY,  
 Nome VARCHAR(120),  
 Telefone INT,  
 E_mail INT NOT NULL,  
 cpf INT NOT NULL  
); 

CREATE TABLE Produto 
( 
 Preço FLOAT,  
 cod_Produto INT PRIMARY KEY AUTO_INCREMENT,  
 Nome FLOAT NOT NULL 
); 

CREATE TABLE Venda 
( 
 Cod_Venda INT PRIMARY KEY,  
 Data INT NOT NULL,  
 Cod_Client INT NOT NULL
); 

CREATE TABLE Itens_venda 
( 
 Valor FLOAT,  
 quantidade INT,  
 Cod_Produto INT NOT NULL,  
 Cod_Itens_Vendas INT PRIMARY KEY  
); 

ALTER TABLE Venda ADD FOREIGN KEY(Cod_Client) REFERENCES Cliente (Cod_Client);
ALTER TABLE Itens_venda ADD FOREIGN KEY(Cod_Produto) REFERENCES Produto (Cod_Produto);