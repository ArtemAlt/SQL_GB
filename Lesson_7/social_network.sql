CREATE SCHEMA `social_network` ;
CREATE TABLE `social_network`.`user` (
  `id_user` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nikname` VARCHAR(150) NOT NULL,
  `count_receive_likes` MEDIUMINT UNSIGNED NULL,
  `count_send_likes` MEDIUMINT UNSIGNED NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE INDEX `nikname_UNIQUE` (`nikname` ASC) VISIBLE);

-- следующие таблицы создаются для каждого пользователя при его создании где id_usere должен быть текущего пользователя
CREATE TABLE `social_network`.`id_usere_likes_receiev` (
  `id_usere` MEDIUMINT UNSIGNED NOT NULL,
  `id_usere_sender` MEDIUMINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_usere`));
  
CREATE TABLE `social_network`.`id_user_likes_send` (
  `id_user` MEDIUMINT UNSIGNED NOT NULL,
  `id_user_receiver` MEDIUMINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_user`));
  ALTER TABLE `social_network`.`id_user_likes_send` 
CHANGE COLUMN `id_user` `id_user` INT UNSIGNED NOT NULL ;
ALTER TABLE `social_network`.`id_usere_likes_receiev` 
CHANGE COLUMN `id_usere` `id_usere` INT UNSIGNED NOT NULL ;
  ALTER TABLE `social_network`.`id_user_likes_send` 
ADD CONSTRAINT `fk_id_user_name`
  FOREIGN KEY (`id_user`)
  REFERENCES `social_network`.`user` (`id_user`)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;
ALTER TABLE `social_network`.`id_usere_likes_receiev` 
ADD CONSTRAINT `fk_id_user_name_receive`
  FOREIGN KEY (`id_usere`)
  REFERENCES `social_network`.`user` (`id_user`)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;
-- при добавление записи в эти таблици должен быть сделан пересчет по count 
-- и число должно быть занесено в user.count_receive_likes либо в user.count_send_likes
-- таким образом мы денормализовали бд но при этом получили ускорение в расчете данных по лайкам

CREATE TABLE `social_network`.`id_name_photo` (
  `id_photo` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_name_user` INT UNSIGNED NOT NULL,
  `link_photo` VARCHAR(155) NOT NULL,
  `count_recieve_likes` MEDIUMINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_photo`));
  ALTER TABLE `social_network`.`id_name_photo` 
ADD INDEX `fk_id_name_photo_idx` (`id_name_user` ASC) VISIBLE;
;
ALTER TABLE `social_network`.`id_name_photo` 
ADD CONSTRAINT `fk_id_name_photo`
  FOREIGN KEY (`id_name_user`)
  REFERENCES `social_network`.`user` (`id_user`)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;
-- принцип такой же, при создании записи в id_name_photo создаем таблицу для подсчета лайков и держим их там
CREATE TABLE `social_network`.`photo_likes` (
  `id_like` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_photo` INT UNSIGNED NOT NULL,
  `id_name_sender` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_like`));
ALTER TABLE `social_network`.`photo_likes` 
ADD INDEX `fk_photo_like_id_photo_idx` (`id_photo` ASC) VISIBLE;
;
ALTER TABLE `social_network`.`photo_likes` 
ADD CONSTRAINT `fk_photo_like_id_photo`
  FOREIGN KEY (`id_photo`)
  REFERENCES `social_network`.`id_name_photo` (`id_photo`)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;
CREATE TABLE `social_network`.`comments_photo` (
  `id_comment` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_photo` INT UNSIGNED NOT NULL,
  `comments_text` TEXT NOT NULL,
  `count_recieve_likes` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_comment`));
CREATE TABLE `social_network`.`comment_likes` (
  `id_like` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_comment` INT UNSIGNED NOT NULL,
  `id_name_sender` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_like`));
ALTER TABLE `social_network`.`comment_likes` 
ADD INDEX `fk_id_comment_idx` (`id_comment` ASC) VISIBLE;
;
ALTER TABLE `social_network`.`comment_likes` 
ADD CONSTRAINT `fk_id_comment`
  FOREIGN KEY (`id_comment`)
  REFERENCES `social_network`.`comments_photo` (`id_comment`)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;
ALTER TABLE `social_network`.`comments_photo` 
ADD INDEX `fk_id_photo_idx` (`id_photo` ASC) VISIBLE;
;
ALTER TABLE `social_network`.`comments_photo` 
ADD CONSTRAINT `fk_id_photo`
  FOREIGN KEY (`id_photo`)
  REFERENCES `social_network`.`id_name_photo` (`id_photo`)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

-- в такой компановке мы получаем очень большое количество таблиц каждый юзер при регистрации уже +2 таблицы
-- при каждом фото + 3 таблицы
-- но по идее это все должно работать быстрее еси бы  мы харанили данные в нф3
-- все создоваемы таблицы и count по ним можно сделать на триггерах и функиях, но правильнее сделать в orm 