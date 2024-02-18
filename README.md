# TicketPlace Database

**Table of Contents**:

- [Execução](#execução)
  - [Usando o Docker compose](#usando-o-docker-compose)
- [Desenvolvimento](#desenvolvimento)
  - [Estrutura](#estrutura)
  - [Dados](#dados)

## Execução

### Usando o Docker compose

Primeiro crie a imagem da do banco de dados com o comando `docker build .`.  

Para executar a aplicação, basta executar o comando `docker-compose up` na raiz do projeto. O comando irá criar um container para o banco de dados e disponibilizar a conexão na porta `5432`.  

Para acessar o banco de dados, pode-se usar o [dbeaver](https://dbeaver.io/) ou qualquer outro cliente de banco de dados.  

## Desenvolvimento

### Estrutura

Primeiramente tenha em mente a seguinte estrutura do projeto:

- db_migration: Pasta com os scripts de migração e seed do banco de dados.
- schema.dbml: Diagrama do banco de dados.

Desta forma qualquer alteração na estrutura do banco de dados deve ser feita no arquivo `schema.dbml`. É nele que ficará registrado todas as tabelas, relacionamentos e campos do banco de dados.  

Após a alteração do arquivo `schema.dbml` com a nova estrutura, inclua um arquivo `.schema.sql` com a numeração maior do que o último arquivo de migração. Por exemplo, se o último arquivo de migração é `001_create_table.sql`, o novo arquivo de migração deve ser `002_alter_table.sql`.  

Após a criação do arquivo de migração, execute o comando `docker compose build` para criar a imagem com o novo arquivo de migração.  

**ATENÇÃO**:

> _**ESSE PROCEDIMENTO IRÁ APAGAR TODOS OS DADOS DO BANCO DE DADOS.**_  
> Para que o banco de dados suba com a nova estrutura, é preciso remover a pasta `db_data` na raiz do projeto. O `db_data` é o volume que armazena os dados do banco de dados.

### Dados

Para popular o banco de dados com dados iniciais, crie um arquivo `.seed.sql` com a numeração maior do que o último arquivo de seed. Por exemplo, se o último arquivo de seed é `001_credentials.seed.sql`, o novo arquivo de migração deve ser `002_tables.seed.sql`.
