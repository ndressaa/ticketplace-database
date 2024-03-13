insert into public.tb_usuarios 
  ("id", "id_enderecos", "nome", "cpf", "email", "senha") 
values
  (1, 3, 'Laura Smith', '98765432100','laurasmith@email.com', '$2b$10$MZiaXPO2X1Y/q3Ql.8JSleUlW9itbFIODoaRc3Qjtr3HLKIaCgwPK'),
  (2, 4, 'David Johnson', '12345678900','davidjohnson@email.com', '$2b$10$MZiaXPO2X1Y/q3Ql.8JSleUlW9itbFIODoaRc3Qjtr3HLKIaCgwPK');

  select setval('tb_usuarios_id_serial_seq', 3);