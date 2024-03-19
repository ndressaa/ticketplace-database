begin;

-- Criar ENUM para os tipos de ingressos
create type ticket_type as enum ('standard', 'vip', 'premium');

-- Criar ENUM para as classes de ingressos
create type ticket_class as enum ('standard', 'senior', 'estudante', 'promocional');

---------------------
-- CRIA TODAS AS TABELAS
---------------------

create table if not exists public.tb_enderecos (
  id                      serial            not null,
  cep                     varchar(8)        not null,
  rua                     varchar(255)      not null,
  numero_cass             varchar(10)       not null,
  complemento             varchar(255),
  bairro                  varchar(255)      not null,
  cidade                  varchar(255)      not null,
  estado                  varchar(2)        not null,
  criado_data             timestamptz       not null default current_timestamp,
  atualizado_data         timestamptz       not null default current_timestamp,

  -- Definir a chave primária
  constraint pkey_tb_enderecos  primary key (id),

  -- Definir a coluna `id` como única para ser utilizada como chave estrangeira
  constraint unique_tb_empresas_id unique (id)
);

-- Cria um trigger na tabela `tb_enderecos` para gerenciar automaticamente as colunas de `timestamp`
create trigger trigger_gerencia_data_tb_enderecos
  before insert or update on public.tb_enderecos
  for each row execute procedure public.gerencia_coluna_timestamp();


create table if not exists public.tb_empresas (
  id                      serial            not null,
  id_enderecos            bigint            not null,
  nome                    varchar(255)      not null,
  cnpj                    varchar(14)       not null,
  email                   varchar(255)      not null,
  criado_data             timestamptz       not null default current_timestamp,
  atualizado_data         timestamptz       not null default current_timestamp,

  -- Definir a chave primária
  constraint pkey_tb_empresas primary key (cnpj),

  -- Definir a coluna `id` como única para ser utilizada como chave estrangeira
  constraint unique_tb_empresas_id unique (id),

  -- Chave estrangeira para a tabela de id_enderecos
  constraint fkey_tb_enderecos foreign key (id_enderecos) 
    references public.tb_enderecos(id)
    on update cascade on delete cascade
  
);

-- Cria um trigger na tabela `tb_empresas` para gerenciar automaticamente as colunas de `timestamp`
create trigger trigger_gerencia_data_tb_empresas
  before insert or update on public.tb_empresas
  for each row execute procedure public.gerencia_coluna_timestamp();


create table if not exists public.tb_eventos (
  id                      serial            not null,
  id_empresa              bigint            not null,
  id_enderecos            bigint            not null,
  titulo                  varchar(255)      not null,
  descricao               text              not null,
  data                    timestamptz       not null, --data do evento
  tipo_evento             varchar[]         not null,
  genero                  varchar[]         not null,
  capa                    text,
  criado_data             timestamptz       not null  default current_timestamp,
  atualizado_data         timestamptz       not null  default current_timestamp,

  -- Definir a chave primária
  constraint pkey_tb_eventos primary key (id),

    -- Definir a coluna `id` como única para ser utilizada como chave estrangeira
  constraint unique_tb_eventos unique (id),


  -- Chave estrangeira para a tabela de empresas
  constraint fkey_ foreign key (id_empresa) 
    references public.tb_empresas(id)
    on update cascade on delete cascade,

  -- Chave estrangeira para a tabela de id_enderecos
  constraint fkey_tb_enderecos foreign key (id_enderecos) 
    references public.tb_enderecos(id)
    on update cascade on delete cascade
);

-- Cria um trigger na tabela `tb_eventos` para gerenciar automaticamente as colunas de `timestamp`
create trigger trigger_gerencia_data_tb_eventos
  before insert or update on public.tb_eventos
  for each row execute procedure public.gerencia_coluna_timestamp();


create table if not exists public.tb_ingressos (
  id                      serial            not null,
  tipo                    ticket_type       not null,
  valor                   float             not null,
  id_evento               bigint            not null,
  criado_data             timestamptz       not null default current_timestamp,
  atualizado_data         timestamptz       not null default current_timestamp,

  -- Definir a chave primária
  constraint pkey_tb_ingressos primary key (id),

  -- Definir a coluna `id` como única para ser utilizada como chave estrangeira
  constraint unique_tb_ingressos unique (id),

  -- Chave estrangeira para a tabela de eventos
  constraint fkey_tb_eventos foreign key (id_evento) 
    references public.tb_eventos(id)
    on update cascade on delete cascade
);

