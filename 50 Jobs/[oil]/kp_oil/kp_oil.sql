USE `essentialmode`;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('oil_a', 'น้ำมันดิบ', -1, 0, 1),
	('oil_b', 'น้ำมัน', -1, 0, 1)
;

INSERT INTO `licenses` (`type`, `label`) VALUES
	('oil_processing', 'Oil Processing License')
;