CREATE DEFINER=`root`@`localhost` TRIGGER `_cities_AFTER_INSERT` AFTER INSERT ON `_cities` FOR EACH ROW BEGIN
insert into history (log_value, log_time)
value
('Inserted new date', current_timestamp());
END