/*
SQLyog v10.2 
MySQL - 5.5.15 : Database - osf
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`osf` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `osf`;

/*Table structure for table `osf_albums` */

DROP TABLE IF EXISTS `osf_albums`;

CREATE TABLE `osf_albums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `create_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `album_title` text,
  `album_desc` text COMMENT '描述',
  `last_add_ts` datetime NOT NULL,
  `photos_count` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL,
  `cover` varchar(50) DEFAULT NULL,
  `album_tags` text,
  PRIMARY KEY (`id`),
  KEY `fk_osf_albums_album_author_idx` (`user_id`),
  CONSTRAINT `fk_osf_albums_album_author` FOREIGN KEY (`user_id`) REFERENCES `osf_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `osf_albums` */

insert  into `osf_albums`(`id`,`user_id`,`create_ts`,`album_title`,`album_desc`,`last_add_ts`,`photos_count`,`status`,`cover`,`album_tags`) values (1,23,'2016-06-02 10:56:38',NULL,'asdf','2016-06-02 00:00:00',1,0,'9f457ac5-9db2-4bcb-9e8e-b6ad6f35ac46.jpeg',NULL),(2,23,'2016-06-02 11:09:46',NULL,'asdf','2016-06-02 00:00:00',1,0,'54129e92-e25f-49bb-818f-bcb61435e0e2.jpeg',NULL);

/*Table structure for table `osf_comments` */

DROP TABLE IF EXISTS `osf`.`osf_comments`;
CREATE TABLE IF NOT EXISTS `osf`.`osf_comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment_object_type` INT NOT NULL COMMENT 'post, album,...',
  `comment_object_id` INT NOT NULL,
  `comment_author` INT NOT NULL,
  `comment_author_name` VARCHAR(100) NOT NULL,
  `comment_ts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment_content` TEXT NOT NULL,
  `comment_parent` INT NOT NULL DEFAULT 0,
  `comment_parent_author_name` VARCHAR(100) NULL,
  `comment_parent_author` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_osf_comments_comment_author_idx` (`comment_author` ASC),
  CONSTRAINT `fk_osf_comments_comment_author`
    FOREIGN KEY (`comment_author`)
    REFERENCES `osf`.`osf_users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = INNODB;

/*Data for the table `osf_comments` */

/*Table structure for table `osf_events` */

DROP TABLE IF EXISTS `osf_events`;

CREATE TABLE `osf_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_type` int(11) NOT NULL,
  `object_id` int(11) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `user_avatar` varchar(100) DEFAULT NULL,
  `like_count` int(11) NOT NULL,
  `share_count` int(11) NOT NULL,
  `comment_count` int(11) NOT NULL,
  `title` text,
  `summary` text,
  `content` text,
  `tags` text,
  `following_user_id` int(11) DEFAULT NULL,
  `following_user_name` varchar(50) DEFAULT NULL,
  `follower_user_id` int(11) DEFAULT NULL,
  `follower_user_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `osf_events_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `osf_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `osf_events` */

insert  into `osf_events`(`id`,`object_type`,`object_id`,`ts`,`user_id`,`user_name`,`user_avatar`,`like_count`,`share_count`,`comment_count`,`title`,`summary`,`content`,`tags`,`following_user_id`,`following_user_name`,`follower_user_id`,`follower_user_name`) values (9,4,7,'2016-06-02 12:41:06',23,NULL,NULL,0,0,0,NULL,'sdddddddddddd',NULL,NULL,0,NULL,0,NULL),(11,0,9,'2016-06-02 13:16:25',23,NULL,NULL,0,0,0,'sdf','asdf',NULL,NULL,0,NULL,0,NULL),(12,0,10,'2016-06-02 13:20:01',23,NULL,NULL,0,0,0,'asdf','sdfsadf',NULL,NULL,0,NULL,0,NULL),(13,4,11,'2016-06-02 23:26:57',23,NULL,NULL,0,0,0,NULL,'sdfasdfasdfasdfasdfasdf',NULL,NULL,0,NULL,0,NULL),(14,4,12,'2016-06-02 23:26:59',23,NULL,NULL,0,0,0,NULL,'sdfasdfasdfasdfasdfasdf',NULL,NULL,0,NULL,0,NULL),(15,0,13,'2016-06-03 15:25:46',23,NULL,NULL,0,0,0,'下雨','。。。。。。。。。。。。。。',NULL,NULL,0,NULL,0,NULL),(16,0,14,'2016-06-03 15:38:59',23,NULL,NULL,0,0,0,'asdfas ',' 阿斯顿发射点发生地方',NULL,'撒地方:1 撒旦发生地方:2 ',0,NULL,0,NULL),(17,0,15,'2016-06-03 15:39:21',23,NULL,NULL,0,0,0,'阿斯地方','阿斯地方',NULL,'的:3 ',0,NULL,0,NULL),(18,0,16,'2016-06-03 16:28:02',23,NULL,NULL,0,0,0,'阿斯顿发射打发','阿斯顿发射打发',NULL,'adfx的:4 ',0,NULL,0,NULL);

