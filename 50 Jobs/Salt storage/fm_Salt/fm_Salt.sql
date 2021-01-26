USE `essentialmode`;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('Salt_a', 'ก้อนเกลือ', 60, 0, 1),
	('Seasoning_b', 'เกลือปรุงรส', 30, 0, 1)
;

INSERT INTO `licenses` (`type`, `label`) VALUES
	('dig_processing', 'dig Processing License')
;