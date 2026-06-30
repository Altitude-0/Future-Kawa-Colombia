INSERT INTO country (id, code_iso) VALUES (gen_random_uuid(), 'CO') ON CONFLICT DO NOTHING;

INSERT INTO warehouse (id, name, fk_country)
SELECT gen_random_uuid(), 'Almacén Central Medellín', id 
FROM country WHERE code_iso = 'CO';

INSERT INTO containers (id, reference, status, entry_date, fk_warehouse)
SELECT gen_random_uuid(), 'CONT-CO-' || LPAD(s.id::text, 3, '0'), 'COMPLIANT', now() - (random() * interval '60 days'), (SELECT id FROM warehouse LIMIT 1)
FROM generate_series(1, 100) AS s(id);

INSERT INTO sensors_type (id, sensor_type) VALUES (gen_random_uuid(), 'DHT22') ON CONFLICT DO NOTHING;

INSERT INTO sensors (id, reference, entry_date, fk_sensor_type)
SELECT gen_random_uuid(), 'SN-CO-' || LPAD(s.id::text, 3, '0'), now() - interval '60 days', (SELECT id FROM sensors_type WHERE sensor_type = 'DHT22' LIMIT 1)
FROM generate_series(1, 100) AS s(id);

UPDATE containers SET id_sensor = (SELECT id FROM sensors WHERE reference = 'SN-CO-' || SUBSTRING(containers.reference FROM 9))
WHERE reference LIKE 'CONT-CO-%';

-- Génération de 100 mesures par capteur pour avoir 10 000 entrées historiques (très dense)
-- Température Colombie: ~26°C, Humidité: ~80%
-- Historique sur les 25 derniers jours (1 mesure toutes les 6 heures)
INSERT INTO measurements (id, temperature, humidity, created_at, fk_sensors)
SELECT gen_random_uuid(), 
       24.5 + (random() * 3.0), -- entre 24.5 et 27.5 °C
       78.0 + (random() * 4.0), -- entre 78 et 82 %
       now() - (m.id * interval '6 hours'), 
       s.id
FROM sensors s CROSS JOIN generate_series(1, 100) AS m(id);

-- Utilisateurs par défaut
INSERT INTO users (id, username, password, email, role, enabled, created_at) VALUES 
(gen_random_uuid(), 'admin_co', '$2a$10$x.jS5J/3fVv8Z3v3v3v3v.v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3', 'admin_co@futurekawa.co', 'ADMIN', true, now()),
(gen_random_uuid(), 'manager_co', '$2a$10$x.jS5J/3fVv8Z3v3v3v3v.v3v3v3v3v3v3v3v3v3v3v3v3v3v3v3', 'manager_co@futurekawa.co', 'OPERATOR', true, now());
