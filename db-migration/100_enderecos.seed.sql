INSERT INTO public.tb_enderecos
     (id, cep, rua, numero_cass, complemento, bairro, cidade, estado)
VALUES 
  (1, '12345678', 'Av. das Flores', '123', NULL, 'Jardim Primavera', 'São Paulo', 'SP'),
  (2, '23456789', 'Rua dos Girassóis', '456', NULL, 'Centro', 'Rio de Janeiro', 'RJ'),
  (3, '34567890', 'Travessa das Palmeiras', '789', NULL, 'Jardim Botânico', 'Belo Horizonte', 'MG'),
  (4, '45678901', 'Rua das Margaridas', '1011', NULL, 'Centro', 'Porto Alegre', 'RS'),
  (5, '56789012', 'Av. dos Pinheiros', '1314', NULL, 'Jardim América', 'Curitiba', 'PR'),
  (6, '67890123', 'Rua das Violetas', '1516', NULL, 'Vila Nova', 'Recife', 'PE'),
  (7, '78901234', 'Av. dos Lírios', '1718', NULL, 'Centro', 'Salvador', 'BA'),
  (8, '89012345', 'Rua das Orquídeas', '1920', NULL, 'Jardim das Flores', 'Brasília', 'DF'),
  (9, '90123456', 'Av. das Tulipas', '2122', NULL, 'Centro', 'Fortaleza', 'CE'),
  (10, '01234567', 'Rua dos Cravos', '2324', NULL, 'Jardim Paulista', 'Campinas', 'SP');


-- Criar a sequência manualmente
CREATE SEQUENCE tb_enderecos_id_serial_seq;

-- Ajustar o valor da sequência
SELECT setval('tb_enderecos_id_serial_seq', 11);

