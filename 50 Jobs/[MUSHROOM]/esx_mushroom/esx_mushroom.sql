USE `essentialmode`;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('mushroom', 'Mushroom', -1, 0, 1),
	('mushroom_d', 'Dirty Mushroom', -1, 0, 1),
	('mushroom_p', 'Mushroom Pack', -1, 0, 1)
	
;

INSERT INTO `licenses` (`type`, `label`) VALUES
	('mushroom_processing', 'Mushroom Processing License')
;