-- Cria um trigger na tabela `tb_ingressos` para gerenciar automaticamente as colunas de `timestamp`
create trigger trigger_gerencia_data_tb_ingressos
  before insert or update on public.tb_ingressos
  for each row execute procedure public.gerencia_coluna_timestamp();


create table if not exists public.tb_usuarios (
  id                      serial            not null,
  id_enderecos            bigint            not null,
  nome                    varchar(255)      not null,
  cpf                     varchar(11)       not null,
  email                   varchar(255)      not null,
  senha                   varchar(255)      not null,
  token                   varchar(255),
  criado_data             timestamptz       not null default current_timestamp,
  atualizado_data         timestamptz       not null default current_timestamp,

  -- Definir a chave primária
  constraint pkey_tb_usuarios primary key (cpf),

  -- Definir a coluna `id` como única para ser utilizada como chave estrangeira
  constraint unique_tb_usuarios_id unique (id),

  -- Chave estrangeira para a tabela de id_enderecos
  constraint fkey_tb_enderecos foreign key (id_enderecos) 
    references public.tb_enderecos(id)
    on update cascade on delete cascade  
);

-- Cria um trigger na tabela `tb_usuarios` para gerenciar automaticamente as colunas de `timestamp`
create trigger trigger_gerencia_data_tb_usuarios
  before insert or update on public.tb_usuarios
  for each row execute procedure public.gerencia_coluna_timestamp();


create table if not exists public.tb_dados_cartao (
  id                      serial            not null,
  nome_cartao             varchar(225)      not null,
  cpf_titular             varchar(11)       not null,
  numero_cartao           varchar(255)      not null,
  data_expiracao          date              not null,
  codigo_seguranca        varchar(4)        not null,
  id_usuario              bigint            not null,
  criado_data             timestamptz       not null default current_timestamp,
  atualizado_data         timestamptz       not null default current_timestamp,

  -- Definir a chave primária composta
  primary key (numero_cartao, data_expiracao, codigo_seguranca),

  -- Chave estrangeira para a tabela de usuários
  constraint fkey_tb_usuarios foreign key (id_usuario) 
    references public.tb_usuarios(id)
    on update cascade on delete cascade
);

-- Cria um trigger na tabela `tb_dados_cartao` para gerenciar automaticamente as colunas de `timestamp`
create trigger trigger_gerencia_data_tb_dados_cartao
  before insert or update on public.tb_dados_cartao
  for each row execute procedure public.gerencia_coluna_timestamp();


create table if not exists public.tb_pagamentos (
  id                      serial            not null,
  quantidade_ingressos    int               not null,
  valor_final             float             not null,
  id_usuario              bigint            not null,
  id_ingresso             bigint            not null,
  criado_data             timestamptz       not null default current_timestamp,
  atualizado_data         timestamptz       not null default current_timestamp,

  -- Definir a chave primária
  constraint pkey_tb_pagamentos primary key (id),

  -- Chave estrangeira para a tabela de usuários
  constraint fkey_tb_usuarios foreign key (id_usuario) 
    references public.tb_usuarios(id)
    on update cascade on delete cascade,

  -- Chave estrangeira para a tabela de ingressos
  constraint fkey_tb_ingressos foreign key (id_ingresso) 
    references public.tb_ingressos(id)
    on update cascade on delete cascade
);

-- Cria um trigger na tabela `tb_pagamentos` para gerenciar automaticamente as colunas de `timestamp`
create trigger trigger_gerencia_data_tb_pagamentos
  before insert or update on public.tb_pagamentos
  for each row execute procedure public.gerencia_coluna_timestamp();


create table if not exists public.tb_carrinho (
  id_usuario               bigint           not null,
  id_ingresso              bigint           not null,
  classe                   ticket_class     not null,
  desconto                 float            not null,
  criado_data              timestamptz      not null  default current_timestamp,
  atualizado_data          timestamptz      not null  default current_timestamp,

  -- Chave estrangeira para a tabela de usuários
  constraint fkey_tb_usuarios foreign key (id_usuario) 
    references public.tb_usuarios(id)
    on update cascade on delete cascade,

  -- Chave estrangeira para a tabela de ingressos
  constraint fkey_tb_ingressos foreign key (id_ingresso) 
    references public.tb_ingressos(id)
    on update cascade on delete cascade
);

-- Cria um trigger na tabela `tb_carrinho` para gerenciar automaticamente as colunas de `timestamp`
create trigger trigger_gerencia_data_tb_carrinho
  before insert or update on public.tb_carrinho
  for each row execute procedure public.gerencia_coluna_timestamp();


commit;