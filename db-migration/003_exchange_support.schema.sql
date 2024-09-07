begin;

---
-- Cria tabela de endereços e adiciona coluna de endereço nas tabelas de empresas, eventos e usuários
--
-- #3
---

create table tb_enderecos (
  id bigserial primary key,
  cep varchar(8) not null,
  rua varchar(255) not null,
  numero varchar(10) not null,
  complemento varchar(255),
  bairro varchar(255) not null,
  cidade varchar(255) not null,
  estado varchar(2) not null,
  created_at timestamptz not null default current_timestamp,
  updated_at timestamptz not null default current_timestamp
);

alter table tb_empresas add column id_endereco bigint references tb_enderecos(id);

alter table tb_eventos add column id_endereco bigint references tb_enderecos(id);

alter table tb_usuarios add column id_endereco bigint references tb_enderecos(id);


---
-- Cria tabela de ingressos comprados
--
-- #10
---

create table tb_ingressos_comprados (
  id bigserial primary key,
  id_usuario bigint not null references tb_usuarios(id),
  id_ingresso bigint not null references tb_ingressos(id),
  id_ingresso_gerado bigint references tb_ingressos_gerados(id),
  id_ingresso_devolvido bigint references tb_ingresso_devolvido(id),
  created_at timestamptz not null default current_timestamp,
  updated_at timestamptz not null default current_timestamp
);


---
-- Cria tabela de ingressos gerados
--
-- #9
---

create table tb_ingressos_gerados (
  id bigserial primary key,
  id_ingresso_comprado bigint not null references tb_ingressos_comprados(id),
  valor_hash text not null,
  imagem_ingresso text,
  created_at timestamptz not null default current_timestamp,
  updated_at timestamptz not null default current_timestamp
);


---
-- Cria tabela para fluxo de devolução de ingressos
--
-- #8
---

create type tipo_devolucao_ingresso as enum ('VENDA', 'TROCA', 'DEVOLUCAO');

create table tb_ingresso_devolvido (
  id bigserial primary key,
  id_ingresso_comprado bigint not null references tb_ingressos_comprados(id),
  tipo_devolucao tipo_devolucao_ingresso not null,
  created_at timestamptz not null default current_timestamp,
  updated_at timestamptz not null default current_timestamp
);

commit;