/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.5-10.1.10-MariaDB : Database - management_system
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`management_system` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `management_system`;

/*Table structure for table `categories` */

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `categories_id` int(5) NOT NULL AUTO_INCREMENT,
  `categories_name` varchar(255) DEFAULT NULL,
  `categories_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`categories_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `categories` */

insert  into `categories`(`categories_id`,`categories_name`,`categories_active`) values (1,'Appliances',1),(2,'Beauty & Living',1),(3,'Computing',1),(4,'Fashion',1),(5,'Fitness',1),(6,'Phones',1),(7,'Hakuna Matata',0),(8,'Grocery',1);

/*Table structure for table `company` */

DROP TABLE IF EXISTS `company`;

CREATE TABLE `company` (
  `company_id` int(5) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) DEFAULT NULL,
  `company_city` varchar(255) DEFAULT NULL,
  `company_active` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `company` */

insert  into `company`(`company_id`,`company_name`,`company_city`,`company_active`) values (1,'Apple','Islamabad',1),(2,'Samsung','Karachi',1),(3,'Other',NULL,1);

/*Table structure for table `employee` */

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `emp_id` int(5) NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(255) NOT NULL,
  `emp_username` varchar(255) NOT NULL,
  `emp_password` varchar(16) NOT NULL,
  `emp_gender` varchar(255) DEFAULT NULL,
  `emp_address` varchar(255) DEFAULT NULL,
  `emp_cellno` varchar(20) DEFAULT NULL,
  `emp_hiredate` varchar(255) DEFAULT NULL,
  `emp_active` tinyint(1) DEFAULT NULL,
  `emp_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `emp_type_id` (`emp_type_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`emp_type_id`) REFERENCES `employee_type` (`emp_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `employee` */

insert  into `employee`(`emp_id`,`emp_name`,`emp_username`,`emp_password`,`emp_gender`,`emp_address`,`emp_cellno`,`emp_hiredate`,`emp_active`,`emp_type_id`) values (1,'Zeeshan','Zeeshan','123','Male','Karachi','','2001-05-15',1,1),(2,'Parsho','Parshant','Parshant','Male','Sir Shahzad jo mahallo','123213','2001-11-15',1,2),(3,'Dinesh','Dinesh','12345','Male','','','2001-11-15',1,3),(4,'sid','Sadaquat','123','Male','sid','03337586021','2012-2-2',1,1),(5,'zesho','Zeeshan','abc','Male','9-0','1234567','2001-11-15',1,3),(7,'Aizaz Memon','Aizaz','12345','Male','Badin','92942323','2016-07-16',1,1),(8,'hello','Dear','123','Male','asdf','03337586021','2016-07-13',0,1),(9,'Anushka','Sherni','123','Female','asdsadsa','0333333333','2016-07-16',1,2),(10,'sid','Sadaquat','123','Male','DC','12345','2016-07-11',0,2),(11,'vijay','vjay','khatri','male','khatri','0222','11-22-2014',1,1);

/*Table structure for table `employee_type` */

DROP TABLE IF EXISTS `employee_type`;

CREATE TABLE `employee_type` (
  `emp_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `emp_type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`emp_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `employee_type` */

insert  into `employee_type`(`emp_type_id`,`emp_type_name`) values (1,'Admin'),(2,'Manager'),(3,'Cashier');

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `product_id` int(5) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) DEFAULT NULL,
  `product_price` int(11) DEFAULT NULL,
  `product_active` tinyint(1) DEFAULT NULL,
  `sub_categories_id` int(5) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `sub_categories_id` (`sub_categories_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`sub_categories_id`) REFERENCES `sub_categories` (`sub_categories_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

/*Data for the table `product` */

insert  into `product`(`product_id`,`product_name`,`product_price`,`product_active`,`sub_categories_id`) values (1,'Galaxy Note5',65000,1,3),(2,'Galaxy S6',52000,1,3),(3,'Galaxy Alpha',25000,1,3),(4,'iPhone 6S',73000,1,4),(5,'Men\'s Shirts',1000,1,1),(6,'Women\'s Shirts',2000,1,2),(7,'HTC One M8',50000,1,5),(8,'Lipstick',200,1,6),(9,'Galaxy Note4',40000,1,3),(10,'Aalo',10,0,2),(11,'Macbook 2016',95000,1,9),(12,'Hp 1010',4000,1,10),(13,'Pistol',5000,0,13),(14,'Pistol',1,0,13),(15,'Pistol',1500,0,13),(16,'Pistol',1500,0,13),(17,'rfdfg',3432432,0,13),(18,'Pistol',15000,0,13),(19,'adssad',123,0,13),(20,'asdas',12312,0,13),(21,'adasd',12312,0,13),(22,'asdsd',123,0,13),(23,'asda',123,0,13),(24,'asds',123,0,13),(25,'asds',12,0,13),(26,'asds',12,0,13),(27,'ASDASD',131,0,13),(28,'asda',123,0,13),(29,'asdasd',12313,0,13),(30,'sada',123213,0,13),(31,'asdsa',1231,0,13),(32,'asd',1232,1,13);

/*Table structure for table `receipt` */

DROP TABLE IF EXISTS `receipt`;

CREATE TABLE `receipt` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_price` int(11) DEFAULT NULL,
  `product_quantity` int(11) DEFAULT NULL,
  `total_price` int(11) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `receipt` */

insert  into `receipt`(`product_id`,`product_name`,`product_price`,`product_quantity`,`total_price`) values (2,'Galaxy S6',52000,2,2),(7,'HTC One M8',50000,6,6);

/*Table structure for table `sub_categories` */

DROP TABLE IF EXISTS `sub_categories`;

CREATE TABLE `sub_categories` (
  `sub_categories_id` int(5) NOT NULL AUTO_INCREMENT,
  `sub_categories_name` varchar(255) DEFAULT NULL,
  `sub_categories_active` tinyint(1) DEFAULT NULL,
  `categories_id` int(5) DEFAULT NULL,
  PRIMARY KEY (`sub_categories_id`),
  KEY `categories_id` (`categories_id`),
  CONSTRAINT `sub_categories_ibfk_1` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`categories_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

/*Data for the table `sub_categories` */

insert  into `sub_categories`(`sub_categories_id`,`sub_categories_name`,`sub_categories_active`,`categories_id`) values (1,'Men\'s Fashion',1,4),(2,'Female\'s Fashion',1,4),(3,'Samsung Phones',1,6),(4,'Apple Phones',1,6),(5,'Other Phones',1,6),(6,'Make Up',1,2),(7,'Bath & Body',1,2),(8,'Grooming',1,2),(9,'Laptops',1,3),(10,'Printers',1,3),(11,'Sports Equipment',1,5),(12,'Exercise',1,5),(13,'Large Appliances',1,1),(14,'Small Appliances',1,1),(15,'Gaming',0,3);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
