begin;

-- Criar o tipo ENUM ticket_type
CREATE TYPE ticket_type AS ENUM ('standard', 'vip', 'premium');

-- Criar o tipo ENUM ticket_class
CREATE TYPE ticket_class AS ENUM ('standard', 'senior', 'student', 'promotional');

---------------------
-- Create tables
---------------------

-- Create USER table
create table IF NOT EXISTS public.tb_empresas (
  id              serial       not null,
  nome            varchar(255) not null,
  cnpj            varchar(14)  not null         primary key,
  email           varchar(255) not null,
  criado_data             timestamptz  not null     default current_timestamp,
  modificado_data         timestamptz  not null     default current_timestamp
);


-- Create EVENTO table
create table IF NOT EXISTS public.tb_eventos (
  id              serial        not null        primary key,
  id_empresa      BIGINT        NOT NULL        REFERENCES tb_empresas(id),
  titulo          varchar(255)  not null,
  descricão       text          not null,
  data            timestamptz   not null, --data do evento
  tipo_evento     varchar(255)  not null,
  genero          varchar(255)  not null,
  capa            text    
  criado_data             timestamptz  not null     default current_timestamp,
  modificado_data         timestamptz  not null     default current_timestamp,
  --constraint de relação entre a tabelas
  CONSTRAINT fk_empresa  FOREIGN KEY (customer_id) REFERENCES tb_empresas(id)

);


-- Create INGRESSOS table
create table IF NOT EXISTS public.tb_ingressos (
  id               serial        not null        primary key,
  tipo             ticket_type   not null,
  valor            float         not null,
  id_eventos       bigint        not null        REFERENCES tb_eventos(id),
  criado_data             timestamptz  not null     default current_timestamp,
  modificado_data         timestamptz  not null     default current_timestamp,

  --constraint de relação entre a tabelas
  CONSTRAINT fk_eventos  FOREIGN KEY (id_eventos) REFERENCES tb_eventos(id)
);


-- Create USUARIOS table
create table IF NOT EXISTS public.tb_usuarios (
  id              serial       not null,
  nome            varchar(255) not null,
  cpf             varchar(11)  not null,
  email           varchar(255) not null         primary key,
  senha           varchar(255) not null,
  token           varchar(255) not null,
  criado_data             timestamptz  not null     default current_timestamp,
  modificado_data         timestamptz  not null     default current_timestamp
);


-- Create CARTÃO table
create table IF NOT EXISTS public.tb_dados_cartao (
  id                      serial       not null,
  nome_cartao             varchar(225) not null,
  cpf_titular             varchar(11)  not null,
  numero_cartao           varchar(255) not null,
  data_expiracao          date         not null,
  codigo_seguranca        varchar(4)   not null,
  id_usuarios             bigint       not null     REFERENCES tb_usuarios(id),
  criado_data             timestamptz  not null     default current_timestamp,
  modificado_data         timestamptz  not null     default current_timestamp,

  -- Definir a chave primária composta
  PRIMARY KEY (numero_cartao, data_expiracao, codigo_seguranca),

  --constraint de relação entre a tabelas
  CONSTRAINT fk_usuarios  FOREIGN KEY (usuarios_id) REFERENCES tb_usuarios(id)
);


-- Create PAGAMENTOS table
create table IF NOT EXISTS public.tb_pagamentos (
  id                      serial        not null    primary key,
  quantidade_ingressos    int           not null,
  valor_final             float        not null,
  id_usuarios             bigint       not null    REFERENCES tb_usuarios(id),
  id_ingressos            bigint       not null    REFERENCES tb_ingressos(id),
  criado_data             timestamptz  not null     default current_timestamp,
  modificado_data         timestamptz  not null     default current_timestamp,

  --constraint de relação entre a tabelas
  CONSTRAINT fk_usuarios   FOREIGN KEY (usuarios_id) REFERENCES tb_usuarios(id),
  CONSTRAINT fk_ingressos  FOREIGN KEY (ingressos_id) REFERENCES tb_ingressos(id)

);


-- Create CARRINHO table
create table IF NOT EXISTS public.tb_carrinho (
  id_usuarios              bigint        not null    REFERENCES tb_usuarios(id),
  id_ingressos             bigint        not null    REFERENCES tb_ingressos(id),
  classe                   ticket_class  not null,
  desconto                 float         not null,
  criado_data             timestamptz  not null     default current_timestamp,
  modificado_data         timestamptz  not null     default current_timestamp,

  --constraint de relação entre a tabelas
  CONSTRAINT fk_usuarios   FOREIGN KEY (usuarios_id) REFERENCES tb_usuarios(id),
  CONSTRAINT fk_ingressos  FOREIGN KEY (ingressos_id) REFERENCES tb_ingressos(id)

);


commit;
