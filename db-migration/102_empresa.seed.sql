insert into public.tb_empresas 
  ("id","id_enderecos", "nome", "cnpj", "email") 
values
  (1, 1, 'Luminar Entertainment', '12345678900000', 'contact@luminarenter.com.br'),
  (2, 2, 'SpectraFusion Studios', '98765432150210', 'contato@spectrastudios.com.br');

  select setval('tb_empresas_id_serial_seq', 3);