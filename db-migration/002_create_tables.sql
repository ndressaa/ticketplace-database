begin;
---------------------
-- Create tables
---------------------

-- Create USER table
create table IF NOT EXISTS public.tb_empresa (
  id              serial       not null,
  name            varchar(255) not null,
  cnpj            varchar(14)  not null         primary key,
  email           varchar(255) not null,
  created_at      timestamptz  not null         default current_timestamp,
  updated_at      timestamptz  not null         default current_timestamp
);


-- Create SHOW table
create table IF NOT EXISTS public.tb_eventos (
  id              bigint        not null        primary key,
  id_empresa      BIGINT        NOT NULL        REFERENCES tb_empresas(id),
  title           varchar(255)  not null,
  description     text          not null,
  value           float         not null,
  created_at      timestamptz   not null        default current_timestamp,
  updated_at      timestamptz   not null        default current_timestamp
);


-- Create INGRESSOS table
create table IF NOT EXISTS public.tb_ingressos (
  id              bigint        not null        primary key,
  type            ticket_type   not null,
  value           float         not null,
  id_evento       bigint        not null        REFERENCES tb_eventos(id),
  id_usuario      bigint        not null        REFERENCES tb_usuarios(id),
  created_at      timestamptz   not null        default current_timestamp,
  updated_at      timestamptz   not null        default current_timestamp
);


-- Create USUARIOS table
create table IF NOT EXISTS public.tb_usuarios (
  id              bigint       not null,
  name            varchar(255) not null,
  cpf             varchar(11)  not null,
  email           varchar(255) not null         primary key,
  password        varchar(255) not null,
  token           varchar(255) not null,
  created_at      timestamptz  not null         default current_timestamp,
  updated_at      timestamptz  not null         default current_timestamp
);

-- Create CARTÃO table
create table IF NOT EXISTS public.tb_dados_cartao (
  id                      bigint       not null,
  nome_cartao             varchar(225) not null,
  cpf_titular             varchar(11)  not null,
  numero_cartao           varchar(255) not null,
  data_expiracao          date         not null,
  codigo_seguranca        varchar(4)   not null,
  id_usuario              bigint       not null     REFERENCES tb_usuarios(id),
  created_at              timestamptz  not null     default current_timestamp,
  updated_at              timestamptz  not null     default current_timestamp,

  -- Definir a chave primária composta
  CONSTRAINT pk_dados_cartao PRIMARY KEY (numero_cartao, data_expiracao, codigo_seguranca)
);



-- Create PAGAMENTO table
create table IF NOT EXISTS public.tb_pagamentos (
  id                      bigint        not null    primary key,
  quantidade_ingressos    int           not null,
  valo_final              float         not null,
  id_usuario              bigint        not null    REFERENCES tb_usuarios(id),
  id_ingresso             bigint        not null    REFERENCES tb_ingresso(id),
  created_at              timestamptz   not null    default current_timestamp,
  updated_at              timestamptz   not null    default current_timestamp
);

-- Create CARRINHO table
create table IF NOT EXISTS public.tb_carrinho (
  id_usuario              bigint        not null    REFERENCES tb_usuarios(id),
  id_ingresso             bigint        not null    REFERENCES tb_ingresso(id),
  class                   ticket_class  not null,
  valo_final              float         not null,
  created_at              timestamptz   not null    default current_timestamp,
  updated_at              timestamptz   not null    default current_timestamp
);


-- Criar o tipo ENUM ticket_type
CREATE TYPE ticket_type AS ENUM ('standard', 'vip', 'premium');

-- Criar o tipo ENUM ticket_class
CREATE TYPE ticket_class AS ENUM ('standard', 'senior', 'student', 'promotional');

commit;
