begin;
---------------------
-- Create tables
---------------------

-- Create USER table
create table IF NOT EXISTS public.tb_empresa (
  id              serial       not null,
  name            varchar(255) not null,
  cnpj            varchar(14)  not null primary key,
  email           varchar(255) not null,
  created_at      timestamptz  not null default current_timestamp,
  updated_at      timestamptz  not null default current_timestamp
);


-- Create SHOW table
create table IF NOT EXISTS public.tb_eventos (
  id              bigint        not null primary key,
  title           varchar(255)  not null,
  description     text          not null,
  value           float         not null,
  created_at      timestamptz   not null default current_timestamp,
  updated_at      timestamptz   not null default current_timestamp
);


-- Create INGRESSOS table
create table IF NOT EXISTS public.tb_ingressos (
  id              bigint        not null primary key,
  value           float         not null,
  id_evento       bigint        not null,
  id_usuario      bigint        not null,
  created_at      timestamptz   not null default current_timestamp,
  updated_at      timestamptz   not null default current_timestamp
);


-- Create USUARIOS table
create table IF NOT EXISTS public.tb_usuarios (
  id              bigint       not null,
  name            varchar(255) not null,
  cpf             varchar(11)  not null,
  email           varchar(255) not null primary key,
  password        varchar(255) not null,
  created_at      timestamptz  not null default current_timestamp,
  updated_at      timestamptz  not null default current_timestamp
);

-- Create CARTÃO table
create table IF NOT EXISTS public.tb_dados_cartao (
  id                      bigint       not null,
  titula_cartao           varchar(225) not null,
  cpf_titular             varchar(11)  not null,
  numero_cartao           varchar(255) not null primary key,
  data_expiracao          timestamptz  not null,
  codigo_seguranca        varchar(4)   not null,
  id_usuario              bigint       not null,
  created_at              timestamptz  not null default current_timestamp,
  updated_at              timestamptz  not null default current_timestamp
);



-- Create PAGAMENTO table
create table IF NOT EXISTS public.tb_pagamentos (
  id                      bigint        not null primary key,
  quantidade_ingressos    int           not null,
  valo_final              float         not null,
  id_usuario              bigint        not null,
  id_ingresso             bigint        not null,
  created_at              timestamptz   not null default current_timestamp,
  updated_at              timestamptz   not null default current_timestamp
);



commit;
