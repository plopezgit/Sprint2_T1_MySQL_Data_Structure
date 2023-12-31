-- MySQL Script generated by MySQL Workbench
-- Wed Oct 18 11:28:10 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spotify` DEFAULT CHARACTER SET UTF8MB4 ;
USE `spotify` ;

-- -----------------------------------------------------
-- Table `spotify`.`user_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user_type` (
  `id` INT NOT NULL,
  `user_type_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `spotify`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user` (
  `id` INT NOT NULL,
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `birth_date` DATE NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `postal_code` VARCHAR(45) NOT NULL,
  `user_type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `user_type_id`
    FOREIGN KEY (`user_type_id`)
    REFERENCES `spotify`.`user_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `user_type_id_idx` ON `spotify`.`user` (`user_type_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `email_UNIQUE` ON `spotify`.`user` (`email` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `spotify`.`payment_method_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`payment_method_details` (
  `id` INT NOT NULL,
  `payment_method_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `spotify`.`subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`subscription` (
  `id` INT NOT NULL,
  `subscription_date_time` DATETIME NOT NULL,
  `renew_subscription_date_time` DATETIME NULL,
  `payment_method_id` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `payment_method_id`
    FOREIGN KEY (`payment_method_id`)
    REFERENCES `spotify`.`payment_method_details` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `payment_method_id_idx` ON `spotify`.`subscription` (`payment_method_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `spotify`.`TDC_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`TDC_details` (
  `tdc_number` VARCHAR(20) NOT NULL,
  `caducity_dat` DATE NOT NULL,
  `security_code` VARCHAR(45) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`tdc_number`),
  CONSTRAINT `fk_tdc_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `user_id_idx` ON `spotify`.`TDC_details` (`user_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `spotify`.`paypal_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`paypal_details` (
  `paypal_username` VARCHAR(20) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`paypal_username`),
  CONSTRAINT `fk_pp_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `user_id_idx` ON `spotify`.`paypal_details` (`user_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `spotify`.`subscription_payment_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`subscription_payment_history` (
  `id` INT NOT NULL,
  `payment_date_time` DATETIME NULL,
  `order_number` INT NULL,
  `payment_total` VARCHAR(45) NULL,
  `subscription_id` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `subscription-id`
    FOREIGN KEY (`subscription_id`)
    REFERENCES `spotify`.`subscription` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE UNIQUE INDEX `order_number_UNIQUE` ON `spotify`.`subscription_payment_history` (`order_number` ASC) VISIBLE;

CREATE INDEX `subscription-id_idx` ON `spotify`.`subscription_payment_history` (`subscription_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `spotify`.`playlist_status_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlist_status_detail` (
  `id` INT NOT NULL,
  `status_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `spotify`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlist` (
  `id` INT NOT NULL,
  `playlist_title` VARCHAR(255) NOT NULL,
  `playlist_song_count` INT NOT NULL,
  `playlist_creation_date_time` TIMESTAMP NOT NULL,
  `user_id` INT NOT NULL,
  `playlist_status_id` INT NOT NULL,
  `playlist_type` VARCHAR(45) NOT NULL,
  `playlist_deleted` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `playlist_status_id`
    FOREIGN KEY (`playlist_status_id`)
    REFERENCES `spotify`.`playlist_status_detail` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `user_id_idx` ON `spotify`.`playlist` (`user_id` ASC) VISIBLE;

CREATE INDEX `playlist_status_id_idx` ON `spotify`.`playlist` (`playlist_status_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `spotify`.`artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artist` (
  `id` INT NOT NULL,
  `artist_name` VARCHAR(255) NOT NULL,
  `artist_image` VARCHAR(255) NOT NULL,
  `followers_count` DOUBLE NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `spotify`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`album` (
  `id` INT NOT NULL,
  `album_title` VARCHAR(255) NOT NULL,
  `album_release_year` DATE NOT NULL,
  `album_front_cover` VARCHAR(100) NOT NULL,
  `album_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_artist_id`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_artist_id_idx` ON `spotify`.`album` (`artist_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `spotify`.`song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`song` (
  `id` INT NOT NULL,
  `song_title` VARCHAR(255) NOT NULL,
  `song_duration` INT NOT NULL,
  `song_plays_count` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `album_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_album_id`
    FOREIGN KEY (`album_id`)
    REFERENCES `spotify`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_album_id_idx` ON `spotify`.`song` (`album_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `spotify`.`user_favorites_song`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user_favorites_song` (
  `user_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `song_id`),
  CONSTRAINT `fk_user_has_song_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_song_song1`
    FOREIGN KEY (`song_id`)
    REFERENCES `spotify`.`song` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_user_has_song_song1_idx` ON `spotify`.`user_favorites_song` (`song_id` ASC) VISIBLE;

CREATE INDEX `fk_user_has_song_user1_idx` ON `spotify`.`user_favorites_song` (`user_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `spotify`.`own_playlist_songs_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`own_playlist_songs_details` (
  `playlist_id` INT NOT NULL,
  `playlist_song_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`),
  CONSTRAINT `playlist_song_id`
    FOREIGN KEY (`playlist_song_id`)
    REFERENCES `spotify`.`user_favorites_song` (`song_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_id`
    FOREIGN KEY (`playlist_song_id`)
    REFERENCES `spotify`.`playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `playlist_song_id_idx` ON `spotify`.`own_playlist_songs_details` (`playlist_song_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `spotify`.`deleted_playlist_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`deleted_playlist_details` (
  `id` INT NOT NULL,
  `delete_date_time` DATETIME NOT NULL,
  `own_playlist_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `own_playlist_id`
    FOREIGN KEY (`own_playlist_id`)
    REFERENCES `spotify`.`own_playlist_songs_details` (`playlist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `own_playlist_id_idx` ON `spotify`.`deleted_playlist_details` (`own_playlist_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `spotify`.`shared_playlist_songs_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`shared_playlist_songs_details` (
  `playlist_id` INT NOT NULL,
  `playlist_song_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `adding_date_time` TIMESTAMP NOT NULL,
  PRIMARY KEY (`playlist_id`),
  CONSTRAINT `fk_share_playlist_id`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_share_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_share_playlist_song_id`
    FOREIGN KEY (`playlist_song_id`)
    REFERENCES `spotify`.`song` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `playlist_id_idx` ON `spotify`.`shared_playlist_songs_details` (`playlist_id` ASC) VISIBLE;

CREATE INDEX `playlist_song_id_idx` ON `spotify`.`shared_playlist_songs_details` (`playlist_song_id` ASC) VISIBLE;

CREATE INDEX `user_id_idx` ON `spotify`.`shared_playlist_songs_details` (`user_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `spotify`.`semantic_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`semantic_tags` (
  `id` INT NOT NULL,
  `genre` VARCHAR(255) NOT NULL,
  `musical_period` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `spotify`.`user_follows_artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user_follows_artist` (
  `user_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `artist_id`),
  CONSTRAINT `fk_user_has_artist_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_artist_artist1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_user_has_artist_artist1_idx` ON `spotify`.`user_follows_artist` (`artist_id` ASC) VISIBLE;

CREATE INDEX `fk_user_has_artist_user_idx` ON `spotify`.`user_follows_artist` (`user_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `spotify`.`user_favorites_album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user_favorites_album` (
  `user_id` INT NOT NULL,
  `album_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `album_id`),
  CONSTRAINT `fk_user_has_album_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_album_album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `spotify`.`album` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_user_has_album_album1_idx` ON `spotify`.`user_favorites_album` (`album_id` ASC) VISIBLE;

CREATE INDEX `fk_user_has_album_user1_idx` ON `spotify`.`user_favorites_album` (`user_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `spotify`.`user_has_subscription_payment_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`user_has_subscription_payment_history` (
  `user_id` INT NOT NULL,
  `subscription_payment_history_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `subscription_payment_history_id`),
  CONSTRAINT `fk_user_has_subscription_payment_history_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `spotify`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_subscription_payment_history_subscription_payment1`
    FOREIGN KEY (`subscription_payment_history_id`)
    REFERENCES `spotify`.`subscription_payment_history` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_user_has_subscription_payment_history_subscription_payme_idx` ON `spotify`.`user_has_subscription_payment_history` (`subscription_payment_history_id` ASC) VISIBLE;

CREATE INDEX `fk_user_has_subscription_payment_history_user1_idx` ON `spotify`.`user_has_subscription_payment_history` (`user_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `spotify`.`artist_has_semantic_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artist_has_semantic_tags` (
  `artist_id` INT NOT NULL,
  `semantic_tags_id` INT NOT NULL,
  PRIMARY KEY (`artist_id`, `semantic_tags_id`),
  CONSTRAINT `fk_artist_has_semantic_tags_artist1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `spotify`.`artist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artist_has_semantic_tags_semantic_tags1`
    FOREIGN KEY (`semantic_tags_id`)
    REFERENCES `spotify`.`semantic_tags` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_artist_has_semantic_tags_semantic_tags1_idx` ON `spotify`.`artist_has_semantic_tags` (`semantic_tags_id` ASC) VISIBLE;

CREATE INDEX `fk_artist_has_semantic_tags_artist1_idx` ON `spotify`.`artist_has_semantic_tags` (`artist_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
