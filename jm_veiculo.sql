-- Criação do banco de dados
create database jm_veiculo;
use jm_veiculo;

-- Tabela para armazenar informações dos clientes
create table cliente (
    cli_id int primary key auto_increment,
    cli_nome varchar(100),
    cli_RG int not null,
    cli_endereco varchar(100) not null,
    cli_tel varchar(100),
    cli_CPF int not null
);

-- Tabela para armazenar informações dos veículos
create table veiculo (
    vei_id int primary key auto_increment,
    vei_tipo varchar(100),
    vei_cor varchar(100) not null,
    vei_ano int not null,
    vei_estado varchar(100) not null,
    vei_kmrodados float not null,
    vei_leilao varchar(100),
    vei_cod_placa varchar(100) not null,
    vei_tipo_combustivel varchar(100) not null,
    vei_direcao varchar(100) not null,
    vei_fk_marca INT NOT NULL,  -- rastreador para uma marca e modelo especifico de um veiculo
    vei_fk_modelo INT NOT NULL
);

-- Tabela para armazenar os tipos de desempenho dos veículos
CREATE TABLE tipo_desempenho (
    tipo_id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_nome VARCHAR(100)
);

-- Tabela para armazenar as informações de desempenho dos veículos
CREATE TABLE desempenho (
    desempenho_id INT PRIMARY KEY AUTO_INCREMENT,
    vei_id INT NOT NULL,
    tipo_desempenho INT NOT NULL,
    nome_desempenho varchar(100),
    FOREIGN KEY (vei_id) REFERENCES veiculo (vei_id), -- Chave estrangeira para o veículo
    FOREIGN KEY (tipo_desempenho) REFERENCES tipo_desempenho (tipo_id) -- Chave estrangeira para o tipo de desempenho
);

-- Tabela para armazenar informações das vendas
create table venda (
    ven_id int primary key auto_increment,
    ven_preco_veiculo float not null,
    venda_fk_veiculo int not null,
    foreign key (venda_fk_veiculo) references veiculo (vei_id) -- Chave estrangeira para o veículo vendido
);

-- Tabela para armazenar informações das formas de pagamento
create table forma_pagamento (
    pag_id int primary key auto_increment,
    pag_nome varchar(100),
    pag_fk_cliente int not null,
    foreign key (pag_fk_cliente) references cliente (cli_id) -- Chave estrangeira para o cliente que fez o pagamento
);

-- Tabela para armazenar informações das marcas dos veículos
create table marca (
    marca_id int primary key auto_increment,
    marcs_nome varchar(100)
);

-- Tabela para armazenar informações dos modelos dos veículos
create table modelo (
    model_id int primary key auto_increment,
    model_nome varchar(100),
    model_fk_marca int not null,
    model_fk_veiculo int not null,
    foreign key (model_fk_marca) references marca (marca_id), -- Chave estrangeira para a marca do modelo
    foreign key (model_fk_veiculo) references veiculo (vei_id) -- Chave estrangeira para o veículo do modelo
);

-- Tabela para armazenar informações dos itens vendidos
create table item_venda(
    item_id int primary key auto_increment,
    item_fk_venda int not null,
    foreign key (item_fk_venda) references venda (ven_id) -- Chave estrangeira para a venda a que o item pertence
);

-- Tabela para armazenar informações dos recebimentos
create table recebimento (
    receb_id int primary key auto_increment,
    receb_data date,
    receb_recibo float not null,  -- número de referência exclusivo para aquela transação específica 
    receb_fk_cliente int not null,
    receb_fk_venda int not null,
    receb_fk_pag int not null,
    foreign key (receb_fk_cliente) references cliente (cli_id), -- Chave estrangeira para o cliente que fez o pagamento
    foreign key (receb_fk_venda) references venda (ven_id), -- Chave estrangeira para a venda relacionada ao recebimento
    foreign key (receb_fk_pag) references forma_pagamento (pag_id) -- Chave estrangeira para a forma de pagamento do recebimento
);

-- Inserindo um cliente
INSERT INTO cliente (cli_nome, cli_RG, cli_endereco, cli_tel, cli_CPF)
VALUES ('João Silva', 123456789, 'Rua A, 123', '1234567890', 987654321);

-- Inserindo um veículo
INSERT INTO veiculo (vei_tipo, vei_cor, vei_ano, vei_estado, vei_kmrodados, vei_leilao, vei_num_placa, vei_tipo_combustivel, vei_direcao, vei_fk_marca, vei_fk_modelo)
VALUES ('Sedan', 'Prata', 2022, 'Novo', 10000, 'Não', 1234, 'Gasolina', 'Hidráulica', 1, 1);

-- Inserindo um tipo de desempenho
INSERT INTO tipo_desempenho (tipo_nome)
VALUES ('Direção');

-- Inserindo informações de desempenho para um veículo
INSERT INTO desempenho (vei_id, tipo_desempenho, nome_desempenho)
VALUES (1, 1, 'Hidráulica');

-- Inserindo uma venda
INSERT INTO venda (ven_preco_veiculo, venda_fk_veiculo)
VALUES (50000.00, 1);

-- Inserindo uma forma de pagamento
INSERT INTO forma_pagamento (pag_nome, pag_fk_cliente)
VALUES ('À Vista', 1);

-- Inserindo uma marca
INSERT INTO marca (marcs_nome)
VALUES ('Toyota');

-- Inserindo um modelo
INSERT INTO modelo (model_nome, model_fk_marca, model_fk_veiculo)
VALUES ('Corolla', 1, 1);

-- Inserindo um item de venda
INSERT INTO item_venda (item_fk_venda)
VALUES (1);

-- Inserindo um recebimento
INSERT INTO recebimento (receb_data, receb_recibo, receb_fk_cliente, receb_fk_venda, receb_fk_pag)
VALUES ('2023-08-01', 123, 1, 1, 1);
