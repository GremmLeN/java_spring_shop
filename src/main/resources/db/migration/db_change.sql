/*Привязка роли  к пользователю
Для возномжности получить/присвоить роль пользователю*/
ALTER TABLE `market`.`users` 
ADD COLUMN `role_id` INT(11) NOT NULL AFTER `email`,
ADD INDEX `fk_roles_idx` (`role_id` ASC);
;
ALTER TABLE `market`.`users` 
ADD CONSTRAINT `fk_roles`
  FOREIGN KEY (`role_id`)
  REFERENCES `market`.`roles` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
/*Таблица категорий товаров
Для возномжности фильтрации товаров
*/
CREATE TABLE `market`.`category` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));
  
/*Привязка категории к товару
Для возномжности фильсрации товаров на странице и не было товаров без категории
*/
ALTER TABLE `market`.`products` 
ADD COLUMN `category_id` INT(11) NOT NULL AFTER `price`,
ADD INDEX `fk_category_idx` (`category_id` ASC);
;
ALTER TABLE `market`.`products` 
ADD CONSTRAINT `fk_category`
  FOREIGN KEY (`category_id`)
  REFERENCES `market`.`category` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
/*Таблица для хранения заказов пользователей*/
CREATE TABLE `market`.`orders` (
  `id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `datetime` DATETIME NOT NULL,
  PRIMARY KEY (`id`, `user_id`, `datetime`),
  INDEX `fk_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `market`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

/*Таблица для хранения спецификации заказов*/
CREATE TABLE `market`.`orders_products` (
  `order_id` INT(11) NOT NULL,
  `product_id` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  PRIMARY KEY (`order_id`, `product_id`),
  INDEX `fk_products_idx` (`product_id` ASC),
  CONSTRAINT `fk_orders`
    FOREIGN KEY (`order_id`)
    REFERENCES `market`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products`
    FOREIGN KEY (`product_id`)
    REFERENCES `market`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);