CREATE TABLE IF NOT EXISTS `optic`.`addressDetails` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(255) NOT NULL,
  `number` VARCHAR(45) NOT NULL,
  `floor` VARCHAR(45) NOT NULL,
  `door` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `postal_Code` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE IF NOT EXISTS `optic`.`client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `client_name` VARCHAR(255) NOT NULL,
  `client_adress_id` INT NOT NULL,
  `client_phone_number` VARCHAR(45) NOT NULL,
  `client_email` VARCHAR(45) NOT NULL,
  `referred_client_id` INT NULL,
  `client_registration_date_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_client_adress_id`
    FOREIGN KEY (`client_adress_id`)
    REFERENCES `optic`.`addressDetails` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE IF NOT EXISTS `optic`.`provider` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `provider_name` VARCHAR(50) NOT NULL,
  `provider_address_id` INT NOT NULL,
  `provider_phone_number` VARCHAR(45) NOT NULL,
  `provider_fax_number` VARCHAR(45) NOT NULL,
  `provider_nif` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_provider_address_id`
    FOREIGN KEY (`provider_address_id`)
    REFERENCES `optic`.`addressDetails` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE IF NOT EXISTS `optic`.`brand` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `brand_name` VARCHAR(255) NOT NULL,
  `brand_provider_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_brand_provider_id`
    FOREIGN KEY (`brand_provider_id`)
    REFERENCES `optic`.`provider` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE IF NOT EXISTS `optic`.`glasses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_brand_id` INT NOT NULL,
  `product_graduation_l` FLOAT NOT NULL,
  `product_graduation_r` FLOAT NOT NULL,
  `product_material` VARCHAR(45) NOT NULL,
  `product_price` FLOAT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_product_brand_id`
    FOREIGN KEY (`product_brand_id`)
    REFERENCES `optic`.`brand` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE IF NOT EXISTS `optic`.`sale` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `vendor_id` INT NOT NULL,
  `client_id` INT NOT NULL,
  `sale_invoice_number` VARCHAR(45) NOT NULL,
  `sale_date_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `optic`.`glasses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_client_id`
    FOREIGN KEY (`client_id`)
    REFERENCES `optic`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    