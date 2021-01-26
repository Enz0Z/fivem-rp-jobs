USE `essentialmode`;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('Algae_a', 'สาหร่าย', 40, 0, 1),
	('Seaweed_b', 'สาหร่ายเถ้าแก่น้อย', 40, 0, 1)
;

INSERT INTO `licenses` (`type`, `label`) VALUES
	('dig_processing', 'dig Processing License')
;