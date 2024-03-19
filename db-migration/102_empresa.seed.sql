insert into public.tb_empresas 
  ("id", "nome", "cnpj", "email") 
values
  (1, 'Luminar Entertainment', '12345678900000', 'contact@luminarenter.com.br'),
  (2, 'SpectraFusion Studios', '98765432150210', 'contato@spectrastudios.com.br');
  
-- Criar a sequência manualmente
CREATE SEQUENCE tb_empresas_id_serial_seq;

-- Ajustar o valor da sequência
select setval('tb_empresas_id_serial_seq', 3);