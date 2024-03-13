
insert into public.tb_ingressos
     ("id", "tipo", "valor", "id_evento")
values
(1, 'standard', 85.00, 1),
(2, 'vip', 105.00, 1),
(3, 'premium', 90.00, 1),
(4, 'standard', 70.00, 2),
(5, 'vip', 150.00, 2),
(6, 'premium', 120.00, 2),
(7, 'standard', 30.00, 3),
(8, 'vip', 55.00, 3),
(9, 'premium', 40.00, 3),
(10, 'standard', 25.00, 4),
(11, 'vip', 50.00, 4),
(12, 'premium', 45.00, 4),
(13, 'standard', 105.00, 5),
(14, 'vip', 135.00, 5),
(15, 'premium', 110.00, 5),
(16, 'standard', 180.00, 6),
(17, 'vip', 235.00, 6),
(18, 'premium', 200.00, 6);

select setval('tb_ingressos_id_serial_seq', 19);