/*Table structure for table `osf_followers` */

DROP TABLE IF EXISTS `osf_followers`;

CREATE TABLE `osf_followers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `follower_user_id` int(11) NOT NULL,
  `follower_user_name` varchar(50) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`follower_user_id`),
  CONSTRAINT `osf_followers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `osf_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `osf_followers` */

/*Table structure for table `osf_followings` */

DROP TABLE IF EXISTS `osf_followings`;

CREATE TABLE `osf_followings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `following_user_id` int(11) NOT NULL,
  `following_user_name` varchar(50) DEFAULT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`following_user_id`),
  CONSTRAINT `osf_followings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `osf_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `osf_followings` */

/*Table structure for table `osf_interests` */

DROP TABLE IF EXISTS `osf_interests`;

CREATE TABLE `osf_interests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`tag_id`),
  CONSTRAINT `osf_interests_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `osf_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `osf_interests` */

/*Table structure for table `osf_likes` */

DROP TABLE IF EXISTS `osf_likes`;

CREATE TABLE `osf_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `object_type` int(11) NOT NULL,
  `object_id` int(11) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`object_type`,`object_id`),
  CONSTRAINT `osf_likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `osf_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `osf_likes` */

/*Table structure for table `osf_notifications` */

DROP TABLE IF EXISTS `osf_notifications`;

