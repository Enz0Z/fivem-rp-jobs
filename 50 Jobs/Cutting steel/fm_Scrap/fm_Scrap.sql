USE `essentialmode`;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('Scrap_a', 'เศษเหล็ก', 40, 0, 1),
	('steel_b', 'เหล็กแท้', 40, 0, 1)
;

INSERT INTO `licenses` (`type`, `label`) VALUES
	('dig_processing', 'dig Processing License')
;