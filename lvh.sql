/*
 Navicat MySQL Data Transfer

 Source Server         : DBMySQL
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : lvh

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 22/06/2018 15:56:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ihome_area
-- ----------------------------
DROP TABLE IF EXISTS `ihome_area`;
CREATE TABLE `ihome_area`  (
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ihome_area
-- ----------------------------
INSERT INTO `ihome_area` VALUES (NULL, NULL, 1, '锦江区');
INSERT INTO `ihome_area` VALUES (NULL, NULL, 2, '金牛区');
INSERT INTO `ihome_area` VALUES (NULL, NULL, 3, '青羊区');
INSERT INTO `ihome_area` VALUES (NULL, NULL, 4, '高新区');
INSERT INTO `ihome_area` VALUES (NULL, NULL, 5, '武侯区');
INSERT INTO `ihome_area` VALUES (NULL, NULL, 6, '天府新区');
INSERT INTO `ihome_area` VALUES (NULL, NULL, 7, '双流县');
INSERT INTO `ihome_area` VALUES (NULL, NULL, 8, '成华区');
INSERT INTO `ihome_area` VALUES (NULL, NULL, 9, '青白江区');
INSERT INTO `ihome_area` VALUES (NULL, NULL, 10, '新都区');
INSERT INTO `ihome_area` VALUES (NULL, NULL, 11, '温江区');
INSERT INTO `ihome_area` VALUES (NULL, NULL, 12, '温江区');
INSERT INTO `ihome_area` VALUES (NULL, NULL, 13, '郫县');
INSERT INTO `ihome_area` VALUES (NULL, NULL, 14, '蒲江县');
INSERT INTO `ihome_area` VALUES (NULL, NULL, 15, '大邑县');
INSERT INTO `ihome_area` VALUES (NULL, NULL, 16, '新津县');

-- ----------------------------
-- Table structure for ihome_facility
-- ----------------------------
DROP TABLE IF EXISTS `ihome_facility`;
CREATE TABLE `ihome_facility`  (
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `css` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ihome_facility
-- ----------------------------
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 1, '无线网络', 'wirelessnetwork-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 2, '热水淋浴', 'shower-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 3, '空调', 'aircondition-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 4, '暖气', 'heater-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 5, '允许吸烟', 'smoke-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 6, '饮水设备', 'drinking-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 7, '牙具', 'brush-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 8, '香皂', 'soap-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 9, '拖鞋', 'slippers-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 10, '手纸', 'toiletpaper-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 11, '毛巾', 'towel-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 12, '沐浴露、洗发露', 'toiletries-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 13, '冰箱', 'icebox-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 14, '洗衣机', 'washer-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 15, '电梯', 'elevator-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 16, '允许做饭', 'iscook-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 17, '允许带宠物', 'pet-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 18, '允许聚会', 'meet-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 19, '门禁系统', 'accesssys-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 20, '停车位', 'parkingspace-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 21, '有线网络', 'wirednetwork-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 22, '电视', 'tv-ico');
INSERT INTO `ihome_facility` VALUES (NULL, NULL, 23, '浴缸', 'jinzhi-ico');

-- ----------------------------
-- Table structure for ihome_house
-- ----------------------------
DROP TABLE IF EXISTS `ihome_house`;
CREATE TABLE `ihome_house`  (
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` int(11) NULL DEFAULT NULL,
  `address` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `room_count` int(11) NULL DEFAULT NULL,
  `acreage` int(11) NULL DEFAULT NULL,
  `unit` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `capacity` int(11) NULL DEFAULT NULL,
  `beds` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `deposit` int(11) NULL DEFAULT NULL,
  `min_days` int(11) NULL DEFAULT NULL,
  `max_days` int(11) NULL DEFAULT NULL,
  `order_count` int(11) NULL DEFAULT NULL,
  `index_image_url` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `area_id`(`area_id`) USING BTREE,
  CONSTRAINT `ihome_house_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `ihome_user` (`u_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ihome_house_ibfk_2` FOREIGN KEY (`area_id`) REFERENCES `ihome_area` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ihome_house
-- ----------------------------
INSERT INTO `ihome_house` VALUES ('2018-06-21 13:35:37', '2018-06-21 13:35:37', 1, 1, 1, '娱乐空间', 200, '成都', 2, 30, '两室', 2, '2.0x2.5', 300, 2, 0, 0, '/static/images/home01.jpg');
INSERT INTO `ihome_house` VALUES ('2018-06-21 14:11:37', '2018-06-21 14:11:37', 2, 1, 2, '老房子', 300, '成都', 2, 60, '2室', 3, '2', 500, 3, 0, 0, '/static/images/home02.jpg');
INSERT INTO `ihome_house` VALUES ('2018-06-21 14:16:42', '2018-06-21 14:16:42', 3, 1, 12, '宜居', 500, '成都', 4, 80, '3室', 5, '2.0x2.5', 400, 5, 0, 0, '/static/images/home03.jpg');
INSERT INTO `ihome_house` VALUES ('2018-06-21 14:20:51', '2018-06-21 14:20:51', 4, 1, 2, '998', 500, '成都', 2, 40, '2室', 2, '2', 200, 2, 0, 0, '/static/images/home01.jpg');
INSERT INTO `ihome_house` VALUES ('2018-06-21 14:31:46', '2018-06-21 14:31:46', 5, 1, 1, '911', 800, '成都', 4, 80, '3室', 3, '2', 400, 2, 0, 0, '/static/images/home02.jpg');
INSERT INTO `ihome_house` VALUES ('2018-06-21 14:36:16', '2018-06-21 14:36:16', 6, 1, 1, '568', 568, '大竹', 5, 60, '2室', 3, '2', 200, 2, 0, 0, '/static/images/home03.jpg');
INSERT INTO `ihome_house` VALUES ('2018-06-21 14:40:41', '2018-06-21 14:40:41', 7, 1, 1, '958', 600, '成都', 3, 30, '2室', 3, '2', 300, 3, 0, 0, '/static/images/home02.jpg');
INSERT INTO `ihome_house` VALUES ('2018-06-21 17:18:03', '2018-06-21 17:18:03', 8, 1, 14, '象牙塔', 300, '浦江路8号', 3, 120, '3室', 6, '双人床2x2.5', 2000, 30, 0, 0, '/static/images/home02.jpg');
INSERT INTO `ihome_house` VALUES ('2018-06-21 17:36:33', '2018-06-21 17:38:51', 9, 1, 9, '蓉城一家', 200, '南京路1号', 3, 45, '一室', 2, '双人床1.8x2.0', 1000, 5, 0, 0, '/static/images/home02.jpg');
INSERT INTO `ihome_house` VALUES ('2018-06-21 19:05:29', '2018-06-21 19:05:29', 10, 1, 1, '温馨小窝', 200, '成都', 3, 34, '2室', 3, '2', 300, 3, 0, 0, '/static/images/home03.jpg');
INSERT INTO `ihome_house` VALUES ('2018-06-21 19:10:56', '2018-06-21 19:12:55', 11, 1, 1, '温馨小窝', 200, '成都', 3, 34, '1室', 3, '2', 200, 2, 0, 0, '/static/UPLOAD_FILE\\4.jpg');
INSERT INTO `ihome_house` VALUES ('2018-06-21 20:54:51', '2018-06-21 20:55:04', 12, 1, 1, '小黑屋', 300, '双流', 2, 23, '2', 2, '2', 400, 3, 0, 0, '/static/UPLOAD_FILE\\1.jpg');
INSERT INTO `ihome_house` VALUES ('2018-06-22 11:47:53', '2018-06-22 11:48:02', 13, 1, 1, '黑房子', 200, '大竹', 5, 30, '三室', 4, '2', 500, 3, 0, 0, '/static\\UPLOAD_FILE\\1.jpg');
INSERT INTO `ihome_house` VALUES ('2018-06-22 11:51:45', '2018-06-22 11:51:54', 14, 1, 1, '小窝', 200, '大竹', 3, 40, '三室', 3, '2', 300, 4, 0, 0, '/static\\UPLOAD_FILE\\1.jpg');
INSERT INTO `ihome_house` VALUES ('2018-06-22 13:31:58', '2018-06-22 13:32:04', 15, 1, 1, '爱窝', 300, '成都', 2, 30, '3', 4, '2', 300, 4, 0, 0, '/static\\UPLOAD_FILE\\1.jpg');

-- ----------------------------
-- Table structure for ihome_house_facility
-- ----------------------------
DROP TABLE IF EXISTS `ihome_house_facility`;
CREATE TABLE `ihome_house_facility`  (
  `house_id` int(11) NOT NULL,
  `facility_id` int(11) NOT NULL,
  PRIMARY KEY (`house_id`, `facility_id`) USING BTREE,
  INDEX `facility_id`(`facility_id`) USING BTREE,
  CONSTRAINT `ihome_house_facility_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `ihome_house` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ihome_house_facility_ibfk_2` FOREIGN KEY (`facility_id`) REFERENCES `ihome_facility` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ihome_house_facility
-- ----------------------------
INSERT INTO `ihome_house_facility` VALUES (1, 1);
INSERT INTO `ihome_house_facility` VALUES (2, 1);
INSERT INTO `ihome_house_facility` VALUES (3, 1);
INSERT INTO `ihome_house_facility` VALUES (8, 1);
INSERT INTO `ihome_house_facility` VALUES (9, 1);
INSERT INTO `ihome_house_facility` VALUES (15, 1);
INSERT INTO `ihome_house_facility` VALUES (2, 2);
INSERT INTO `ihome_house_facility` VALUES (3, 2);
INSERT INTO `ihome_house_facility` VALUES (4, 2);
INSERT INTO `ihome_house_facility` VALUES (6, 2);
INSERT INTO `ihome_house_facility` VALUES (7, 2);
INSERT INTO `ihome_house_facility` VALUES (8, 2);
INSERT INTO `ihome_house_facility` VALUES (10, 2);
INSERT INTO `ihome_house_facility` VALUES (11, 2);
INSERT INTO `ihome_house_facility` VALUES (12, 2);
INSERT INTO `ihome_house_facility` VALUES (13, 2);
INSERT INTO `ihome_house_facility` VALUES (14, 2);
INSERT INTO `ihome_house_facility` VALUES (15, 2);
INSERT INTO `ihome_house_facility` VALUES (8, 3);
INSERT INTO `ihome_house_facility` VALUES (9, 3);
INSERT INTO `ihome_house_facility` VALUES (1, 4);
INSERT INTO `ihome_house_facility` VALUES (6, 4);
INSERT INTO `ihome_house_facility` VALUES (8, 4);
INSERT INTO `ihome_house_facility` VALUES (10, 4);
INSERT INTO `ihome_house_facility` VALUES (13, 4);
INSERT INTO `ihome_house_facility` VALUES (14, 4);
INSERT INTO `ihome_house_facility` VALUES (4, 5);
INSERT INTO `ihome_house_facility` VALUES (8, 5);
INSERT INTO `ihome_house_facility` VALUES (9, 5);
INSERT INTO `ihome_house_facility` VALUES (15, 5);
INSERT INTO `ihome_house_facility` VALUES (1, 6);
INSERT INTO `ihome_house_facility` VALUES (6, 6);
INSERT INTO `ihome_house_facility` VALUES (7, 6);
INSERT INTO `ihome_house_facility` VALUES (8, 6);
INSERT INTO `ihome_house_facility` VALUES (9, 6);
INSERT INTO `ihome_house_facility` VALUES (10, 6);
INSERT INTO `ihome_house_facility` VALUES (11, 6);
INSERT INTO `ihome_house_facility` VALUES (12, 6);
INSERT INTO `ihome_house_facility` VALUES (13, 6);
INSERT INTO `ihome_house_facility` VALUES (1, 8);
INSERT INTO `ihome_house_facility` VALUES (2, 8);
INSERT INTO `ihome_house_facility` VALUES (5, 8);
INSERT INTO `ihome_house_facility` VALUES (2, 9);
INSERT INTO `ihome_house_facility` VALUES (4, 9);
INSERT INTO `ihome_house_facility` VALUES (5, 9);
INSERT INTO `ihome_house_facility` VALUES (13, 9);
INSERT INTO `ihome_house_facility` VALUES (3, 10);
INSERT INTO `ihome_house_facility` VALUES (4, 10);
INSERT INTO `ihome_house_facility` VALUES (7, 10);
INSERT INTO `ihome_house_facility` VALUES (11, 10);
INSERT INTO `ihome_house_facility` VALUES (4, 11);
INSERT INTO `ihome_house_facility` VALUES (5, 11);
INSERT INTO `ihome_house_facility` VALUES (12, 11);
INSERT INTO `ihome_house_facility` VALUES (13, 11);
INSERT INTO `ihome_house_facility` VALUES (4, 12);
INSERT INTO `ihome_house_facility` VALUES (7, 12);
INSERT INTO `ihome_house_facility` VALUES (12, 12);
INSERT INTO `ihome_house_facility` VALUES (4, 13);
INSERT INTO `ihome_house_facility` VALUES (5, 13);
INSERT INTO `ihome_house_facility` VALUES (6, 13);
INSERT INTO `ihome_house_facility` VALUES (13, 13);
INSERT INTO `ihome_house_facility` VALUES (4, 14);
INSERT INTO `ihome_house_facility` VALUES (7, 14);
INSERT INTO `ihome_house_facility` VALUES (8, 14);
INSERT INTO `ihome_house_facility` VALUES (13, 14);
INSERT INTO `ihome_house_facility` VALUES (8, 15);
INSERT INTO `ihome_house_facility` VALUES (13, 15);
INSERT INTO `ihome_house_facility` VALUES (5, 16);
INSERT INTO `ihome_house_facility` VALUES (8, 16);
INSERT INTO `ihome_house_facility` VALUES (9, 16);
INSERT INTO `ihome_house_facility` VALUES (13, 16);
INSERT INTO `ihome_house_facility` VALUES (8, 17);
INSERT INTO `ihome_house_facility` VALUES (13, 17);
INSERT INTO `ihome_house_facility` VALUES (6, 18);
INSERT INTO `ihome_house_facility` VALUES (8, 18);
INSERT INTO `ihome_house_facility` VALUES (13, 18);
INSERT INTO `ihome_house_facility` VALUES (2, 19);
INSERT INTO `ihome_house_facility` VALUES (8, 19);
INSERT INTO `ihome_house_facility` VALUES (14, 19);
INSERT INTO `ihome_house_facility` VALUES (8, 20);
INSERT INTO `ihome_house_facility` VALUES (8, 22);
INSERT INTO `ihome_house_facility` VALUES (8, 23);

-- ----------------------------
-- Table structure for ihome_house_image
-- ----------------------------
DROP TABLE IF EXISTS `ihome_house_image`;
CREATE TABLE `ihome_house_image`  (
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `house_id` int(11) NOT NULL,
  `url` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `house_id`(`house_id`) USING BTREE,
  CONSTRAINT `ihome_house_image_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `ihome_house` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ihome_house_image
-- ----------------------------
INSERT INTO `ihome_house_image` VALUES ('2018-06-21 14:32:01', '2018-06-21 14:32:01', 1, 5, '\\static\\UPLOAD_FILE\\1.jpg');
INSERT INTO `ihome_house_image` VALUES ('2018-06-21 14:36:27', '2018-06-21 14:36:27', 2, 6, '\\static\\UPLOAD_FILE\\1.jpg');
INSERT INTO `ihome_house_image` VALUES ('2018-06-21 14:40:46', '2018-06-21 14:40:46', 3, 7, '\\static\\UPLOAD_FILE\\1.jpg');
INSERT INTO `ihome_house_image` VALUES ('2018-06-21 20:55:03', '2018-06-21 20:55:04', 6, 12, '\\static\\UPLOAD_FILE\\m.xxxiao.com_36c5f34ae18312e8e70df822a73558bd-683x1024.jpg');
INSERT INTO `ihome_house_image` VALUES ('2018-06-22 11:51:53', '2018-06-22 11:51:54', 8, 14, '/static\\UPLOAD_FILE\\m.xxxiao.com_8e37f60dd5048495e63eeb5dd4aa88a8-683x1024.jpg');
INSERT INTO `ihome_house_image` VALUES ('2018-06-22 13:32:04', '2018-06-22 13:32:04', 9, 15, '/static\\UPLOAD_FILE\\1.jpg');
INSERT INTO `ihome_house_image` VALUES ('2018-06-22 13:32:04', '2018-06-22 13:32:04', 10, 15, '/static\\UPLOAD_FILE\\4.jpg');
INSERT INTO `ihome_house_image` VALUES ('2018-06-22 13:32:04', '2018-06-22 13:32:04', 11, 15, '/static\\UPLOAD_FILE\\m.xxxiao.com_8e37f60dd5048495e63eeb5dd4aa88a8-683x1024.jpg');

-- ----------------------------
-- Table structure for ihome_order
-- ----------------------------
DROP TABLE IF EXISTS `ihome_order`;
CREATE TABLE `ihome_order`  (
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `house_id` int(11) NOT NULL,
  `begin_date` datetime(0) NULL,
  `end_date` datetime(0) NULL,
  `days` int(11) NOT NULL,
  `house_price` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `status` enum('WAIT_ACCEPT','WAIT_PAYMENT','PAID','WAIT_COMMENT','COMPLETE','CANCELED','REJECTED') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `comment` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `house_id`(`house_id`) USING BTREE,
  INDEX `ix_ihome_order_status`(`status`) USING BTREE,
  CONSTRAINT `ihome_order_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `ihome_user` (`u_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ihome_order_ibfk_2` FOREIGN KEY (`house_id`) REFERENCES `ihome_house` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ihome_user
-- ----------------------------
DROP TABLE IF EXISTS `ihome_user`;
CREATE TABLE `ihome_user`  (
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `u_id` int(11) NOT NULL AUTO_INCREMENT,
  `u_tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_pwd` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `u_avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ID_NAME` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ID_CARD` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`u_id`) USING BTREE,
  UNIQUE INDEX `u_tel`(`u_tel`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ihome_user
-- ----------------------------
INSERT INTO `ihome_user` VALUES ('2018-06-20 15:58:10', '2018-06-20 16:22:34', 1, '18989060014', 'pbkdf2:sha256:50000$JykMeYaC$350a55fc4ce4403af11c88ec68413bba793aaf2e35114bb2bfe123db13324ec1', '猪猪', 'static\\UPLOAD_FILE\\1.jpg', '小白', '511223199808091123');

SET FOREIGN_KEY_CHECKS = 1;
