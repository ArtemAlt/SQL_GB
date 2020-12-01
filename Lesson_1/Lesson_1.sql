CREATE TABLE `country` (
  `id_country` smallint unsigned NOT NULL AUTO_INCREMENT,
  `country_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_country`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `region` (
  `id_region` smallint unsigned NOT NULL AUTO_INCREMENT,
  `region_name` varchar(255) NOT NULL,
  `country_id` smallint unsigned NOT NULL,
  PRIMARY KEY (`id_region`),
  KEY `fk_region_country_id_idx` (`country_id`),
  CONSTRAINT `fk_region_country_id` FOREIGN KEY (`country_id`) REFERENCES `country` (`id_country`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `district` (
  `id_district` smallint unsigned NOT NULL AUTO_INCREMENT,
  `district_name` varchar(255) DEFAULT NULL,
  `region_id` smallint unsigned NOT NULL COMMENT 'даже если нет района, будем создавать NULL ',
  PRIMARY KEY (`id_district`),
  KEY `fk_district_region_id_idx` (`region_id`),
  CONSTRAINT `fk_district_region_id` FOREIGN KEY (`region_id`) REFERENCES `region` (`country_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `city` (
  `id_city` smallint unsigned NOT NULL AUTO_INCREMENT,
  `city_district` varchar(255) DEFAULT NULL,
  `city_name` varchar(255) NOT NULL,
  `city_population` int unsigned NOT NULL,
  `city_acreage` int unsigned NOT NULL,
  `district_id` smallint unsigned NOT NULL,
  PRIMARY KEY (`id_city`),
  KEY `fk_city_district_id_idx` (`district_id`),
  CONSTRAINT `fk_city_district_id` FOREIGN KEY (`district_id`) REFERENCES `district` (`id_district`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