CREATE TABLE `osf_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notify_type` int(11) NOT NULL,
  `notify_id` int(11) NOT NULL,
  `object_type` int(11) NOT NULL,
  `object_id` int(11) NOT NULL,
  `notified_user` int(11) NOT NULL,
  `notifier` int(11) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL default 0,
  PRIMARY KEY (`id`),
  KEY `notified_user` (`notified_user`),
  CONSTRAINT `osf_notifications_ibfk_1` FOREIGN KEY (`notified_user`) REFERENCES `osf_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `osf_notifications` */

/*Table structure for table `osf_photos` */

DROP TABLE IF EXISTS `osf_photos`;

CREATE TABLE `osf_photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(45) NOT NULL,
  `album_id` int(11) NOT NULL,
  `ts` timestamp NULL DEFAULT NULL,
  `desc` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `album_id` (`album_id`),
  CONSTRAINT `osf_photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `osf_albums` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `osf_photos` */

/*Table structure for table `osf_posts` */

DROP TABLE IF EXISTS `osf_posts`;

CREATE TABLE `osf_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_author` int(11) NOT NULL COMMENT '作者ID',
  `post_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `post_content` longtext NOT NULL,
  `post_title` text,
  `post_excerpt` text COMMENT '摘要',
  `post_status` int(11) NOT NULL DEFAULT '0',
  `comment_status` int(11) NOT NULL DEFAULT '0',
  `post_pwd` varchar(60) DEFAULT NULL,
  `post_lastts` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_count` int(11) NOT NULL DEFAULT '0',
  `like_count` int(11) NOT NULL DEFAULT '0',
  `share_count` int(11) NOT NULL DEFAULT '0',
  `post_url` varchar(45) DEFAULT NULL,
  `post_tags` text,
  `post_album` int(11) NOT NULL DEFAULT '0',
  `post_cover` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_osf_users_post_author_idx` (`post_author`),
  CONSTRAINT `fk_osf_users_post_author` FOREIGN KEY (`post_author`) REFERENCES `osf_users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `osf_posts` */

insert  into `osf_posts`(`id`,`post_author`,`post_ts`,`post_content`,`post_title`,`post_excerpt`,`post_status`,`comment_status`,`post_pwd`,`post_lastts`,`comment_count`,`like_count`,`share_count`,`post_url`,`post_tags`,`post_album`,`post_cover`) values (7,23,'2016-06-02 12:41:06','sdddddddddddd',NULL,NULL,0,0,NULL,'0000-00-00 00:00:00',0,0,0,NULL,NULL,0,NULL),(9,23,'2016-06-02 13:16:45','<p>asdf</p>','sdf','asdf',0,0,NULL,'2016-06-02 13:16:25',0,0,0,NULL,NULL,0,NULL),(10,23,'2016-06-02 13:20:01','<p>sdfsadf</p>','asdf','sdfsadf',0,0,NULL,'2016-06-02 13:20:01',0,0,0,NULL,NULL,0,NULL),(11,23,'2016-06-02 23:26:55','sdfasdfasdfasdfasdfasdf',NULL,NULL,0,0,NULL,'2016-06-02 23:26:55',0,0,0,NULL,NULL,0,NULL),(12,23,'2016-06-02 23:26:59','sdfasdfasdfasdfasdfasdf',NULL,NULL,0,0,NULL,'2016-06-02 23:26:59',0,0,0,NULL,NULL,0,NULL),(13,23,'2016-06-03 15:25:46','<p>。。。。。。。。。。。。。。</p>','下雨','。。。。。。。。。。。。。。',0,0,NULL,'2016-06-03 15:25:46',0,0,0,NULL,NULL,0,NULL),(14,23,'2016-06-03 15:38:59','<p>&nbsp;阿斯顿发射点发生地方</p>','asdfas ',' 阿斯顿发射点发生地方',0,0,NULL,'2016-06-03 15:38:59',0,0,0,NULL,'撒地方:1 撒旦发生地方:2 ',0,NULL),(15,23,'2016-06-03 15:39:20','<p>阿斯地方</p>','阿斯地方','阿斯地方',0,0,NULL,'2016-06-03 15:39:20',0,0,0,NULL,'的:3 ',0,NULL),(16,23,'2016-06-03 16:28:02','<p>阿斯顿发射打发</p>','阿斯顿发射打发','阿斯顿发射打发',0,0,NULL,'2016-06-03 16:28:02',0,0,0,NULL,'adfx的:4 ',0,NULL);

/*Table structure for table `osf_relations` */

DROP TABLE IF EXISTS `osf_relations`;

CREATE TABLE `osf_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_type` int(11) NOT NULL,
  `object_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `add_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_tag_id_idx` (`tag_id`),
  KEY `object_id` (`object_id`),
  CONSTRAINT `fk_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `osf_tags` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `osf_relations_ibfk_1` FOREIGN KEY (`object_id`) REFERENCES `osf_posts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `osf_relations` */

insert  into `osf_relations`(`id`,`object_type`,`object_id`,`tag_id`,`add_ts`) values (1,0,14,1,'2016-06-03 15:38:59'),(2,0,14,2,'2016-06-03 15:38:59'),(3,0,15,3,'2016-06-03 15:39:20'),(4,0,16,4,'2016-06-03 16:28:02');

/*Table structure for table `osf_tags` */

DROP TABLE IF EXISTS `osf_tags`;

CREATE TABLE `osf_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(30) NOT NULL,
  `add_ts` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cover` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `osf_tags` */

insert  into `osf_tags`(`id`,`tag`,`add_ts`,`cover`) values (1,'撒地方','2016-06-03 15:38:58',NULL),(2,'撒旦发生地方','2016-06-03 15:38:59',NULL),(3,'的','2016-06-03 15:39:20',NULL),(4,'adfx的','2016-06-03 16:28:01',NULL);

/*Table structure for table `osf_users` */

DROP TABLE IF EXISTS `osf_users`;

CREATE TABLE `osf_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) DEFAULT NULL,
  `user_email` varchar(100) NOT NULL,
  `user_pwd` varchar(100) NOT NULL,
  `user_registered_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_status` int(11) DEFAULT NULL,
  `user_activationKey` varchar(24) DEFAULT NULL,
  `user_avatar` varchar(100) DEFAULT NULL,
  `user_desc` text,
  `resetpwd_key` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`,`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*Data for the table `osf_users` */

insert  into `osf_users`(`id`,`user_name`,`user_email`,`user_pwd`,`user_registered_date`,`user_status`,`user_activationKey`,`user_avatar`,`user_desc`,`resetpwd_key`) values (23,'admin','779187545@qq.com','25D55AD283AA400AF464C76D713C07AD','2016-06-01 20:16:55',0,'P1Y2yfqBqlFaJ3nJukIo3A==','default-avatar.jpg',NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
