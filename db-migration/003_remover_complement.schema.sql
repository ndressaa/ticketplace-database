
create table public.company (
  "id"              bigint        not null serial,
  "name"            varchar(255)  not null,
  "description"     text          not null,
  "created_at"      timestamptz   not null default current_timestamp,
  "updated_at"      timestamptz   not null default current_timestamp,

  primary key ("id") -- constraint
);
create trigger trigger_company_handle_date_fields
  before insert or update on public.company
  for each row execute procedure public.handle_date_fields();


  alter table public.show add column company_id bigint not null;
  alter table public.show 
    add constraint "show_company_id_fk" foreign key (company_id) 
    references public.company ("id") on delete cascade;