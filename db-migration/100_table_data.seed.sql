-- Use esse arquivo para inserir dados nas tabelas
-- Exemplo:

insert into public.user ("id", "name", "email", "password") values
  (1, 'John Doe', 'jhon@example.com', '$2b$10$JJXbrLroa/5r4OQZ9McFKO5JrKjUa71tAWobZGxVVQ.45cXbZlvF2'), -- password: 0000
  (2, 'Jane Doe', 'jane@example.com', '$2b$10$JJXbrLroa/5r4OQZ9McFKO5JrKjUa71tAWobZGxVVQ.45cXbZlvF2'); -- password: 0000


insert into public.show ("id", "title", "description", "value") values
  (1, 'Show 1', 'Description 1', 100.00),
  (2, 'Show 2', 'Description 2', 200.00),
  (3, 'Show 3', 'Description 3', 300.00);