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

-- Cria um trigger na tabela `tb_enderecos` para gerenciar automaticamente as colunas de `timestamp`
create trigger trigger_gerencia_data_tb_enderecos
  before insert or update on tb_enderecos
  for each row execute procedure gerencia_coluna_timestamp();

alter table tb_empresas add column id_endereco bigint references tb_enderecos(id);

alter table tb_eventos add column id_endereco bigint references tb_enderecos(id);

alter table tb_usuarios add column id_endereco bigint references tb_enderecos(id);

-- Cria um tipo para definir o tipo de ingresso e adiciona uma coluna na tabela carrinho de compras

create type tipo_ingresso as enum ('normal', 'venda', 'troca', 'devolucao');

alter table tb_carrinho add column tipo_ingresso tipo_ingresso not null;


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

-- Cria um trigger na tabela `tb_ingressos_comprados` para gerenciar automaticamente as colunas de `timestamp`
create trigger trigger_gerencia_data_tb_ingressos_comprados
  before insert or update on tb_ingressos_comprados
  for each row execute procedure gerencia_coluna_timestamp();


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

-- Cria um trigger na tabela `tb_ingressos_gerados` para gerenciar automaticamente as colunas de `timestamp`
create trigger trigger_gerencia_data_tb_ingressos_gerados
  before insert or update on tb_ingressos_gerados
  for each row execute procedure gerencia_coluna_timestamp();

-- Cria uma função para inserir o id do ingresso gerado na coluna `id_ingresso_gerado` da tabela de ingressos comprados
create or replace function insere_id_ingresso_gerado()
  returns trigger as $$
  begin
    update tb_ingressos_comprados
    set id_ingresso_gerado = new.id
    where id = new.id_ingresso_comprado;

    return new;
  end;

-- Cria um triger na tabela `tb_ingressos_gerados` para inserir o id do ingresso gerado na coluna `id_ingresso_gerado` da tabela de ingressos comprados
create trigger trigger_insere_id_ingresso_gerado
  after insert on tb_ingressos_gerados
  for each row
  execute procedure insere_id_ingresso_gerado();

---
-- Cria tabela para fluxo de devolução de ingressos
--
-- #8
---

create type tipo_devolucao_ingresso as enum ('venda', 'troca', 'devolucao');

create table tb_ingresso_devolvido (
  id bigserial primary key,
  id_ingresso_comprado bigint not null references tb_ingressos_comprados(id),
  tipo_devolucao tipo_devolucao_ingresso not null,
  created_at timestamptz not null default current_timestamp,
  updated_at timestamptz not null default current_timestamp
);

-- Cria um trigger na tabela `tb_ingresso_devolvido` para gerenciar automaticamente as colunas de `timestamp`
create trigger trigger_gerencia_data_tb_ingresso_devolvido
  before insert or update on tb_ingresso_devolvido
  for each row execute procedure gerencia_coluna_timestamp();

-- Cria uma função para inserir o id do ingresso devolvido na coluna `id_ingresso_devolvido` da tabela de ingressos comprados
create or replace function insere_id_ingresso_devolvido()
  returns trigger as $$
  begin
    update tb_ingressos_comprados
    set id_ingresso_devolvido = new.id
    where id = new.id_ingresso_comprado;

    return new;
  end;

-- Cria um triger na tabela `tb_ingresso_devolvido` para inserir o id do ingresso devolvido na coluna `id_ingresso_devolvido` da tabela de ingressos comprados
create trigger trigger_insere_id_ingresso_devolvido
  after insert on tb_ingresso_devolvido
  for each row
  execute procedure insere_id_ingresso_devolvido();

-- Cria uma função para garantir que um ingresso não seja devolvido mais de uma vez
create or replace function unico_ingresso_devolvido()
  returns trigger as $$
  begin
    if exists (
      select 1
      from tb_ingresso_devolvido
      where id_ingresso_comprado = new.id_ingresso_comprado
    ) then
      raise exception 'Ingresso já foi devolvido';
    end if;

    return new;
  end;

-- Cria um triger na tabela `tb_ingresso_devolvido` para garantir que um ingresso não seja devolvido mais de uma vez
create trigger trigger_unico_ingresso_devolvido
  before insert on tb_ingresso_devolvido
  for each row
  execute procedure unico_ingresso_devolvido();



commit;