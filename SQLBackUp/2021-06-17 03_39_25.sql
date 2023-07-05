-- --------------------------------------------------------
-- 主機:                           127.0.0.1
-- 伺服器版本:                        10.4.18-MariaDB - mariadb.org binary distribution
-- 伺服器作業系統:                      Win64
-- HeidiSQL 版本:                  11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- 傾印 es_extended 的資料庫結構
CREATE DATABASE IF NOT EXISTS `es_extended` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `es_extended`;

-- 傾印  資料表 es_extended.addon_account 結構
CREATE TABLE IF NOT EXISTS `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.addon_account_data 結構
CREATE TABLE IF NOT EXISTS `addon_account_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  KEY `index_addon_account_data_account_name` (`account_name`)
) ENGINE=InnoDB AUTO_INCREMENT=595 DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.addon_inventory 結構
CREATE TABLE IF NOT EXISTS `addon_inventory` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.addon_inventory_items 結構
CREATE TABLE IF NOT EXISTS `addon_inventory_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_name` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`),
  KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`),
  KEY `index_addon_inventory_inventory_name` (`inventory_name`)
) ENGINE=InnoDB AUTO_INCREMENT=686 DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.bankhistory 結構
CREATE TABLE IF NOT EXISTS `bankhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `header` varchar(999) DEFAULT NULL,
  `amount` int(50) DEFAULT 0,
  `msg` varchar(999) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.billing 結構
CREATE TABLE IF NOT EXISTS `billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `sender` varchar(40) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target` varchar(40) NOT NULL,
  `label` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1631 DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.boat_rent 結構
CREATE TABLE IF NOT EXISTS `boat_rent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(40) NOT NULL,
  `plate` varchar(12) NOT NULL,
  PRIMARY KEY (`id`,`plate`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.bought_houses 結構
CREATE TABLE IF NOT EXISTS `bought_houses` (
  `houseid` int(50) NOT NULL,
  PRIMARY KEY (`houseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.car_rent 結構
CREATE TABLE IF NOT EXISTS `car_rent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(40) NOT NULL,
  `plate` varchar(12) NOT NULL,
  PRIMARY KEY (`id`,`plate`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.communityservice 結構
CREATE TABLE IF NOT EXISTS `communityservice` (
  `identifier` varchar(100) NOT NULL,
  `actions_remaining` int(10) NOT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.datastore 結構
CREATE TABLE IF NOT EXISTS `datastore` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.datastore_data 結構
CREATE TABLE IF NOT EXISTS `datastore_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `owner` varchar(40) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`),
  KEY `index_datastore_data_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=817 DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.dpkeybinds 結構
CREATE TABLE IF NOT EXISTS `dpkeybinds` (
  `id` varchar(50) DEFAULT NULL,
  `keybind1` varchar(50) DEFAULT 'num4',
  `emote1` varchar(255) DEFAULT '',
  `keybind2` varchar(50) DEFAULT 'num5',
  `emote2` varchar(255) DEFAULT '',
  `keybind3` varchar(50) DEFAULT 'num6',
  `emote3` varchar(255) DEFAULT '',
  `keybind4` varchar(50) DEFAULT 'num7',
  `emote4` varchar(255) DEFAULT '',
  `keybind5` varchar(50) DEFAULT 'num8',
  `emote5` varchar(255) DEFAULT '',
  `keybind6` varchar(50) DEFAULT 'num9',
  `emote6` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.fine_types 結構
CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.glovebox_inventory 結構
CREATE TABLE IF NOT EXISTS `glovebox_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(8) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate` (`plate`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.items 結構
CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 0,
  `rare` tinyint(4) NOT NULL DEFAULT 0,
  `can_remove` tinyint(4) NOT NULL DEFAULT 1,
  `price` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.jobs 結構
CREATE TABLE IF NOT EXISTS `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.job_grades 結構
CREATE TABLE IF NOT EXISTS `job_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL DEFAULT 2000,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.licenses 結構
CREATE TABLE IF NOT EXISTS `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.owned_properties 結構
CREATE TABLE IF NOT EXISTS `owned_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `rented` int(11) NOT NULL,
  `owner` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.owned_shops 結構
CREATE TABLE IF NOT EXISTS `owned_shops` (
  `identifier` varchar(250) DEFAULT NULL,
  `ShopNumber` int(11) DEFAULT NULL,
  `money` int(11) DEFAULT 0,
  `ShopValue` int(11) DEFAULT NULL,
  `LastRobbery` int(11) DEFAULT 0,
  `ShopName` varchar(30) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.owned_vehicles 結構
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` varchar(40) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) NOT NULL DEFAULT 'civ',
  `fuel` int(11) NOT NULL DEFAULT 100,
  `stored` tinyint(1) NOT NULL DEFAULT 0,
  `garage` varchar(200) DEFAULT 'A',
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.phone_app_chat 結構
CREATE TABLE IF NOT EXISTS `phone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.phone_calls 結構
CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=489 DEFAULT CHARSET=utf8;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.phone_messages 結構
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1820 DEFAULT CHARSET=utf8;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.phone_users_contacts 結構
CREATE TABLE IF NOT EXISTS `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.playerhousing 結構
CREATE TABLE IF NOT EXISTS `playerhousing` (
  `id` int(32) NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `rented` tinyint(1) DEFAULT NULL,
  `price` int(32) DEFAULT NULL,
  `wardrobe` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.playerstattoos 結構
CREATE TABLE IF NOT EXISTS `playerstattoos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `tattoos` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.properties 結構
CREATE TABLE IF NOT EXISTS `properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `entering` varchar(255) DEFAULT NULL,
  `exit` varchar(255) DEFAULT NULL,
  `inside` varchar(255) DEFAULT NULL,
  `outside` varchar(255) DEFAULT NULL,
  `ipls` varchar(255) DEFAULT '[]',
  `gateway` varchar(255) DEFAULT NULL,
  `is_single` int(11) DEFAULT NULL,
  `is_room` int(11) DEFAULT NULL,
  `is_gateway` int(11) DEFAULT NULL,
  `room_menu` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.shops 結構
CREATE TABLE IF NOT EXISTS `shops` (
  `ShopNumber` int(11) NOT NULL DEFAULT 0,
  `src` varchar(50) NOT NULL,
  `count` int(11) NOT NULL,
  `item` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `price` int(11) NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.society_moneywash 結構
CREATE TABLE IF NOT EXISTS `society_moneywash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `society` varchar(60) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.trunk_inventory 結構
CREATE TABLE IF NOT EXISTS `trunk_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(8) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate` (`plate`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.twitter_accounts 結構
CREATE TABLE IF NOT EXISTS `twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(64) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.twitter_likes 結構
CREATE TABLE IF NOT EXISTS `twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  KEY `FK_twitter_likes_twitter_tweets` (`tweetId`),
  CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.twitter_tweets 結構
CREATE TABLE IF NOT EXISTS `twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_tweets_twitter_accounts` (`authorId`),
  CONSTRAINT `FK_twitter_tweets_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=230 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.users 結構
CREATE TABLE IF NOT EXISTS `users` (
  `firstname` varchar(16) DEFAULT NULL,
  `lastname` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci DEFAULT NULL,
  `identifier` varchar(40) CHARACTER SET utf8 NOT NULL,
  `accounts` longtext DEFAULT NULL,
  `inventory` longtext DEFAULT '{"bread":5,"water":5}',
  `job` varchar(20) DEFAULT 'citizen',
  `job_grade` int(11) NOT NULL DEFAULT 0,
  `loadout` longtext DEFAULT NULL,
  `position` varchar(255) DEFAULT '{"x":-910.78,"y":-2041.76,"z":9.4,"heading":135.13}',
  `dateofbirth` varchar(10) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `skin` longtext DEFAULT NULL,
  `group` varchar(50) DEFAULT 'user',
  `status` varchar(50) DEFAULT NULL,
  `jail` int(11) NOT NULL DEFAULT 0,
  `is_dead` tinyint(1) DEFAULT 0,
  `animations` longtext DEFAULT NULL,
  `last_property` varchar(255) DEFAULT NULL,
  `tattoos` longtext DEFAULT NULL,
  `bankbalance` int(32) DEFAULT 0,
  `wanted` int(11) NOT NULL DEFAULT 0,
  `armour` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `crypto` varchar(255) NOT NULL DEFAULT '"bitcoin": 0, "ethereum": 0, "bitcoin-cash": 0, "bitcoin-sv": 0, "litecoin": 0, "binance-coin": 0, "monero": 0, "dash": 0, "zcash": 0, "maker": 0',
  `phone_number` varchar(10) DEFAULT NULL,
  `last_house` int(11) DEFAULT 0,
  `house` longtext NOT NULL DEFAULT '{"owns":false,"furniture":[],"houseId":0}',
  `bought_furniture` longtext NOT NULL DEFAULT '{}',
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.user_lastcharacter 結構
CREATE TABLE IF NOT EXISTS `user_lastcharacter` (
  `steamid` varchar(255) NOT NULL,
  `charid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.user_levels 結構
CREATE TABLE IF NOT EXISTS `user_levels` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `crafting` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.user_licenses 結構
CREATE TABLE IF NOT EXISTS `user_licenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(60) NOT NULL,
  `owner` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.uteknark 結構
CREATE TABLE IF NOT EXISTS `uteknark` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `stage` int(3) unsigned NOT NULL DEFAULT 1,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `soil` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stage` (`stage`,`time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.vehicles_for_sale 結構
CREATE TABLE IF NOT EXISTS `vehicles_for_sale` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seller` varchar(50) NOT NULL,
  `vehicleProps` longtext NOT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.vehicle_sold 結構
CREATE TABLE IF NOT EXISTS `vehicle_sold` (
  `client` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `soldby` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.veh_km 結構
CREATE TABLE IF NOT EXISTS `veh_km` (
  `carplate` varchar(10) NOT NULL,
  `km` varchar(255) NOT NULL DEFAULT '0',
  `state` int(1) NOT NULL DEFAULT 0,
  `reset` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`carplate`),
  UNIQUE KEY `carplate` (`carplate`),
  KEY `carplate_2` (`carplate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.vs_aircrafts 結構
CREATE TABLE IF NOT EXISTS `vs_aircrafts` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.vs_aircraft_categories 結構
CREATE TABLE IF NOT EXISTS `vs_aircraft_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.vs_ambulance 結構
CREATE TABLE IF NOT EXISTS `vs_ambulance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  `category` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.vs_ambulance_categories 結構
CREATE TABLE IF NOT EXISTS `vs_ambulance_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.vs_boats 結構
CREATE TABLE IF NOT EXISTS `vs_boats` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.vs_boat_categories 結構
CREATE TABLE IF NOT EXISTS `vs_boat_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.vs_cars 結構
CREATE TABLE IF NOT EXISTS `vs_cars` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.vs_car_categories 結構
CREATE TABLE IF NOT EXISTS `vs_car_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.vs_police 結構
CREATE TABLE IF NOT EXISTS `vs_police` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  `category` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.vs_police_categories 結構
CREATE TABLE IF NOT EXISTS `vs_police_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.weashops 結構
CREATE TABLE IF NOT EXISTS `weashops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zone` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL DEFAULT 5000,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- 取消選取資料匯出。

-- 傾印  資料表 es_extended.weed_plants 結構
CREATE TABLE IF NOT EXISTS `weed_plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `properties` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4;

-- 取消選取資料匯出。

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
