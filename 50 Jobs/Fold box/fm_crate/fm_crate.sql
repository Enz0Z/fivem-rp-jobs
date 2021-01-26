USE `essentialmode`;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('crate_a', 'ลังกระดาษ', 40, 0, 1),
	('box_b', 'กล่อง', 40, 0, 1)
;

INSERT INTO `licenses` (`type`, `label`) VALUES
	('dig_processing', 'dig Processing License')
;