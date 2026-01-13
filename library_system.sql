/*
 Navicat Premium Dump SQL

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80043 (8.0.43)
 Source Host           : localhost:3306
 Source Schema         : library_system

 Target Server Type    : MySQL
 Target Server Version : 80043 (8.0.43)
 File Encoding         : 65001

 Date: 13/01/2026 17:14:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `book_id` int NOT NULL AUTO_INCREMENT COMMENT '图书ID',
  `isbn` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ISBN编号',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '书名',
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '作者',
  `publisher` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出版社',
  `publish_date` date NULL DEFAULT NULL COMMENT '出版日期',
  `category_id` int NOT NULL COMMENT '分类ID',
  `total_copies` int NOT NULL DEFAULT 1 COMMENT '总库存量',
  `available_copies` int NOT NULL DEFAULT 1 COMMENT '可借阅数量',
  `borrow_times` int NOT NULL DEFAULT 0 COMMENT '被借阅次数',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '馆藏位置',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图书描述',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1-可借，0-不可借',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入库时间',
  `updated_at` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`book_id`) USING BTREE,
  UNIQUE INDEX `idx_isbn`(`isbn` ASC) USING BTREE,
  INDEX `idx_category`(`category_id` ASC) USING BTREE,
  INDEX `idx_title`(`title` ASC) USING BTREE,
  INDEX `idx_author`(`author` ASC) USING BTREE,
  INDEX `idx_publisher`(`publisher` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_book_title`(`title` ASC) USING BTREE,
  INDEX `idx_book_author`(`author` ASC) USING BTREE,
  INDEX `idx_book_publisher`(`publisher` ASC) USING BTREE,
  CONSTRAINT `fk_book_category` FOREIGN KEY (`category_id`) REFERENCES `book_category` (`category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (1, '9787020002207', '三国演义', '罗贯中', '人民文学出版社', '1990-08-01', 1, 10, 10, 26, 39.80, 'A区-文学架-01', '中国古典四大名著之一', 1, '2024-01-10 09:00:00', '2026-01-13 12:40:27');
INSERT INTO `book` VALUES (2, '9787111213826', 'Java编程思想', 'Bruce Eckel', '机械工业出版社', '2007-06-01', 4, 5, 5, 33, 108.00, 'B区-科技架-03', 'Java编程经典著作', 1, '2024-02-15 10:30:00', '2026-01-13 12:40:27');
INSERT INTO `book` VALUES (3, '9787530216854', '活着', '余华', '作家出版社', '2012-08-01', 5, 8, 8, 19, 28.00, 'A区-文学架-02', '余华代表作', 1, '2024-03-20 14:20:00', '2026-01-13 12:40:27');
INSERT INTO `book` VALUES (4, '9787544253994', '白夜行', '东野圭吾', '南海出版公司', '2013-01-01', 6, 6, 6, 17, 39.50, 'A区-文学架-03', '东野圭吾代表作', 1, '2024-04-05 11:10:00', '2026-01-13 12:40:27');
INSERT INTO `book` VALUES (5, '9787544270878', '解忧杂货店', '东野圭吾', '南海出版公司', '2014-05-01', 6, 7, 7, 21, 39.50, 'A区-文学架-03', '东野圭吾温暖治愈小说', 1, '2024-05-12 16:30:00', '2026-01-13 12:40:27');
INSERT INTO `book` VALUES (6, '9787540482571', 'Python编程：从入门到实践', 'Eric Matthes', '人民邮电出版社', '2020-01-01', 4, 8, 8, 22, 89.00, 'B区-科技架-04', 'Python学习经典', 1, '2024-06-18 09:45:00', '2026-01-13 12:40:27');
INSERT INTO `book` VALUES (7, 'N/A', '葫芦娃', '上海美术电影制片厂', '少年儿童出版社', '1986-01-01', 8, 0, 0, 45, 15.00, 'C区-少儿架-01', '经典动画故事', 0, '2024-07-22 10:20:00', '2026-01-13 12:34:15');
INSERT INTO `book` VALUES (8, '9787506365437', '平凡的世界', '路遥', '北京十月文艺出版社', '2012-03-01', 1, 8, 8, 0, 88.00, 'A区-文学架-04', '中国当代文学经典之作，获得茅盾文学奖', 1, '2026-01-13 12:34:15', '2026-01-13 12:34:15');

-- ----------------------------
-- Table structure for book_category
-- ----------------------------
DROP TABLE IF EXISTS `book_category`;
CREATE TABLE `book_category`  (
  `category_id` int NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类名称',
  `parent_id` int NULL DEFAULT 0 COMMENT '父分类ID',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类描述',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`category_id`) USING BTREE,
  UNIQUE INDEX `idx_category_name`(`category_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of book_category
-- ----------------------------
INSERT INTO `book_category` VALUES (1, '文学', 0, '文学作品类', '2024-01-01 00:00:00');
INSERT INTO `book_category` VALUES (2, '历史', 0, '历史类书籍', '2024-01-01 00:00:00');
INSERT INTO `book_category` VALUES (3, '科技', 0, '科学技术类', '2024-01-01 00:00:00');
INSERT INTO `book_category` VALUES (4, '编程', 3, '计算机编程', '2024-01-01 00:00:00');
INSERT INTO `book_category` VALUES (5, '小说', 1, '小说类', '2024-01-01 00:00:00');
INSERT INTO `book_category` VALUES (6, '悬疑', 5, '悬疑小说', '2024-01-01 00:00:00');
INSERT INTO `book_category` VALUES (7, '少儿', 0, '少儿读物', '2024-01-01 00:00:00');
INSERT INTO `book_category` VALUES (8, '漫画', 7, '少儿漫画', '2024-01-01 00:00:00');
INSERT INTO `book_category` VALUES (9, '人工智能', 3, '包含深度学习、机器学习等', '2026-01-13 12:35:44');
INSERT INTO `book_category` VALUES (10, '科幻小说', 5, '科幻类小说', '2026-01-13 12:35:44');

-- ----------------------------
-- Table structure for borrow_record
-- ----------------------------
DROP TABLE IF EXISTS `borrow_record`;
CREATE TABLE `borrow_record`  (
  `record_id` int NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `reader_id` int NOT NULL COMMENT '读者ID',
  `book_id` int NOT NULL COMMENT '图书ID',
  `borrow_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '借阅时间',
  `due_time` datetime NOT NULL COMMENT '应还时间',
  `return_time` datetime NULL DEFAULT NULL COMMENT '实际归还时间',
  `borrow_staff_id` int NULL DEFAULT NULL COMMENT '借出操作员ID',
  `return_staff_id` int NULL DEFAULT NULL COMMENT '归还操作员ID',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1-借阅中，2-已归还，3-逾期',
  `fine_amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '罚款金额',
  `paid_fine` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '已缴罚款',
  `notes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`record_id`) USING BTREE,
  INDEX `idx_reader`(`reader_id` ASC) USING BTREE,
  INDEX `idx_book`(`book_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_borrow_time`(`borrow_time` ASC) USING BTREE,
  INDEX `idx_due_time`(`due_time` ASC) USING BTREE,
  INDEX `fk_borrow_staff`(`borrow_staff_id` ASC) USING BTREE,
  INDEX `fk_return_staff`(`return_staff_id` ASC) USING BTREE,
  INDEX `idx_borrow_record_reader`(`reader_id` ASC, `status` ASC) USING BTREE,
  INDEX `idx_borrow_record_due`(`due_time` ASC, `status` ASC) USING BTREE,
  CONSTRAINT `fk_borrow_book` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_borrow_reader` FOREIGN KEY (`reader_id`) REFERENCES `reader` (`reader_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_borrow_staff` FOREIGN KEY (`borrow_staff_id`) REFERENCES `library_staff` (`staff_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_return_staff` FOREIGN KEY (`return_staff_id`) REFERENCES `library_staff` (`staff_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of borrow_record
-- ----------------------------
INSERT INTO `borrow_record` VALUES (1, 1, 1, '2024-08-10 10:00:00', '2024-09-09 10:00:00', '2026-01-13 12:31:29', 1, 1, 2, 245.50, 0.00, NULL);
INSERT INTO `borrow_record` VALUES (2, 1, 2, '2024-08-15 14:30:00', '2024-09-14 14:30:00', NULL, 3, NULL, 1, 0.00, 0.00, NULL);
INSERT INTO `borrow_record` VALUES (3, 1, 3, '2024-07-20 09:15:00', '2024-08-19 09:15:00', '2024-08-18 16:20:00', 1, 1, 2, 0.00, 0.00, '按时归还');
INSERT INTO `borrow_record` VALUES (4, 2, 4, '2024-08-18 11:00:00', '2024-09-17 11:00:00', NULL, 1, NULL, 1, 0.00, 0.00, NULL);
INSERT INTO `borrow_record` VALUES (5, 2, 5, '2024-07-25 15:45:00', '2024-08-24 15:45:00', '2024-08-23 10:30:00', 3, 3, 2, 0.00, 0.00, '按时归还');
INSERT INTO `borrow_record` VALUES (6, 5, 6, '2024-08-12 09:30:00', '2024-09-11 09:30:00', NULL, 1, NULL, 1, 0.00, 0.00, NULL);
INSERT INTO `borrow_record` VALUES (7, 5, 1, '2024-08-20 13:20:00', '2024-09-19 13:20:00', NULL, 1, NULL, 1, 0.00, 0.00, NULL);
INSERT INTO `borrow_record` VALUES (8, 3, 2, '2024-07-30 10:45:00', '2024-08-29 10:45:00', '2024-08-28 14:10:00', 3, 1, 2, 0.00, 0.00, '按时归还');
INSERT INTO `borrow_record` VALUES (9, 1, 4, '2026-01-13 12:30:53', '2026-02-12 12:30:53', NULL, 1, NULL, 1, 0.00, 0.00, NULL);
INSERT INTO `borrow_record` VALUES (10, 4, 1, '2026-01-13 12:37:58', '2026-02-12 12:37:58', NULL, 1, NULL, 1, 0.00, 0.00, NULL);
INSERT INTO `borrow_record` VALUES (11, 4, 2, '2026-01-13 12:37:58', '2026-02-12 12:37:58', NULL, 1, NULL, 1, 0.00, 0.00, NULL);
INSERT INTO `borrow_record` VALUES (12, 4, 3, '2026-01-13 12:37:58', '2026-02-12 12:37:58', NULL, 1, NULL, 1, 0.00, 0.00, NULL);
INSERT INTO `borrow_record` VALUES (13, 4, 4, '2026-01-13 12:37:58', '2026-02-12 12:37:58', NULL, 1, NULL, 1, 0.00, 0.00, NULL);
INSERT INTO `borrow_record` VALUES (14, 4, 5, '2026-01-13 12:37:58', '2026-02-12 12:37:58', NULL, 1, NULL, 1, 0.00, 0.00, NULL);
INSERT INTO `borrow_record` VALUES (15, 4, 6, '2024-07-01 10:00:00', '2024-07-31 10:00:00', NULL, 1, NULL, 3, 0.00, 0.00, NULL);

-- ----------------------------
-- Table structure for fine_record
-- ----------------------------
DROP TABLE IF EXISTS `fine_record`;
CREATE TABLE `fine_record`  (
  `fine_id` int NOT NULL AUTO_INCREMENT COMMENT '罚款ID',
  `record_id` int NOT NULL COMMENT '借阅记录ID',
  `reader_id` int NOT NULL COMMENT '读者ID',
  `amount` decimal(10, 2) NOT NULL COMMENT '罚款金额',
  `reason` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '罚款原因（逾期/损坏/丢失）',
  `payment_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '支付状态：0-未支付，1-已支付',
  `payment_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `staff_id` int NULL DEFAULT NULL COMMENT '操作员ID',
  PRIMARY KEY (`fine_id`) USING BTREE,
  INDEX `idx_record`(`record_id` ASC) USING BTREE,
  INDEX `idx_reader`(`reader_id` ASC) USING BTREE,
  INDEX `idx_payment_status`(`payment_status` ASC) USING BTREE,
  INDEX `fk_fine_staff`(`staff_id` ASC) USING BTREE,
  CONSTRAINT `fk_fine_reader` FOREIGN KEY (`reader_id`) REFERENCES `reader` (`reader_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_fine_record` FOREIGN KEY (`record_id`) REFERENCES `borrow_record` (`record_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_fine_staff` FOREIGN KEY (`staff_id`) REFERENCES `library_staff` (`staff_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of fine_record
-- ----------------------------
INSERT INTO `fine_record` VALUES (1, 8, 3, 2.00, '逾期3天', 1, '2026-01-13 12:32:06', '2024-08-28 14:10:00', 1);
INSERT INTO `fine_record` VALUES (2, 1, 1, 245.50, '逾期491天', 0, NULL, '2026-01-13 12:31:29', 1);

-- ----------------------------
-- Table structure for income_record
-- ----------------------------
DROP TABLE IF EXISTS `income_record`;
CREATE TABLE `income_record`  (
  `income_id` int NOT NULL AUTO_INCREMENT COMMENT '收入ID',
  `reader_id` int NULL DEFAULT NULL COMMENT '读者ID',
  `amount` decimal(10, 2) NOT NULL COMMENT '收入金额',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收入类型（罚款/押金/其他）',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收入说明',
  `payment_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '缴费时间',
  `staff_id` int NULL DEFAULT NULL COMMENT '操作员ID',
  PRIMARY KEY (`income_id`) USING BTREE,
  INDEX `idx_reader`(`reader_id` ASC) USING BTREE,
  INDEX `idx_type`(`type` ASC) USING BTREE,
  INDEX `idx_payment_time`(`payment_time` ASC) USING BTREE,
  INDEX `fk_income_staff`(`staff_id` ASC) USING BTREE,
  CONSTRAINT `fk_income_reader` FOREIGN KEY (`reader_id`) REFERENCES `reader` (`reader_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_income_staff` FOREIGN KEY (`staff_id`) REFERENCES `library_staff` (`staff_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of income_record
-- ----------------------------
INSERT INTO `income_record` VALUES (1, 3, 2.00, '罚款', '逾期罚款', '2024-08-28 14:30:00', 1);
INSERT INTO `income_record` VALUES (2, 3, 2.00, '罚款', '逾期罚款-逾期3天', '2026-01-13 12:32:06', 1);

-- ----------------------------
-- Table structure for library_staff
-- ----------------------------
DROP TABLE IF EXISTS `library_staff`;
CREATE TABLE `library_staff`  (
  `staff_id` int NOT NULL AUTO_INCREMENT COMMENT '员工ID',
  `staff_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '员工编号',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `position` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '职位（前台/管理员）',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '工作状态：1-在职，0-离职',
  `permissions` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限设置',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`staff_id`) USING BTREE,
  UNIQUE INDEX `idx_staff_no`(`staff_no` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of library_staff
-- ----------------------------
INSERT INTO `library_staff` VALUES (1, 'STAFF001', '张服务', '4QrcOUm6Wau+VuBX8g+IPg==', '13800138111', '前台服务', 1, 'borrow,return,fee', '2024-08-24 09:00:00');
INSERT INTO `library_staff` VALUES (2, 'STAFF002', '李管理', '4QrcOUm6Wau+VuBX8g+IPg==', '13800138002', '高级管理员', 1, 'all', '2024-08-24 09:00:00');
INSERT INTO `library_staff` VALUES (3, 'STAFF003', '王助理', '4QrcOUm6Wau+VuBX8g+IPg==', '13800138003', '前台助理', 1, 'borrow,return,fee,query', '2024-08-24 09:00:00');

-- ----------------------------
-- Table structure for reader
-- ----------------------------
DROP TABLE IF EXISTS `reader`;
CREATE TABLE `reader`  (
  `reader_id` int NOT NULL AUTO_INCREMENT COMMENT '读者ID',
  `reader_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '读者证号',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `id_card` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `borrow_limit` int NOT NULL DEFAULT 5 COMMENT '最大借阅数量',
  `borrow_days` int NOT NULL DEFAULT 30 COMMENT '最长借阅天数',
  `total_borrowed` int NOT NULL DEFAULT 0 COMMENT '总借阅次数',
  `current_borrowed` int NOT NULL DEFAULT 0 COMMENT '当前借阅数量',
  `account_status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '账户状态：1-正常，0-禁用',
  `registration_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `last_login_time` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  PRIMARY KEY (`reader_id`) USING BTREE,
  UNIQUE INDEX `idx_reader_no`(`reader_no` ASC) USING BTREE,
  UNIQUE INDEX `idx_id_card`(`id_card` ASC) USING BTREE,
  INDEX `idx_phone`(`phone` ASC) USING BTREE,
  INDEX `idx_reader_name`(`name` ASC) USING BTREE,
  INDEX `idx_reader_phone`(`phone` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of reader
-- ----------------------------
INSERT INTO `reader` VALUES (1, 'R2024001', '张三', '4QrcOUm6Wau+VuBX8g+IPg==', '110101199001011234', '13800138009', 'zhangsan_new@email.com', '北京市海淀区新地址', 8, 45, 13, 0, 1, '2024-01-15 10:00:00', '2024-08-24 08:30:00');
INSERT INTO `reader` VALUES (2, 'R2024002', '李四', '4QrcOUm6Wau+VuBX8g+IPg==', '110101199002021235', '13800138005', 'lisi@email.com', '北京市朝阳区', 5, 30, 8, 0, 1, '2024-02-20 14:30:00', '2024-08-24 09:15:00');
INSERT INTO `reader` VALUES (3, 'R2024003', '王五', '4QrcOUm6Wau+VuBX8g+IPg==', '110101199003031236', '13800138006', 'wangwu@email.com', '北京市东城区', 5, 30, 3, 0, 1, '2024-03-10 09:00:00', '2024-08-23 16:45:00');
INSERT INTO `reader` VALUES (4, 'R2024004', '赵六', '4QrcOUm6Wau+VuBX8g+IPg==', '110101199004041237', '13800138007', 'zhaoliu@email.com', '北京市西城区', 5, 30, 5, 0, 1, '2024-04-05 11:20:00', '2024-08-22 10:10:00');
INSERT INTO `reader` VALUES (5, 'R2024005', '孙七', '4QrcOUm6Wau+VuBX8g+IPg==', '110101199005051238', '13800138008', 'sunqi@email.com', '北京市丰台区', 5, 30, 5, 0, 1, '2024-05-12 15:40:00', '2024-08-24 10:30:00');

-- ----------------------------
-- Table structure for system_log
-- ----------------------------
DROP TABLE IF EXISTS `system_log`;
CREATE TABLE `system_log`  (
  `log_id` int NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户类型（staff/reader）',
  `user_id` int NOT NULL COMMENT '用户ID',
  `action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作类型',
  `target_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作对象类型',
  `target_id` int NULL DEFAULT NULL COMMENT '操作对象ID',
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '操作详情',
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `idx_user`(`user_type` ASC, `user_id` ASC) USING BTREE,
  INDEX `idx_action`(`action` ASC) USING BTREE,
  INDEX `idx_created_at`(`created_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of system_log
-- ----------------------------
INSERT INTO `system_log` VALUES (1, 'staff', 1, 'borrow_book', 'book', 4, '读者ID:1 借阅图书ID:4', NULL, '2026-01-13 12:30:53');
INSERT INTO `system_log` VALUES (2, 'staff', 1, 'return_book', 'book', 1, '记录ID:1 产生罚款:245.50', NULL, '2026-01-13 12:31:29');
INSERT INTO `system_log` VALUES (3, 'staff', 1, 'borrow_book', 'book', 1, '读者ID:4 借阅图书ID:1', NULL, '2026-01-13 12:37:58');
INSERT INTO `system_log` VALUES (4, 'staff', 1, 'borrow_book', 'book', 2, '读者ID:4 借阅图书ID:2', NULL, '2026-01-13 12:37:58');
INSERT INTO `system_log` VALUES (5, 'staff', 1, 'borrow_book', 'book', 3, '读者ID:4 借阅图书ID:3', NULL, '2026-01-13 12:37:58');
INSERT INTO `system_log` VALUES (6, 'staff', 1, 'borrow_book', 'book', 4, '读者ID:4 借阅图书ID:4', NULL, '2026-01-13 12:37:58');
INSERT INTO `system_log` VALUES (7, 'staff', 1, 'borrow_book', 'book', 5, '读者ID:4 借阅图书ID:5', NULL, '2026-01-13 12:37:58');

-- ----------------------------
-- View structure for v_book_search
-- ----------------------------
DROP VIEW IF EXISTS `v_book_search`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_book_search` AS select `b`.`book_id` AS `book_id`,`b`.`isbn` AS `isbn`,`b`.`title` AS `title`,`b`.`author` AS `author`,`b`.`publisher` AS `publisher`,`b`.`publish_date` AS `publish_date`,`c`.`category_name` AS `category_name`,`b`.`total_copies` AS `total_copies`,`b`.`available_copies` AS `available_copies`,`b`.`borrow_times` AS `borrow_times`,`b`.`price` AS `price`,`b`.`location` AS `location`,`b`.`status` AS `status`,`b`.`description` AS `description` from (`book` `b` join `book_category` `c` on((`b`.`category_id` = `c`.`category_id`)));

-- ----------------------------
-- View structure for v_library_income
-- ----------------------------
DROP VIEW IF EXISTS `v_library_income`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_library_income` AS select cast(`income_record`.`payment_time` as date) AS `income_date`,`income_record`.`type` AS `type`,count(0) AS `transaction_count`,sum(`income_record`.`amount`) AS `total_amount` from `income_record` group by cast(`income_record`.`payment_time` as date),`income_record`.`type` order by `income_date` desc;

-- ----------------------------
-- View structure for v_popular_books
-- ----------------------------
DROP VIEW IF EXISTS `v_popular_books`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_popular_books` AS select `b`.`book_id` AS `book_id`,`b`.`title` AS `title`,`b`.`author` AS `author`,`b`.`publisher` AS `publisher`,`c`.`category_name` AS `category_name`,`b`.`borrow_times` AS `borrow_times`,`b`.`total_copies` AS `total_copies`,`b`.`available_copies` AS `available_copies`,round((`b`.`borrow_times` / greatest(`b`.`total_copies`,1)),2) AS `utilization_rate` from (`book` `b` join `book_category` `c` on((`b`.`category_id` = `c`.`category_id`))) where (`b`.`total_copies` > 0) order by `b`.`borrow_times` desc,round((`b`.`borrow_times` / greatest(`b`.`total_copies`,1)),2) desc;

-- ----------------------------
-- View structure for v_reader_borrow_statistics
-- ----------------------------
DROP VIEW IF EXISTS `v_reader_borrow_statistics`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_reader_borrow_statistics` AS select `r`.`reader_id` AS `reader_id`,`r`.`reader_no` AS `reader_no`,`r`.`name` AS `name`,`r`.`phone` AS `phone`,`r`.`total_borrowed` AS `total_borrowed`,`r`.`current_borrowed` AS `current_borrowed`,count((case when (`br`.`status` = 1) then 1 end)) AS `active_borrows`,count((case when (`br`.`status` = 2) then 1 end)) AS `returned_books`,count((case when (`br`.`status` = 3) then 1 end)) AS `overdue_books`,coalesce(sum(`fr`.`amount`),0) AS `total_fines`,coalesce(sum((case when (`fr`.`payment_status` = 0) then `fr`.`amount` else 0 end)),0) AS `unpaid_fines` from ((`reader` `r` left join `borrow_record` `br` on((`r`.`reader_id` = `br`.`reader_id`))) left join `fine_record` `fr` on(((`r`.`reader_id` = `fr`.`reader_id`) and (`fr`.`payment_status` = 0)))) group by `r`.`reader_id`,`r`.`reader_no`,`r`.`name`,`r`.`phone`,`r`.`total_borrowed`,`r`.`current_borrowed`;

-- ----------------------------
-- View structure for v_zero_stock_books
-- ----------------------------
DROP VIEW IF EXISTS `v_zero_stock_books`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_zero_stock_books` AS select `b`.`book_id` AS `book_id`,`b`.`isbn` AS `isbn`,`b`.`title` AS `title`,`b`.`author` AS `author`,`b`.`publisher` AS `publisher`,`c`.`category_name` AS `category_name`,`b`.`total_copies` AS `total_copies`,`b`.`available_copies` AS `available_copies`,`b`.`borrow_times` AS `borrow_times`,`b`.`status` AS `status`,`b`.`updated_at` AS `updated_at` from (`book` `b` join `book_category` `c` on((`b`.`category_id` = `c`.`category_id`))) where ((`b`.`available_copies` = 0) or (`b`.`status` = 0)) order by `b`.`borrow_times` desc;

-- ----------------------------
-- Procedure structure for sp_borrow_book
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_borrow_book`;
delimiter ;;
CREATE PROCEDURE `sp_borrow_book`(IN p_reader_id INT,
    IN p_book_id INT,
    IN p_staff_id INT,
    IN p_borrow_days INT,
    OUT p_result INT,
    OUT p_message VARCHAR(255))
BEGIN
    DECLARE v_available INT;
    DECLARE v_borrow_limit INT;
    DECLARE v_current_borrowed INT;
    DECLARE v_reader_status INT;
    DECLARE v_book_status INT;
    -- 检查读者状态
    SELECT account_status, borrow_limit, current_borrowed 
    INTO v_reader_status, v_borrow_limit, v_current_borrowed
    FROM reader WHERE reader_id = p_reader_id;
    -- 检查图书状态
    SELECT available_copies, status 
    INTO v_available, v_book_status
    FROM book WHERE book_id = p_book_id;
    
    IF v_reader_status = 0 THEN
        SET p_result = 0;
        SET p_message = '读者账户已被禁用';
    ELSEIF v_current_borrowed >= v_borrow_limit THEN
        SET p_result = 0;
        SET p_message = '已达到最大借阅数量限制';
    ELSEIF v_available <= 0 THEN
        SET p_result = 0;
        SET p_message = '图书库存不足';
    ELSEIF v_book_status = 0 THEN
        SET p_result = 0;
        SET p_message = '图书暂不可借';
    ELSE
        
        START TRANSACTION;
        -- 插入借阅记录
        INSERT INTO borrow_record (
            reader_id, book_id, borrow_staff_id, due_time, status
        ) VALUES (
            p_reader_id, p_book_id, p_staff_id, 
            DATE_ADD(NOW(), INTERVAL p_borrow_days DAY), 1
        );
        -- 更新图书库存和借阅次数
        UPDATE book 
        SET available_copies = available_copies - 1,
            borrow_times = borrow_times + 1,
            updated_at = NOW()
        WHERE book_id = p_book_id;
        -- 更新读者借阅信息
        UPDATE reader 
        SET current_borrowed = current_borrowed + 1,
            total_borrowed = total_borrowed + 1
        WHERE reader_id = p_reader_id;
        -- 记录日志
        INSERT INTO system_log (user_type, user_id, action, target_type, target_id, details)
        VALUES ('staff', p_staff_id, 'borrow_book', 'book', p_book_id, 
                CONCAT('读者ID:', p_reader_id, ' 借阅图书ID:', p_book_id));
        
        COMMIT;
        
        SET p_result = 1;
        SET p_message = '借阅成功';
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_return_book
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_return_book`;
delimiter ;;
CREATE PROCEDURE `sp_return_book`(IN p_record_id INT,
    IN p_staff_id INT,
    OUT p_result INT,
    OUT p_message VARCHAR(255),
    OUT p_fine_amount DECIMAL(10,2))
BEGIN
    DECLARE v_status INT;
    DECLARE v_book_id INT;
    DECLARE v_reader_id INT;
    DECLARE v_due_time DATETIME;
    DECLARE v_overdue_days INT;
    DECLARE v_fine_rate DECIMAL(10,2) DEFAULT 0.50; -- 罚款
    -- 获取借阅记录信息
    SELECT status, book_id, reader_id, due_time
    INTO v_status, v_book_id, v_reader_id, v_due_time
    FROM borrow_record 
    WHERE record_id = p_record_id;
    
    IF v_status = 2 THEN
        SET p_result = 0;
        SET p_message = '该图书已归还';
        SET p_fine_amount = 0;
    ELSEIF v_status = 1 THEN
        SET v_overdue_days = GREATEST(0, DATEDIFF(NOW(), v_due_time));
        SET p_fine_amount = v_overdue_days * v_fine_rate;
        
        START TRANSACTION;
        
        -- 更新借阅记录
        UPDATE borrow_record 
        SET return_time = NOW(),
            return_staff_id = p_staff_id,
            status = 2,
            fine_amount = p_fine_amount
        WHERE record_id = p_record_id;
        
        -- 更新图书库存
        UPDATE book 
        SET available_copies = available_copies + 1,
            updated_at = NOW()
        WHERE book_id = v_book_id;
        
        -- 更新读者借阅信息
        UPDATE reader 
        SET current_borrowed = current_borrowed - 1
        WHERE reader_id = v_reader_id;
        
        -- 如果有罚款，记录罚款信息
        IF p_fine_amount > 0 THEN
            INSERT INTO fine_record (
                record_id, reader_id, amount, reason, payment_status, staff_id
            ) VALUES (
                p_record_id, v_reader_id, p_fine_amount, 
                CONCAT('逾期', v_overdue_days, '天'), 0, p_staff_id
            );
        END IF;
        
        -- 记录日志
        INSERT INTO system_log (user_type, user_id, action, target_type, target_id, details)
        VALUES ('staff', p_staff_id, 'return_book', 'book', v_book_id, 
                CONCAT('记录ID:', p_record_id, ' 产生罚款:', p_fine_amount));
        
        COMMIT;
        
        SET p_result = 1;
        SET p_message = CONCAT('归还成功', 
                              CASE WHEN v_overdue_days > 0 THEN CONCAT('，逾期', v_overdue_days, '天') ELSE '' END);
    ELSE
        SET p_result = 0;
        SET p_message = '借阅记录状态异常';
        SET p_fine_amount = 0;
    END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table borrow_record
-- ----------------------------
DROP TRIGGER IF EXISTS `trg_update_overdue_status`;
delimiter ;;
CREATE TRIGGER `trg_update_overdue_status` BEFORE UPDATE ON `borrow_record` FOR EACH ROW BEGIN
    -- 图书未归还且超过应还时间，标记为逾期
    IF NEW.status = 1 AND NEW.due_time < NOW() THEN
        SET NEW.status = 3; 
    END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
