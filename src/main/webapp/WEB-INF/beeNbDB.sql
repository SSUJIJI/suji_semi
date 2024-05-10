-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.4.33-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- bnb 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `bnb` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `bnb`;

-- 테이블 bnb.booking 구조 내보내기
CREATE TABLE IF NOT EXISTS `booking` (
  `booking_no` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(255) NOT NULL,
  `booking_state` enum('전','후','리뷰완료') NOT NULL DEFAULT '전',
  `use_people` int(11) NOT NULL,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `update_date` datetime NOT NULL DEFAULT current_timestamp(),
  `room_no` int(11) NOT NULL,
  PRIMARY KEY (`booking_no`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 bnb.booking:~3 rows (대략적) 내보내기
INSERT IGNORE INTO `booking` (`booking_no`, `customer_id`, `booking_state`, `use_people`, `create_date`, `update_date`, `room_no`) VALUES
	(1, 'kimtery', '전', 3, '2024-05-09 16:50:15', '2024-05-09 16:50:15', 2),
	(2, 'osy', '후', 6, '2024-05-09 16:50:15', '2024-05-09 16:50:15', 2),
	(3, 'osy', '후', 5, '2024-05-09 17:01:29', '2024-05-09 17:01:30', 2);

-- 테이블 bnb.booking_list 구조 내보내기
CREATE TABLE IF NOT EXISTS `booking_list` (
  `booking_no` int(11) NOT NULL,
  `room_no` int(11) NOT NULL,
  `room_date` date NOT NULL,
  PRIMARY KEY (`room_no`,`room_date`),
  KEY `fk_booking_list_booking1_idx` (`booking_no`),
  CONSTRAINT `fk_booking_list_booking1` FOREIGN KEY (`booking_no`) REFERENCES `booking` (`booking_no`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_list_oneday_price1` FOREIGN KEY (`room_no`, `room_date`) REFERENCES `oneday_price` (`room_no`, `room_date`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 bnb.booking_list:~6 rows (대략적) 내보내기
INSERT IGNORE INTO `booking_list` (`booking_no`, `room_no`, `room_date`) VALUES
	(1, 2, '2024-05-10'),
	(1, 2, '2024-05-11'),
	(2, 2, '2024-05-07'),
	(2, 2, '2024-05-08'),
	(3, 2, '2024-05-05'),
	(3, 2, '2024-05-06');

-- 테이블 bnb.complain 구조 내보내기
CREATE TABLE IF NOT EXISTS `complain` (
  `complain_no` int(11) NOT NULL AUTO_INCREMENT,
  `complain_type` enum('비위생적','불친절','옵션 미일치') NOT NULL,
  `complain_content` text NOT NULL,
  `complain_state` enum('접수','처리중','처리완료') NOT NULL DEFAULT '접수',
  `complain_answer` text DEFAULT NULL,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `update_date` datetime NOT NULL DEFAULT current_timestamp() COMMENT '처리중일경우 수정 불가능',
  `booking_no` int(11) NOT NULL,
  PRIMARY KEY (`complain_no`),
  KEY `fk_complain_booking1_idx` (`booking_no`),
  CONSTRAINT `fk_complain_booking1` FOREIGN KEY (`booking_no`) REFERENCES `booking` (`booking_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 bnb.complain:~2 rows (대략적) 내보내기
INSERT IGNORE INTO `complain` (`complain_no`, `complain_type`, `complain_content`, `complain_state`, `complain_answer`, `create_date`, `update_date`, `booking_no`) VALUES
	(1, '불친절', '친절하지 않아요', '처리완료', '처리됐습니다. 불편을 드려 죄송합니다.', '2024-05-09 16:50:24', '2024-05-09 16:50:24', 2),
	(2, '비위생적', '벌레 나왔어요', '접수', NULL, '2024-05-09 17:07:51', '2024-05-09 17:07:51', 3);

-- 테이블 bnb.customer 구조 내보내기
CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` varchar(255) NOT NULL,
  `customer_pw` varchar(16) NOT NULL COMMENT '8이상 16이하',
  `customer_email` varchar(255) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_birth` date NOT NULL,
  `customer_phone` varchar(20) NOT NULL,
  `customer_gender` enum('M','F') NOT NULL,
  `customer_grade` enum('0','1') NOT NULL DEFAULT '0',
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `update_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 bnb.customer:~2 rows (대략적) 내보내기
INSERT IGNORE INTO `customer` (`customer_id`, `customer_pw`, `customer_email`, `customer_name`, `customer_birth`, `customer_phone`, `customer_gender`, `customer_grade`, `create_date`, `update_date`) VALUES
	('kimtery', '1234', 'a@a.com', '김손님', '1999-07-15', '010-0000-0000', 'M', '0', '2024-05-09 16:36:36', '2024-05-09 16:36:36'),
	('osy', '1234', 'b@a.com', '오손님', '2002-08-15', '010-0000-0000', 'F', '1', '2024-05-09 16:36:36', '2024-05-09 16:36:36');

-- 테이블 bnb.customer_pw_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `customer_pw_history` (
  `customer_pw` varchar(16) NOT NULL,
  `customer_id` varchar(255) NOT NULL,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`customer_id`,`customer_pw`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_pw_history_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 bnb.customer_pw_history:~2 rows (대략적) 내보내기
INSERT IGNORE INTO `customer_pw_history` (`customer_pw`, `customer_id`, `create_date`) VALUES
	('1234', 'kimtery', '2024-05-09 16:39:39'),
	('1234', 'osy', '2024-05-09 16:39:39');

-- 테이블 bnb.emp 구조 내보내기
CREATE TABLE IF NOT EXISTS `emp` (
  `emp_no` int(11) NOT NULL AUTO_INCREMENT,
  `emp_name` varchar(255) NOT NULL,
  `emp_pw` varchar(16) NOT NULL,
  `emp_phone` varchar(20) NOT NULL,
  `emp_birth` date NOT NULL,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `update_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`emp_no`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 bnb.emp:~3 rows (대략적) 내보내기
INSERT IGNORE INTO `emp` (`emp_no`, `emp_name`, `emp_pw`, `emp_phone`, `emp_birth`, `create_date`, `update_date`) VALUES
	(1, '박수지', '1234', '010-1234-5678', '2002-03-19', '2024-05-09 16:37:11', '2024-05-09 16:37:11');

-- 테이블 bnb.emp_pw_history 구조 내보내기
CREATE TABLE IF NOT EXISTS `emp_pw_history` (
  `emp_pw` varchar(16) NOT NULL,
  `emp_no` int(11) NOT NULL AUTO_INCREMENT,
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`emp_no`,`emp_pw`),
  CONSTRAINT `emp_pw_history_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `emp` (`emp_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 bnb.emp_pw_history:~1 rows (대략적) 내보내기
INSERT IGNORE INTO `emp_pw_history` (`emp_pw`, `emp_no`, `create_date`) VALUES
	('1234', 1, '2024-05-09 16:39:34');

-- 테이블 bnb.oneday_price 구조 내보내기
CREATE TABLE IF NOT EXISTS `oneday_price` (
  `room_date` date NOT NULL,
  `room_no` int(11) NOT NULL,
  `room_price` int(11) NOT NULL,
  `room_state` enum('예약 가능','예약 완료') NOT NULL DEFAULT '예약 가능',
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `update_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`room_no`,`room_date`),
  KEY `room_no` (`room_no`),
  CONSTRAINT `oneday_price_ibfk_1` FOREIGN KEY (`room_no`) REFERENCES `room` (`room_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 bnb.oneday_price:~7 rows (대략적) 내보내기
INSERT IGNORE INTO `oneday_price` (`room_date`, `room_no`, `room_price`, `room_state`, `create_date`, `update_date`) VALUES
	('2024-05-05', 2, 50000, '예약 가능', '2024-05-09 17:04:18', '2024-05-09 17:04:19'),
	('2024-05-06', 2, 50000, '예약 가능', '2024-05-09 17:05:36', '2024-05-09 17:05:36'),
	('2024-05-07', 2, 50000, '예약 가능', '2024-05-09 16:55:36', '2024-05-09 16:55:36'),
	('2024-05-08', 2, 50000, '예약 가능', '2024-05-09 16:55:36', '2024-05-09 16:55:36'),
	('2024-05-09', 2, 50000, '예약 가능', '2024-05-09 16:55:36', '2024-05-09 16:55:36'),
	('2024-05-10', 2, 50000, '예약 가능', '2024-05-09 16:55:36', '2024-05-09 16:55:36'),
	('2024-05-11', 2, 50000, '예약 가능', '2024-05-09 16:55:36', '2024-05-09 16:55:36');

-- 테이블 bnb.revenue_status 구조 내보내기
CREATE TABLE IF NOT EXISTS `revenue_status` (
  `booking_no` int(11) NOT NULL,
  `revenue` int(11) NOT NULL COMMENT '숙소 가격에서 10%',
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`booking_no`),
  CONSTRAINT `fk_revenue_status_booking1` FOREIGN KEY (`booking_no`) REFERENCES `booking` (`booking_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 bnb.revenue_status:~1 rows (대략적) 내보내기
INSERT IGNORE INTO `revenue_status` (`booking_no`, `revenue`, `create_date`) VALUES
	(2, 10000, '2024-05-09 17:06:14');

-- 테이블 bnb.review 구조 내보내기
CREATE TABLE IF NOT EXISTS `review` (
  `booking_no` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `review_content` text NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`booking_no`),
  KEY `fk_review_booking1_idx` (`booking_no`),
  CONSTRAINT `fk_review_booking1` FOREIGN KEY (`booking_no`) REFERENCES `booking` (`booking_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 bnb.review:~1 rows (대략적) 내보내기
INSERT IGNORE INTO `review` (`booking_no`, `rating`, `review_content`, `create_date`) VALUES
	(2, 1, '호스트가 불편했어요 ㅠㅠ', '2024-05-09 16:50:31');

-- 테이블 bnb.room 구조 내보내기
CREATE TABLE IF NOT EXISTS `room` (
  `room_no` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(255) NOT NULL,
  `room_name` varchar(255) NOT NULL,
  `room_theme` varchar(255) NOT NULL,
  `room_address` varchar(255) NOT NULL,
  `operation_start` date NOT NULL,
  `operation_end` date NOT NULL,
  `max_people` int(11) NOT NULL,
  `room_content` text NOT NULL,
  `room_category` enum('펜션','호텔','리조트','카라반','글램핑','한옥') NOT NULL,
  `approve_state` enum('미승인','승인','반려','재승인') NOT NULL DEFAULT '미승인',
  `create_date` datetime NOT NULL DEFAULT current_timestamp(),
  `update_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`room_no`),
  KEY `fk_room_room_category1_idx` (`room_theme`),
  KEY `fk_room_customer1_idx` (`customer_id`),
  CONSTRAINT `fk_room_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_room_theme` FOREIGN KEY (`room_theme`) REFERENCES `room_theme` (`room_theme`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 bnb.room:~4 rows (대략적) 내보내기
INSERT IGNORE INTO `room` (`room_no`, `customer_id`, `room_name`, `room_theme`, `room_address`, `operation_start`, `operation_end`, `max_people`, `room_content`, `room_category`, `approve_state`, `create_date`, `update_date`) VALUES
	(1, 'osy', '나이스 펜션', '친근한', '인천광역시 남동구 예술로 1번길 1', '2022-01-01', '2025-01-01', 8, '넓고 쾌적한 펜션입니다', '펜션', '미승인', '2024-05-09 16:37:38', '2024-05-09 16:37:38'),
	(2, 'osy', '나이스 호텔', '자연친화적인', '인천광역시 남동구 예술로 1번길 2', '2022-01-01', '2025-01-01', 4, '넓고 쾌적한 호텔입니다', '호텔', '승인', '2024-05-09 16:37:38', '2024-05-09 16:37:38'),
	(3, 'osy', '나이스 리조트', '친근한', '인천광역시 남동구 예술로 1번길 3', '2022-01-01', '2025-01-01', 10, '넓고 쾌적한 리조트입니다', '리조트', '반려', '2024-05-09 16:37:38', '2024-05-09 16:37:38'),
	(4, 'osy', '나이스 글램핑', '자연친화적인', '인천광역시 남동구 예술로 1번길 4', '2022-01-01', '2025-01-01', 2, '넓고 쾌적한 글램핑장입입니다', '글램핑', '재승인', '2024-05-09 16:37:38', '2024-05-09 16:37:38');

-- 테이블 bnb.room_img 구조 내보내기
CREATE TABLE IF NOT EXISTS `room_img` (
  `room_img` varchar(255) NOT NULL,
  `room_no` int(11) NOT NULL,
  PRIMARY KEY (`room_img`),
  KEY `room_no` (`room_no`),
  CONSTRAINT `room_img_ibfk_1` FOREIGN KEY (`room_no`) REFERENCES `room` (`room_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 bnb.room_img:~4 rows (대략적) 내보내기
INSERT IGNORE INTO `room_img` (`room_img`, `room_no`) VALUES
	('펜션.jpg', 1),
	('호텔.jpg', 2),
	('리조트.jpg', 3),
	('글램핑.jpg', 4);

-- 테이블 bnb.room_option 구조 내보내기
CREATE TABLE IF NOT EXISTS `room_option` (
  `room_no` int(11) NOT NULL AUTO_INCREMENT,
  `wifi` enum('0','1') NOT NULL,
  `kitchen_tools` enum('0','1') NOT NULL,
  `parking` enum('0','1') NOT NULL,
  `bed` int(11) NOT NULL,
  `ott` enum('0','1') NOT NULL,
  `ev` enum('0','1') NOT NULL,
  PRIMARY KEY (`room_no`),
  CONSTRAINT `room_option_ibfk_1` FOREIGN KEY (`room_no`) REFERENCES `room` (`room_no`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 bnb.room_option:~4 rows (대략적) 내보내기
INSERT IGNORE INTO `room_option` (`room_no`, `wifi`, `kitchen_tools`, `parking`, `bed`, `ott`, `ev`) VALUES
	(1, '1', '1', '1', 5, '1', '1'),
	(2, '0', '1', '0', 4, '1', '0'),
	(3, '1', '0', '0', 5, '1', '1'),
	(4, '1', '1', '1', 1, '1', '1');

-- 테이블 bnb.room_theme 구조 내보내기
CREATE TABLE IF NOT EXISTS `room_theme` (
  `room_theme` varchar(255) NOT NULL,
  PRIMARY KEY (`room_theme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- 테이블 데이터 bnb.room_theme:~2 rows (대략적) 내보내기
INSERT IGNORE INTO `room_theme` (`room_theme`) VALUES
	('자연친화적인'),
	('친근한');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
