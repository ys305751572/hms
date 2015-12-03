/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.6.11 : Database - aal
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`hms` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `hms`;
/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` varchar(32) NOT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `account` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `headPic` varchar(255) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `sex` varchar(50) DEFAULT NULL,
  `birthday` varchar(50) DEFAULT NULL,
  `height` varchar(50) DEFAULT NULL,
  `weight` varchar(50) DEFAULT NULL,
  `deviceCode` varchar(50) DEFAULT NULL,
  `userToken` varchar(50) DEFAULT NULL,
  `iosToken` varchar(50) DEFAULT NULL,
  `bak1` varchar(50) DEFAULT NULL,
  `bak2` varchar(50) DEFAULT NULL,
  `bak3` varchar(50) DEFAULT NULL,
  `bak4` varchar(50) DEFAULT NULL,
  `bak5` timestamp NULL DEFAULT NULL,
  `bak6` timestamp NULL DEFAULT NULL,
  `bak7` double DEFAULT NULL,
  `bak8` double DEFAULT NULL,
  `regcode` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `dr` int(11) DEFAULT NULL,
  `ts` datetime DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `maritalStatus` varchar(50) DEFAULT NULL,
  `isHighOrSugar` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`user_id`,`mobile`,`email`,`account`,`password`,`headPic`,`name`,`sex`,`birthday`,`height`,`weight`,`deviceCode`,`userToken`,`iosToken`,`bak1`,`bak2`,`bak3`,`bak4`,`bak5`,`bak6`,`bak7`,`bak8`,`regcode`,`remark`,`dr`,`ts`,`city`,`maritalStatus`,`isHighOrSugar`) values ('00000000000000000000000000000000','13523147658','hao123@126.com','admin','123456','http://img.51daifu.com/elder/20101213/elder_20101213_lwj_1.jpg','总公司管理员',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'99','2014-09-22 00:00:00',NULL,NULL,NULL,NULL,'',0,NULL,NULL,NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


/* 公教 */
drop table if exists `gj`;

create table `gj` (
	`id` bigint(32) AUTO_INCREMENT,
	`title` varchar(50) default '' comment '公教标题',
	`content` varchar(2000) default '' comment '公教内容',
	`url` varchar(200) default '' comment '链接地址',
 	`image` varchar(200) default '' comment '图片url',
 	`type` int(2) default 1 comment '类别 1:公教 2:展览', 
 	`show_start_date` varchar(30) default '' comment '展出开始时间',
 	`show_end_date` varchar(30) default '' comment '展出结束时间',
 	`create_date` datetime comment '创建时间',
 	`is_list` int(2) default -1 comment '是否上架 -1:未上架 1:已上架',
 	`gj_type` int(2) default 0 comment '1:超级课堂 2:移动美术馆 3:特别活动 4:校园大使 5:蒲公英计划6:其他',
 	`create_user` varchar(32) comment '发布人',
	 PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


/* 公教类型 */
drop table if exists `gj_type`;

create table `gj_type`(
	`id` bigint(32) AUTO_INCREMENT,
	`name` varchar(50) default '' comment '类型名称',
	`image` varchar(50) default '' comment '图片url',
	PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


drop table if exists `ads`;
create table `ads` (
	`id` int(32) AUTO_INCREMENT,
	`image` varchar(200) default '' comment '广告图片',
	`is_list` int(2) default -1 comment '是否上架 -1:未上架 1:已上架',
	`create_date` datetime comment '创建时间',
	 PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

