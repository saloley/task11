-- pagila/airbyte_setup.sql
-- Создаём пользователя для Airbyte с правами репликации
CREATE USER airbyte_user WITH PASSWORD 'airbyte123';
GRANT USAGE ON SCHEMA public TO airbyte_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO airbyte_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO airbyte_user;

-- Для CDC даём права репликации
ALTER USER airbyte_user REPLICATION;

-- Создаём публикацию
CREATE PUBLICATION airbyte_publication FOR ALL TABLES;

-- Создаём слот репликации
SELECT pg_create_logical_replication_slot('airbyte_slot', 'pgoutput');