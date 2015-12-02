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

/* 后台管理用户 */
DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(32) not null AUTO_INCREMENT,
  `username` varchar(50) default '' comment '登录名',
  `password` varchar(50) default '' comment '密码',
  `create_date` datetime comment '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* 公教 */
drop table if exists `gj`;

create table `gj` (
	`id` int(32) AUTO_INCREMENT,
	`title` varchar(50) default '' comment '公教标题',
	`content` varchar(2000) default '' comment '公教内容',
	`url` varchar(200) default '' comment '链接地址',
 	`image` varchar(200) default '' comment '图片url',
 	`type` int(2) default 1 comment '类别 1:公教 2:展览', 
 	`show_date` datetime comment '展出时间',
 	`create_date` datetime comment '创建时间',
	 PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


/* 公教类型 */
drop table if exists `gj_type`;

create table `gj_type`(
	`id` int(32) AUTO_INCREMENT,
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

