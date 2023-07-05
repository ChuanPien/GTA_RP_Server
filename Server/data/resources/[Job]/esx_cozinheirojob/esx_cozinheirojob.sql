INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_cozinheiro', 'Cozinheiro', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('society_cozinheiro', 'Cozinheiro', 1),
  ('society_cozinheiro_fridge', 'Cozinheiro (frigorifico)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_cozinheiro', 'Cozinheiro', 1)
;

INSERT INTO `jobs` (name, label, whitelisted) VALUES
  ('cozinheiro', 'Cozinheiro', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('cozinheiro', 0, 'cozinheiro', 'Cozinheiro', 800, '{}', '{}')
;