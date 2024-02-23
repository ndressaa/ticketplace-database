begin;

-- Create main schemas
create schema if not exists "public";
create schema if not exists "private";

-- Add date fields trigger function
create or replace function public.handle_date_fields()
returns trigger as $$
  begin
    if TG_OP = 'INSERT' then
      -- If is inserting, ensure that `created_at` is `current_timestamp`
      new."created_at" = current_timestamp;
    elsif TG_OP = 'UPDATE' then
      -- Do not allow `created_at` to be updated
      if new."created_at" is distinct from old."created_at" then
        raise exception 'Column "created_at" cannot be updated';
      end if;
      -- Ensure `updated_at` is `current_timestamp` while updating
      new."updated_at" = current_timestamp;
    end if;

    return new;
  end;
$$ language plpgsql volatile;

---------------------
-- Create tables
---------------------

-- Create USER table
create table public.user (
  "id"              bigint       not null,
  "name"            varchar(255) not null,
  "email"           varchar(255) not null,
  "password"        varchar(255) not null,
  "created_at"      timestamptz  not null default current_timestamp,
  "updated_at"      timestamptz  not null default current_timestamp,

  primary key ("email")
);
create trigger trigger_user_handle_date_fields
  before insert or update on public.user
  for each row execute procedure public.handle_date_fields();

-- Create SHOW table
create table public.show (
  "id"              bigint        not null,
  "title"           varchar(255)  not null,
  "description"     text          not null,
  "value"           float         not null,
  "created_at"      timestamptz   not null default current_timestamp,
  "updated_at"      timestamptz   not null default current_timestamp,

  primary key ("id")
);
create trigger trigger_show_handle_date_fields
  before insert or update on public.show
  for each row execute procedure public.handle_date_fields();

commit;