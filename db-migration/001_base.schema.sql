begin;

-- Cria o schema public e private
create schema if not exists "public";
create schema if not exists "private";

-- Adiciona a função para gerenciar as colunas `criado_data` e `atualizado_data`
create or replace function public.gerencia_coluna_timestamp()
returns trigger as $$
  begin
    if TG_OP = 'INSERT' then
      -- Se `criado_data` não for informado, defina como `current_timestamp`
      new."criado_data" = current_timestamp;
    elsif TG_OP = 'UPDATE' then
      -- Se `criado_data` for diferente de `old.criado_data`, então não permita atualizar
      if new."criado_data" is distinct from old."criado_data" then
        raise exception 'Column "criado_data" cannot be updated';
      end if;
      -- Certifica que `atualizado_data` seja sempre `current_timestamp`
      new."atualizado_data" = current_timestamp;
    end if;

    return new;
  end;
$$ language plpgsql volatile;

commit;