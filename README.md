# TicketPlace Database

Prtojeto de BANCO DE DADOS para o sistema de compra de ingressos para eventos, `TicketPlace` da disciplina `PROJETO INTEGRADO: DESENVOLVIMENTO DE SISTEMAS ORIENTADO A DISPOSITIVOS MÓVEIS E BASEADOS NA WEB` do SENAC.

## Integrantes do grupo

ANDRESSA DOS SANTOS JUCOSKI  
BRUNO NATALI  
ISMAEL M. VASCONCELOS JUNIOR  
LUIZ FERNANDO VIDAL  
MATEUS VIEIRA DA SILVA

## Table of Contents

- [Execução](#execução)
  - [Usando o Docker compose](#usando-o-docker-compose)
    - [Antes de começar](#antes-de-começar)
    - [Executando](#executando)
- [Desenvolvimento](#desenvolvimento)
  - [Estrutura](#estrutura)
  - [Volume do banco de dados](#volume-do-banco-de-dados)
  - [Dados](#dados)

## Execução

### Usando o Docker compose

#### Antes de começar

**Atenção:** Se já tiver executado esse sistema antes e realizou alguma atualização de branch ou de versão, remova antes de tudo o volume do banco de dados seguindo os paços descritos na seção [Volume do banco de dados](#volume-do-banco-de-dados), caso contrário a estrutura e os dados não serão atualizados.

#### Executando

Primeiro crie a imagem da do banco de dados com o comando `docker build . -t database`.  

Para executar a aplicação, basta executar o comando `docker compose up`(ou `docker-compose up` dependendo da versão do Docker compose instalada) na raiz do projeto. O comando irá criar um container para o banco de dados e disponibilizar a conexão na porta `5432`.  

Para acessar o banco de dados, pode-se usar o [dbeaver](https://dbeaver.io/) ou qualquer outro cliente de banco de dados.  

## Desenvolvimento

### Estrutura

Primeiramente tenha em mente a seguinte estrutura do projeto:

- db_migration: Pasta com os scripts de migração e seed do banco de dados.
- schema.dbml: Diagrama do banco de dados.

Desta forma qualquer alteração na estrutura do banco de dados deve ser feita no arquivo `schema.dbml`. É nele que ficará registrado todas as tabelas, relacionamentos e campos do banco de dados.  

Após a alteração do arquivo `schema.dbml` com a nova estrutura, inclua um arquivo `.schema.sql` com a numeração maior do que o último arquivo de migração. Por exemplo, se o último arquivo de migração é `001_create_table.sql`, o novo arquivo de migração deve ser `002_alter_table.sql`.  

Após a criação do arquivo de migração, execute o comando `docker compose build` para criar a imagem com o novo arquivo de migração.  

### Volume do banco de dados

**ATENÇÃO:**

> _**ESSE PROCEDIMENTO IRÁ APAGAR TODOS OS DADOS DO BANCO DE DADOS.**_  
> Para que o banco de dados suba com a nova estrutura, é preciso remover a pasta `db_data` na raiz do projeto. O `db_data` é o volume que armazena os dados do banco de dados.

### Dados

Para popular o banco de dados com dados iniciais, crie um arquivo `.seed.sql` com a numeração maior do que o último arquivo de seed. Por exemplo, se o último arquivo de seed é `001_credentials.seed.sql`, o novo arquivo de migração deve ser `002_tables.seed.sql`.
