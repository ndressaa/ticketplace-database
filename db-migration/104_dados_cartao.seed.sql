insert into public.tb_dados_cartao
     ("id", "nome_cartao", "cpf_titular", "numero_cartao", "data_expiracao", "codigo_seguranca", "id_usuario") 
values
(1, 'Laura Smith', '98765432100', '4532879012345678', '2025-12-01', '321', 1),
(2, 'David Johnson', '12345678900', '5410 6543 9876 1234', '2025-09-23', '654', 2 );

select setval('tb_dados_cartao_id_serial_seq', 3);