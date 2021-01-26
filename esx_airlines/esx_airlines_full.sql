USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_airlines','Airlines',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('society_airlines','Airlines',1)
;

INSERT INTO `jobs` (name, label) VALUES
  ('airlines','Airlines')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('airlines',0,'recrue','Recrue',30,'{}','{}'),
  ('airlines',1,'chauffeur','Chauffeur',40,'{}','{}'),
  ('airlines',2,'pilote','Pilote',50,'{}','{}'),
  ('airlines',3,'gerant','Gerant',60,'{}','{}'),
  ('airlines',4,'boss','Patron',0,'{}','{}')
;
