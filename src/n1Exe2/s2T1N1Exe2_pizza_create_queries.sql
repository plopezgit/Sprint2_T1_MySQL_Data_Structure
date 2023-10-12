
-- -----------------------------------------------------
-- Table `pizza`.`province`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`province` (
  `id` INT NOT NULL,
  `province_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza`.`locality`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`locality` (
  `id` INT NOT NULL,
  `locality_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizza`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`client` (
  `id` INT NOT NULL,
  `client_name` VARCHAR(255) NOT NULL,
  `client_surname` VARCHAR(255) NULL,
  `client_adress` VARCHAR(45) NOT NULL,
  `client_post_code` VARCHAR(45) NOT NULL,
  `client_locality_id` INT NOT NULL,
  `client_province_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_client_province_id`
    FOREIGN KEY (`client_province_id`)
    REFERENCES `pizza`.`province` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_client_locality_id`
    FOREIGN KEY (`client_locality_id`)
    REFERENCES `pizza`.`locality` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `pizza`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`order` (
  `id` INT NOT NULL,
  `order_product_id` INT NOT NULL,
  `order_local_date_time` DATETIME NOT NULL,
  `order_type` VARCHAR(45) NOT NULL,
  `order_quantity` VARCHAR(45) NOT NULL,
  `order_vendor_id` INT NOT NULL,
  `order_client_id` INT NOT NULL,
  `order_invoice_number` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_order_client_id`
    FOREIGN KEY (`order_client_id`)
    REFERENCES `pizza`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `pizza`.`product_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`product_category` (
  `id` INT NOT NULL,
  `product_category_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `pizza`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`product` (
  `id` INT NOT NULL,
  `product_category_id` INT NOT NULL,
  `product_name` VARCHAR(45) NULL,
  `product_description` VARCHAR(45) NULL,
  `product_image` VARCHAR(255) NULL,
  `product_price` INT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `product_category_id`
    FOREIGN KEY (`product_category_id`)
    REFERENCES `pizza`.`product_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);




-- -----------------------------------------------------
-- Table `pizza`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`store` (
  `id` INT NOT NULL,
  `store_address` VARCHAR(255) NOT NULL,
  `store_post_code` VARCHAR(45) NOT NULL,
  `store_locality_id` INT NOT NULL,
  `store_province_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_store_locality_id`
    FOREIGN KEY (`store_locality_id`)
    REFERENCES `pizza`.`locality` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_store_province_id`
    FOREIGN KEY (`store_province_id`)
    REFERENCES `pizza`.`province` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `pizza`.`vendor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`vendor` (
  `id` INT NOT NULL,
  `vendor_name` VARCHAR(100) NOT NULL,
  `vendor_surname` VARCHAR(100) NOT NULL,
  `vendor_nif` VARCHAR(45) NOT NULL,
  `vendor_phone_number` VARCHAR(45) NOT NULL,
  `vendor_type` VARCHAR(45) NOT NULL,
  `vendor_store_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_vendor_store_id`
    FOREIGN KEY (`vendor_store_id`)
    REFERENCES `pizza`.`store` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `pizza`.`delivery_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`delivery_details` (
  `id` INT NOT NULL,
  `delivery_vendor_id` INT NOT NULL,
  `delivery_order_id` INT NOT NULL,
  `delivery_local_date_time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_delivery_vendor_id`
    FOREIGN KEY (`delivery_vendor_id`)
    REFERENCES `pizza`.`vendor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_delivery_order_id`
    FOREIGN KEY (`delivery_order_id`)
    REFERENCES `pizza`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



-- -----------------------------------------------------
-- Table `pizza`.`product_has_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizza`.`product_has_order` (
  `product_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  PRIMARY KEY (`product_id`, `order_id`),
  CONSTRAINT `fk_product_has_order_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `pizza`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_order_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `pizza`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
