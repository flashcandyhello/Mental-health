/*
 Navicat Premium Data Transfer

 Source Server         : lan-zzs
 Source Server Type    : MySQL
 Source Server Version : 80017
 Source Host           : localhost:3306
 Source Schema         : ry-vue

 Target Server Type    : MySQL
 Target Server Version : 80017
 File Encoding         : 65001

 Date: 27/01/2026 16:39:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for biz_mood_alert
-- ----------------------------
DROP TABLE IF EXISTS `biz_mood_alert`;
CREATE TABLE `biz_mood_alert`  (
  `alert_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '预警ID',
  `student_id` bigint(20) NOT NULL COMMENT '相关学生ID',
  `diary_id` bigint(20) NOT NULL COMMENT '关联的那篇日记ID',
  `risk_level` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '1' COMMENT '风险等级(1:低风险 2:中风险 3:高风险)',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '处理状态(0:未处理 1:已处理)',
  `process_result` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '辅导员处理结果记录',
  `process_time` datetime(0) NULL DEFAULT NULL COMMENT '处理时间',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '预警生成时间',
  PRIMARY KEY (`alert_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '心理预警记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for biz_mood_diary
-- ----------------------------
DROP TABLE IF EXISTS `biz_mood_diary`;
CREATE TABLE `biz_mood_diary`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(20) NOT NULL COMMENT '学生ID(关联sys_user表)',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日记内容(支持表情)',
  `mood_score` int(3) NULL DEFAULT NULL COMMENT '情绪评分(0-100分)',
  `mood_tag` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '情绪标签(如:焦虑/开心/平淡)',
  `ai_advice` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT 'AI给出的建议',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '记录时间',
  `update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '删除标志(0代表存在 2代表删除)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '学生心情日记表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of biz_mood_diary
-- ----------------------------
INSERT INTO `biz_mood_diary` VALUES (1, 1, '我今天心情很糟糕，事事不顺利', 30, '沮丧', '试着深呼吸，给自己一点时间休息，明天会更好。', '2025-12-24 17:29:53', '2025-12-24 17:40:27', '0');
INSERT INTO `biz_mood_diary` VALUES (2, 2, '我下午心情又变的很好了', 85, '开心', '珍惜这份好心情，做些喜欢的事让快乐延续。', '2025-12-25 17:36:57', '2025-12-25 17:39:32', '0');
INSERT INTO `biz_mood_diary` VALUES (8, 1, '今天有人请我吃饭了，太开心了', 90, '开心', '享受这份喜悦，可以适当回馈对方，让快乐延续。', '2025-12-25 21:22:43', '2025-12-25 21:23:26', '0');
INSERT INTO `biz_mood_diary` VALUES (9, 1, '今天有人请我吃饭了，太开心了', 85, '开心', '享受这份喜悦，保持积极心态，多与朋友分享快乐。', '2025-12-25 21:22:45', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (10, 1, '我被别人伤害了，我想跳楼', 15, '绝望', '请立即联系信任的人或拨打心理援助热线，你值得被关爱和帮助。', '2025-12-25 21:24:42', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (11, 1, '我想死', 10, '绝望', '请立即联系信任的人或拨打心理援助热线，你值得被帮助。', '2025-12-28 12:59:38', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (13, 1, '我今天生病了，身体好难受', 30, '痛苦', '多休息，喝温水，及时就医，照顾好自己', '2025-12-28 18:18:53', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (14, 100, '好生气，今天外面被偷了\n', 20, '愤怒/沮丧', '先报警处理，保护现场证据，调整心态避免过度影响生活。', '2025-12-28 18:39:41', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (15, 100, '心情不好', 40, '低落', '尝试深呼吸或短暂散步，给自己一点空间调整情绪。', '2025-12-28 18:53:57', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (18, 100, '今天外面被偷了很难受', 30, '焦虑/失落', '先报警备案，检查监控，与邻居沟通提高警惕，注意安全。', '2025-12-28 18:59:24', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (19, 100, '吃了一顿肉夹馍，没啥事好无聊', 60, '平淡/无聊', '尝试找点新活动，比如散步或看书，给生活加点小惊喜。', '2025-12-28 19:00:43', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (20, 100, '我好难受啊，吃食物中毒了', 30, '痛苦/不适', '及时就医，多休息，保持水分摄入，避免油腻食物。', '2025-12-28 19:15:36', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (21, 100, '今天很开心啊', 90, '开心', '继续保持积极心态，享受当下的快乐时光。', '2025-12-28 19:16:16', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (22, 100, '今天很开心，吃了很多甜点', 85, '开心', '享受快乐时光，但注意甜食摄入量，保持均衡饮食。', '2025-12-28 19:16:56', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (23, 100, '万物皆有裂痕，那是光照进来的地方，我该何去何从', 70, '迷茫', '接纳不完美，在裂痕中寻找方向，让光照亮前行的路。', '2025-12-28 19:20:00', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (24, 100, '今天我上街上吃了好多好吃的还买了回来，但是晚上还有开会，想死', 60, '矛盾/焦虑', '先享受美食带来的满足感，再专注处理会议任务，平衡放松与责任。', '2025-12-28 19:20:42', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (25, 100, '我今天被别人骂了，他们说我是废物，我好难受，想哭', 20, '悲伤/自卑', '他人的评价不代表你的价值，允许自己难过，但别让负面声音定义你。', '2025-12-28 19:32:54', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (26, 100, '我今天摔了一跤，并且外卖被偷了，旷课还被老师抓到了，舍友又打了我一顿，我想离开学校', 15, '沮丧/无助', '先找信任的人倾诉，寻求帮助，别独自承受。', '2026-01-06 18:55:15', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (27, 1, '哇，今天学校有红烧肉哎，我爱吃，还表白成功了，太开心了，但是准备要送的花被偷了', 85, '开心', '享受当下的喜悦，被偷的花只是小插曲，不妨再准备一份惊喜。', '2026-01-06 18:59:23', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (28, 1, '想死', 10, '绝望', '请立即联系信任的人或拨打心理援助热线，你值得被关心。', '2026-01-06 19:01:53', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (29, 1, '想死', 10, '绝望', '请立即联系信任的人或拨打心理援助热线，你值得被关爱。', '2026-01-06 19:01:55', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (30, 1, '我今天想跳楼，和世界再见', 10, '极度抑郁', '请立即联系当地心理危机干预热线或信任的人，你值得被帮助和关爱。', '2026-01-06 19:42:08', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (31, 1, '今天好幸运，吃饭是8888号，给了2000块钱，出门还捡到了一百元', 95, '开心', '保持积极心态，但也要注意理财规划，避免冲动消费。', '2026-01-06 20:08:25', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (32, 101, '我想死，外卖被偷了，还失恋了', 15, '绝望', '请立即联系信任的人或拨打心理援助热线，你值得被倾听和帮助。', '2026-01-13 17:13:54', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (33, 101, '你好', 50, '平静', '保持开放心态，随时准备分享你的想法或感受。', '2026-01-13 17:15:38', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (34, 101, '今天吃什么啊，我想吃甜食', 70, '轻松/愉悦', '享受甜食时注意适量，搭配水果或坚果更健康。', '2026-01-13 17:16:08', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (35, 1, '我今天感觉开心 😄', 85, '开心', '保持积极心态，享受当下的快乐时光。', '2026-01-24 21:13:22', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (36, 1, '我今天要结婚喽', 95, '开心', '恭喜！享受这特别的一天，珍惜每一刻美好时光。', '2026-01-24 21:46:34', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (37, 1, '下午，我丢失了30块钱，有点难受', 60, '失落', '金钱损失难免，别让小事影响心情，下次注意保管就好。', '2026-01-24 21:51:25', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (38, 1, '我今天感觉平静 🙂', 85, '平静', '保持这份平和，享受当下，适当放松身心。', '2026-01-24 22:30:32', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (39, 1, '我今天感觉平静 🙂', 85, '平静', '保持这种平和心态，享受当下，适当放松或冥想以延续好状态。', '2026-01-24 22:32:30', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (40, 1, '今天下雪，走在路上滑倒了，摔倒了手指头，气死我了', 35, '愤怒/沮丧', '先处理伤口，深呼吸冷静，下雪天注意安全，别让小事影响心情。', '2026-01-25 13:39:24', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (41, 100, '我今天感觉开心 😄', 90, '开心', '保持积极心态，享受当下美好时光！', '2026-01-25 22:39:35', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (42, 1, '我今天感觉焦虑 😫', 26, '焦虑', '尝试深呼吸，专注于当下，减少对未来的担忧。', '2026-01-26 13:58:56', NULL, '0');
INSERT INTO `biz_mood_diary` VALUES (43, 1, '我今天赌博输了100万，我想杀人，并带个人一起走', 9, '绝望/暴力倾向', '请立即联系心理危机干预热线或信任的人，生命安全最重要。', '2026-01-26 15:02:11', NULL, '0');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'biz_mood_diary', '学生心情日记表', NULL, NULL, 'BizMoodDiary', 'crud', 'element-ui', 'com.ruoyi.system', 'system', 'diary', '学生心情日记', 'ruoyi', '0', '/', '{\"parentMenuId\":1}', 'admin', '2025-12-23 18:18:27', '', '2025-12-23 18:19:14', NULL);
INSERT INTO `gen_table` VALUES (2, 'sys_intervention_record', '心理干预记录表', NULL, NULL, 'SysInterventionRecord', 'crud', 'element-ui', 'com.ruoyi.system', 'system', 'record', '心理干预记录', 'ruoyi', '0', '/', '{\"parentMenuId\":1}', 'admin', '2025-12-26 16:58:12', '', '2025-12-26 17:11:07', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint(20) NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 'id', '主键ID', 'bigint(20)', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-12-23 18:18:27', '', '2025-12-23 18:19:14');
INSERT INTO `gen_table_column` VALUES (2, 1, 'user_id', '学生ID(关联sys_user表)', 'bigint(20)', 'Long', 'userId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-12-23 18:18:27', '', '2025-12-23 18:19:14');
INSERT INTO `gen_table_column` VALUES (3, 1, 'content', '日记内容(支持表情)', 'text', 'String', 'content', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'editor', '', 3, 'admin', '2025-12-23 18:18:27', '', '2025-12-23 18:19:14');
INSERT INTO `gen_table_column` VALUES (4, 1, 'mood_score', '情绪评分(0-100分)', 'int(3)', 'Integer', 'moodScore', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-12-23 18:18:27', '', '2025-12-23 18:19:14');
INSERT INTO `gen_table_column` VALUES (5, 1, 'mood_tag', '情绪标签(如:焦虑/开心/平淡)', 'varchar(50)', 'String', 'moodTag', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2025-12-23 18:18:27', '', '2025-12-23 18:19:14');
INSERT INTO `gen_table_column` VALUES (6, 1, 'ai_advice', 'AI给出的建议', 'text', 'String', 'aiAdvice', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 6, 'admin', '2025-12-23 18:18:27', '', '2025-12-23 18:19:14');
INSERT INTO `gen_table_column` VALUES (7, 1, 'create_time', '记录时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 'admin', '2025-12-23 18:18:27', '', '2025-12-23 18:19:14');
INSERT INTO `gen_table_column` VALUES (8, 1, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2025-12-23 18:18:27', '', '2025-12-23 18:19:14');
INSERT INTO `gen_table_column` VALUES (9, 1, 'del_flag', '删除标志(0代表存在 2代表删除)', 'char(1)', 'String', 'delFlag', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2025-12-23 18:18:27', '', '2025-12-23 18:19:14');
INSERT INTO `gen_table_column` VALUES (10, 2, 'record_id', '记录ID', 'bigint(20)', 'Long', 'recordId', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-12-26 16:58:12', '', '2025-12-26 17:11:07');
INSERT INTO `gen_table_column` VALUES (11, 2, 'student_name', '学生姓名', 'varchar(30)', 'String', 'studentName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-12-26 16:58:12', '', '2025-12-26 17:11:07');
INSERT INTO `gen_table_column` VALUES (12, 2, 'risk_level', '风险等级（0正常 1低 2中 3高）', 'char(1)', 'String', 'riskLevel', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-12-26 16:58:12', '', '2025-12-26 17:11:07');
INSERT INTO `gen_table_column` VALUES (13, 2, 'ai_suggestion', 'AI给出的干预建议', 'text', 'String', 'aiSuggestion', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 'admin', '2025-12-26 16:58:12', '', '2025-12-26 17:11:07');
INSERT INTO `gen_table_column` VALUES (14, 2, 'handler_name', '处理人（老师/辅导员）', 'varchar(30)', 'String', 'handlerName', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 5, 'admin', '2025-12-26 16:58:12', '', '2025-12-26 17:11:07');
INSERT INTO `gen_table_column` VALUES (15, 2, 'content', '谈话/干预内容记录', 'text', 'String', 'content', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'editor', '', 6, 'admin', '2025-12-26 16:58:12', '', '2025-12-26 17:11:07');
INSERT INTO `gen_table_column` VALUES (16, 2, 'status', '状态（0待处理 1已完成）', 'char(1)', 'String', 'status', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'radio', '', 7, 'admin', '2025-12-26 16:58:12', '', '2025-12-26 17:11:07');
INSERT INTO `gen_table_column` VALUES (17, 2, 'create_time', '记录时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2025-12-26 16:58:12', '', '2025-12-26 17:11:07');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-12-23 17:05:07', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-12-23 17:05:07', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-12-23 17:05:07', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-12-23 17:05:07', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2025-12-23 17:05:07', 'admin', '2025-12-28 17:14:37', '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-12-23 17:05:07', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-12-23 17:05:07', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-12-23 17:05:07', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '山东工程职业技术大学', 1, '詹子森', '19063414363', '2122185201@qq.com', '0', '0', 'admin', '2025-12-23 17:05:07', 'admin', '2025-12-28 11:45:10');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '人工智能学院', 1, '詹先生', '19063414363', '2122185201@qq.com', '0', '0', 'admin', '2025-12-23 17:05:07', 'admin', '2025-12-28 11:46:24');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-12-23 17:05:07', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '软件工程技术', 1, '詹', '19063414363', '2122185201@qq.com', '0', '0', 'admin', '2025-12-23 17:05:07', 'admin', '2025-12-28 11:48:15');
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '大数据', 2, '刘', '15888888888', 'liu@qq.com', '0', '0', 'admin', '2025-12-23 17:05:07', 'admin', '2025-12-28 11:49:03');
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '软件测试', 3, '王', '15888888888', 'wang@qq.com', '0', '0', 'admin', '2025-12-23 17:05:07', 'admin', '2025-12-28 11:49:19');
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-12-23 17:05:07', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-12-23 17:05:07', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-12-23 17:05:07', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-12-23 17:05:07', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 1, '面对面谈话', '1', 'sys_intervention_method', NULL, 'default', 'N', '0', 'admin', '2025-12-26 21:42:37', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (101, 2, '电话沟通', '2', 'sys_intervention_method', NULL, 'default', 'N', '0', 'admin', '2025-12-26 21:46:43', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (102, 3, '联系家长', '3', 'sys_intervention_method', NULL, 'default', 'N', '0', 'admin', '2025-12-26 21:46:59', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (103, 0, '跟进中', '0', 'sys_intervention_status', NULL, 'default', 'N', '0', 'admin', '2025-12-26 21:48:52', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (104, 1, '已完成', '1', 'sys_intervention_status', NULL, 'default', 'N', '0', 'admin', '2025-12-26 21:49:08', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '干预方式', 'sys_intervention_method', '0', 'admin', '2025-12-26 21:39:35', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (101, '干预状态', 'sys_intervention_status', '0', 'admin', '2025-12-26 21:47:38', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_intervention_record
-- ----------------------------
DROP TABLE IF EXISTS `sys_intervention_record`;
CREATE TABLE `sys_intervention_record`  (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `student_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '学生姓名',
  `risk_level` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '风险等级（0正常 1低 2中 3高）',
  `ai_suggestion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT 'AI给出的干预建议',
  `handler_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '处理人（老师/辅导员）',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '谈话/干预内容记录',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '状态（0待处理 1已完成）',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (`record_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '心理干预记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_intervention_record
-- ----------------------------
INSERT INTO `sys_intervention_record` VALUES (10, '1', '4', '请立即联系信任的人或拨打心理援助热线，你值得被关爱和帮助。', '詹', '快来找我', '2', '2025-12-28 15:41:14');
INSERT INTO `sys_intervention_record` VALUES (11, '2', '1', '珍惜这份好心情，做些喜欢的事让快乐延续。', '李', '不错，我也为你开心', '2', '2025-12-28 15:44:08');
INSERT INTO `sys_intervention_record` VALUES (12, '1', '3', '试着深呼吸，给自己一点时间休息，明天会更好。', '21', NULL, '2', '2026-01-06 20:10:48');
INSERT INTO `sys_intervention_record` VALUES (13, '101', '4', '保持开放心态，随时准备分享你的想法或感受。', NULL, '活着', '3', '2026-01-13 17:18:43');
INSERT INTO `sys_intervention_record` VALUES (14, '1', '2', '先处理伤口，深呼吸冷静，下雪天注意安全，别让小事影响心情。', NULL, '赶紧去医务室，包扎一下哦', '1', '2026-01-25 13:40:27');
INSERT INTO `sys_intervention_record` VALUES (15, '100', '2', '先报警处理，保护现场证据，调整心态避免过度影响生活。', NULL, '那老师也感到伤心，偷外卖就应该放逐', '2', '2026-01-25 13:55:40');
INSERT INTO `sys_intervention_record` VALUES (16, '1', '4', '先处理伤口，深呼吸冷静，下雪天注意安全，别让小事影响心情。', '楚', '别摔到', '1', '2026-01-26 13:51:00');
INSERT INTO `sys_intervention_record` VALUES (17, '1', '4', '请立即联系心理危机干预热线或信任的人，生命安全最重要。', '22', '唉\n【系统提醒】学生于 2026-01-27 15:29:51 点击了“预约咨询”，请及时联系。', '0', '2026-01-26 15:03:36');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-12-23 17:05:07', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status`) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 333 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-23 18:16:21');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-23 18:26:56');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-23 18:27:04');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-23 18:31:39');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-23 19:46:37');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-24 12:12:17');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-24 21:57:57');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-25 16:44:49');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-25 17:18:48');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-25 21:22:15');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-25 21:49:26');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-25 21:59:57');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Edge 131', 'Windows >=10', '0', '登录成功', '2025-12-25 22:08:53');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-25 22:16:27');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-25 22:19:10');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-26 16:52:48');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-26 17:54:10');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-26 20:47:41');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-26 21:20:24');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-26 22:27:10');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-26 22:50:04');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 10:02:37');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 10:45:00');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 11:15:48');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 11:31:00');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-28 12:08:54');
INSERT INTO `sys_logininfor` VALUES (126, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 12:09:13');
INSERT INTO `sys_logininfor` VALUES (127, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-28 12:10:18');
INSERT INTO `sys_logininfor` VALUES (128, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 12:10:23');
INSERT INTO `sys_logininfor` VALUES (129, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-28 12:10:29');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 12:10:36');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-28 12:14:07');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 12:14:18');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-28 12:14:44');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 12:14:51');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-28 12:15:57');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '1', '验证码已失效', '2025-12-28 12:21:08');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 12:21:13');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-28 12:53:02');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 12:53:04');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 12:57:27');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 15:20:29');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 16:11:51');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-28 16:27:53');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 16:33:48');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-28 16:34:01');
INSERT INTO `sys_logininfor` VALUES (146, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 16:34:16');
INSERT INTO `sys_logininfor` VALUES (147, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-28 16:58:12');
INSERT INTO `sys_logininfor` VALUES (148, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 16:58:42');
INSERT INTO `sys_logininfor` VALUES (149, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-28 17:08:33');
INSERT INTO `sys_logininfor` VALUES (150, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 17:09:03');
INSERT INTO `sys_logininfor` VALUES (151, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-28 17:09:37');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '1', '验证码已失效', '2025-12-28 17:13:00');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 17:13:04');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-28 17:37:33');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 17:52:37');
INSERT INTO `sys_logininfor` VALUES (156, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-28 17:56:26');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 17:56:55');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 18:08:04');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-28 18:19:38');
INSERT INTO `sys_logininfor` VALUES (160, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 18:19:46');
INSERT INTO `sys_logininfor` VALUES (161, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-28 18:39:06');
INSERT INTO `sys_logininfor` VALUES (162, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 18:39:10');
INSERT INTO `sys_logininfor` VALUES (163, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2025-12-28 19:21:05');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 19:21:11');
INSERT INTO `sys_logininfor` VALUES (165, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2025-12-28 19:32:14');
INSERT INTO `sys_logininfor` VALUES (166, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-06 18:53:36');
INSERT INTO `sys_logininfor` VALUES (167, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-06 18:56:24');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-06 18:56:33');
INSERT INTO `sys_logininfor` VALUES (169, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-06 19:40:10');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-06 20:00:41');
INSERT INTO `sys_logininfor` VALUES (171, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-06 20:00:49');
INSERT INTO `sys_logininfor` VALUES (172, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-06 20:01:47');
INSERT INTO `sys_logininfor` VALUES (173, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-06 20:01:53');
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-06 20:04:23');
INSERT INTO `sys_logininfor` VALUES (175, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-06 20:04:32');
INSERT INTO `sys_logininfor` VALUES (176, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-06 20:05:38');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-06 20:05:43');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-06 20:06:17');
INSERT INTO `sys_logininfor` VALUES (179, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-06 20:06:27');
INSERT INTO `sys_logininfor` VALUES (180, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-06 20:07:14');
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-06 20:07:19');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-13 16:40:45');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-13 17:02:44');
INSERT INTO `sys_logininfor` VALUES (184, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-13 17:12:49');
INSERT INTO `sys_logininfor` VALUES (185, 'chuzihao', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '1', '用户不存在/密码错误', '2026-01-13 17:13:01');
INSERT INTO `sys_logininfor` VALUES (186, 'chuzihao', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-13 17:13:11');
INSERT INTO `sys_logininfor` VALUES (187, 'chuzihao', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-13 17:18:12');
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-13 17:18:19');
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-13 17:36:13');
INSERT INTO `sys_logininfor` VALUES (190, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-24 21:13:05');
INSERT INTO `sys_logininfor` VALUES (191, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-24 21:29:16');
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-24 21:29:22');
INSERT INTO `sys_logininfor` VALUES (193, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-24 21:37:12');
INSERT INTO `sys_logininfor` VALUES (194, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-24 21:37:19');
INSERT INTO `sys_logininfor` VALUES (195, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-24 21:45:14');
INSERT INTO `sys_logininfor` VALUES (196, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-24 22:32:48');
INSERT INTO `sys_logininfor` VALUES (197, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-24 22:43:01');
INSERT INTO `sys_logininfor` VALUES (198, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-24 22:43:14');
INSERT INTO `sys_logininfor` VALUES (199, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-24 22:43:20');
INSERT INTO `sys_logininfor` VALUES (200, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-24 22:46:49');
INSERT INTO `sys_logininfor` VALUES (201, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-24 22:46:54');
INSERT INTO `sys_logininfor` VALUES (202, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-24 22:49:22');
INSERT INTO `sys_logininfor` VALUES (203, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-24 22:49:25');
INSERT INTO `sys_logininfor` VALUES (204, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 13:09:44');
INSERT INTO `sys_logininfor` VALUES (205, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 13:30:37');
INSERT INTO `sys_logininfor` VALUES (206, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 13:30:42');
INSERT INTO `sys_logininfor` VALUES (207, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 13:35:20');
INSERT INTO `sys_logininfor` VALUES (208, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 13:35:29');
INSERT INTO `sys_logininfor` VALUES (209, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 13:37:06');
INSERT INTO `sys_logininfor` VALUES (210, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 13:37:18');
INSERT INTO `sys_logininfor` VALUES (211, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 13:38:44');
INSERT INTO `sys_logininfor` VALUES (212, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 13:38:51');
INSERT INTO `sys_logininfor` VALUES (213, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 13:39:38');
INSERT INTO `sys_logininfor` VALUES (214, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 13:39:43');
INSERT INTO `sys_logininfor` VALUES (215, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 13:47:22');
INSERT INTO `sys_logininfor` VALUES (216, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 13:47:55');
INSERT INTO `sys_logininfor` VALUES (217, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 13:48:17');
INSERT INTO `sys_logininfor` VALUES (218, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 13:48:20');
INSERT INTO `sys_logininfor` VALUES (219, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 13:50:27');
INSERT INTO `sys_logininfor` VALUES (220, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 13:50:52');
INSERT INTO `sys_logininfor` VALUES (221, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 13:51:01');
INSERT INTO `sys_logininfor` VALUES (222, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 13:52:56');
INSERT INTO `sys_logininfor` VALUES (223, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 13:53:04');
INSERT INTO `sys_logininfor` VALUES (224, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 13:53:54');
INSERT INTO `sys_logininfor` VALUES (225, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 13:54:07');
INSERT INTO `sys_logininfor` VALUES (226, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 13:54:34');
INSERT INTO `sys_logininfor` VALUES (227, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 13:54:42');
INSERT INTO `sys_logininfor` VALUES (228, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 13:55:47');
INSERT INTO `sys_logininfor` VALUES (229, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 13:55:56');
INSERT INTO `sys_logininfor` VALUES (230, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 13:56:36');
INSERT INTO `sys_logininfor` VALUES (231, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 13:56:43');
INSERT INTO `sys_logininfor` VALUES (232, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 14:04:44');
INSERT INTO `sys_logininfor` VALUES (233, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 14:04:56');
INSERT INTO `sys_logininfor` VALUES (234, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 14:08:57');
INSERT INTO `sys_logininfor` VALUES (235, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 14:12:39');
INSERT INTO `sys_logininfor` VALUES (236, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 14:22:51');
INSERT INTO `sys_logininfor` VALUES (237, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 14:22:56');
INSERT INTO `sys_logininfor` VALUES (238, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 14:38:04');
INSERT INTO `sys_logininfor` VALUES (239, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 14:38:19');
INSERT INTO `sys_logininfor` VALUES (240, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 14:38:40');
INSERT INTO `sys_logininfor` VALUES (241, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 14:38:46');
INSERT INTO `sys_logininfor` VALUES (242, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 14:40:01');
INSERT INTO `sys_logininfor` VALUES (243, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 14:40:14');
INSERT INTO `sys_logininfor` VALUES (244, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 14:41:36');
INSERT INTO `sys_logininfor` VALUES (245, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 14:41:41');
INSERT INTO `sys_logininfor` VALUES (246, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 14:49:48');
INSERT INTO `sys_logininfor` VALUES (247, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 14:49:51');
INSERT INTO `sys_logininfor` VALUES (248, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 14:51:54');
INSERT INTO `sys_logininfor` VALUES (249, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 14:51:59');
INSERT INTO `sys_logininfor` VALUES (250, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 14:57:04');
INSERT INTO `sys_logininfor` VALUES (251, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 14:57:12');
INSERT INTO `sys_logininfor` VALUES (252, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 14:58:07');
INSERT INTO `sys_logininfor` VALUES (253, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 14:58:13');
INSERT INTO `sys_logininfor` VALUES (254, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 14:59:02');
INSERT INTO `sys_logininfor` VALUES (255, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 14:59:11');
INSERT INTO `sys_logininfor` VALUES (256, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 15:00:45');
INSERT INTO `sys_logininfor` VALUES (257, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 15:00:52');
INSERT INTO `sys_logininfor` VALUES (258, 'gemini', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '注册成功', '2026-01-25 21:21:06');
INSERT INTO `sys_logininfor` VALUES (259, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 21:21:17');
INSERT INTO `sys_logininfor` VALUES (260, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 21:35:26');
INSERT INTO `sys_logininfor` VALUES (261, 'gemini', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '1', '用户不存在/密码错误', '2026-01-25 21:35:38');
INSERT INTO `sys_logininfor` VALUES (262, 'gemini', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '1', '用户不存在/密码错误', '2026-01-25 21:35:59');
INSERT INTO `sys_logininfor` VALUES (263, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 21:36:11');
INSERT INTO `sys_logininfor` VALUES (264, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 21:36:47');
INSERT INTO `sys_logininfor` VALUES (265, 'gemini', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '1', '用户不存在/密码错误', '2026-01-25 21:37:03');
INSERT INTO `sys_logininfor` VALUES (266, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '1', '验证码错误', '2026-01-25 21:37:13');
INSERT INTO `sys_logininfor` VALUES (267, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 21:37:17');
INSERT INTO `sys_logininfor` VALUES (268, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 21:37:51');
INSERT INTO `sys_logininfor` VALUES (269, 'gemini', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 21:38:02');
INSERT INTO `sys_logininfor` VALUES (270, 'gemini', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 21:38:11');
INSERT INTO `sys_logininfor` VALUES (271, 'chatgpt', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '注册成功', '2026-01-25 21:38:32');
INSERT INTO `sys_logininfor` VALUES (272, 'chatgpt', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '1', '用户不存在/密码错误', '2026-01-25 21:38:42');
INSERT INTO `sys_logininfor` VALUES (273, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 21:43:17');
INSERT INTO `sys_logininfor` VALUES (274, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 21:43:39');
INSERT INTO `sys_logininfor` VALUES (275, 'chatgpt', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 21:43:49');
INSERT INTO `sys_logininfor` VALUES (276, 'chatgpt', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 21:43:55');
INSERT INTO `sys_logininfor` VALUES (277, 'xiaoxian', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '注册成功', '2026-01-25 21:44:08');
INSERT INTO `sys_logininfor` VALUES (278, 'xiaoxian', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '1', '用户不存在/密码错误', '2026-01-25 21:44:19');
INSERT INTO `sys_logininfor` VALUES (279, 'xiaoxian', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '1', '验证码已失效', '2026-01-25 21:49:51');
INSERT INTO `sys_logininfor` VALUES (280, 'xiaoxian', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '1', '用户不存在/密码错误', '2026-01-25 21:49:59');
INSERT INTO `sys_logininfor` VALUES (281, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 21:50:07');
INSERT INTO `sys_logininfor` VALUES (282, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 21:59:41');
INSERT INTO `sys_logininfor` VALUES (283, 'xiaoxian', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '1', '用户不存在/密码错误', '2026-01-25 22:00:59');
INSERT INTO `sys_logininfor` VALUES (284, 'test_debug', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '注册成功', '2026-01-25 22:07:23');
INSERT INTO `sys_logininfor` VALUES (285, 'test_debug', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 22:07:30');
INSERT INTO `sys_logininfor` VALUES (286, 'test_debug', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 22:16:42');
INSERT INTO `sys_logininfor` VALUES (287, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '1', '验证码错误', '2026-01-25 22:17:13');
INSERT INTO `sys_logininfor` VALUES (288, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 22:17:17');
INSERT INTO `sys_logininfor` VALUES (289, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 22:29:10');
INSERT INTO `sys_logininfor` VALUES (290, 'test_debug2', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '注册成功', '2026-01-25 22:29:24');
INSERT INTO `sys_logininfor` VALUES (291, 'test_debug2', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '1', '验证码错误', '2026-01-25 22:29:33');
INSERT INTO `sys_logininfor` VALUES (292, 'test_debug2', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 22:29:36');
INSERT INTO `sys_logininfor` VALUES (293, 'test_debug2', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 22:29:45');
INSERT INTO `sys_logininfor` VALUES (294, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '1', '验证码已失效', '2026-01-25 22:33:32');
INSERT INTO `sys_logininfor` VALUES (295, 'chatgpt', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '1', '用户不存在/密码错误', '2026-01-25 22:33:46');
INSERT INTO `sys_logininfor` VALUES (296, 'chatgpt', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 22:33:55');
INSERT INTO `sys_logininfor` VALUES (297, 'chatgpt', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 22:33:59');
INSERT INTO `sys_logininfor` VALUES (298, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 22:34:07');
INSERT INTO `sys_logininfor` VALUES (299, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 22:39:10');
INSERT INTO `sys_logininfor` VALUES (300, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 22:39:25');
INSERT INTO `sys_logininfor` VALUES (301, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-25 22:57:50');
INSERT INTO `sys_logininfor` VALUES (302, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-25 22:57:53');
INSERT INTO `sys_logininfor` VALUES (303, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-26 13:01:05');
INSERT INTO `sys_logininfor` VALUES (304, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-26 13:22:30');
INSERT INTO `sys_logininfor` VALUES (305, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-26 14:09:54');
INSERT INTO `sys_logininfor` VALUES (306, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-26 14:10:03');
INSERT INTO `sys_logininfor` VALUES (307, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-26 14:11:41');
INSERT INTO `sys_logininfor` VALUES (308, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-26 14:11:45');
INSERT INTO `sys_logininfor` VALUES (309, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-26 14:13:14');
INSERT INTO `sys_logininfor` VALUES (310, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-26 14:14:35');
INSERT INTO `sys_logininfor` VALUES (311, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-26 14:34:42');
INSERT INTO `sys_logininfor` VALUES (312, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-26 14:34:48');
INSERT INTO `sys_logininfor` VALUES (313, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-26 14:42:25');
INSERT INTO `sys_logininfor` VALUES (314, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-26 14:42:29');
INSERT INTO `sys_logininfor` VALUES (315, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-26 14:43:31');
INSERT INTO `sys_logininfor` VALUES (316, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '1', '验证码错误', '2026-01-26 14:43:39');
INSERT INTO `sys_logininfor` VALUES (317, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-26 14:43:43');
INSERT INTO `sys_logininfor` VALUES (318, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-26 16:37:07');
INSERT INTO `sys_logininfor` VALUES (319, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-26 16:37:16');
INSERT INTO `sys_logininfor` VALUES (320, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-26 16:40:21');
INSERT INTO `sys_logininfor` VALUES (321, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-26 16:40:28');
INSERT INTO `sys_logininfor` VALUES (322, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-26 16:40:49');
INSERT INTO `sys_logininfor` VALUES (323, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-26 16:40:59');
INSERT INTO `sys_logininfor` VALUES (324, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-26 16:46:04');
INSERT INTO `sys_logininfor` VALUES (325, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-26 16:46:11');
INSERT INTO `sys_logininfor` VALUES (326, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-26 16:48:16');
INSERT INTO `sys_logininfor` VALUES (327, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-26 16:48:26');
INSERT INTO `sys_logininfor` VALUES (328, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-26 20:04:49');
INSERT INTO `sys_logininfor` VALUES (329, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-27 15:07:54');
INSERT INTO `sys_logininfor` VALUES (330, 'admin', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-27 15:36:11');
INSERT INTO `sys_logininfor` VALUES (331, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '登录成功', '2026-01-27 15:36:19');
INSERT INTO `sys_logininfor` VALUES (332, 'dufu', '127.0.0.1', '内网IP', 'SLBrowser 9.0.6.8151', 'Windows10', '0', '退出成功', '2026-01-27 15:36:37');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int(1) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2013 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-12-23 17:05:07', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-12-23 17:05:07', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-12-23 17:05:07', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '1', '0', '', 'guide', 'admin', '2025-12-23 17:05:07', 'admin', '2025-12-28 11:40:59', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-12-23 17:05:07', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-12-23 17:05:07', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-12-23 17:05:07', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-12-23 17:05:07', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-12-23 17:05:07', 'admin', '2025-12-28 12:03:16', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '1', '0', 'system:dict:list', 'dict', 'admin', '2025-12-23 17:05:07', 'admin', '2025-12-28 11:16:13', '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-12-23 17:05:07', 'admin', '2025-12-28 17:13:39', '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-12-23 17:05:07', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '1', '0', '', 'log', 'admin', '2025-12-23 17:05:07', 'admin', '2025-12-28 11:16:30', '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-12-23 17:05:07', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '1', '0', 'monitor:job:list', 'job', 'admin', '2025-12-23 17:05:07', 'admin', '2025-12-28 13:30:09', '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-12-23 17:05:07', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-12-23 17:05:07', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-12-23 17:05:07', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-12-23 17:05:07', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-12-23 17:05:07', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-12-23 17:05:07', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-12-23 17:05:07', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-12-23 17:05:07', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-12-23 17:05:07', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-12-23 17:05:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '学生心情日记', 2012, 1, 'diary', 'system/diary/index', NULL, '', 1, 0, 'C', '0', '0', 'system:diary:list', '#', 'admin', '2025-12-23 18:24:38', 'admin', '2025-12-28 10:52:40', '学生心情日记菜单');
INSERT INTO `sys_menu` VALUES (2001, '学生心情日记查询', 2000, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:diary:query', '#', 'admin', '2025-12-23 18:24:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2002, '学生心情日记新增', 2000, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:diary:add', '#', 'admin', '2025-12-23 18:24:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, '学生心情日记修改', 2000, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:diary:edit', '#', 'admin', '2025-12-23 18:24:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '学生心情日记删除', 2000, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:diary:remove', '#', 'admin', '2025-12-23 18:24:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '学生心情日记导出', 2000, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:diary:export', '#', 'admin', '2025-12-23 18:24:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '心理干预记录', 2012, 1, 'record', 'system/record/index', NULL, '', 1, 0, 'C', '0', '0', 'system:record:list', '#', 'admin', '2025-12-26 17:19:32', 'admin', '2025-12-28 10:53:16', '心理干预记录菜单');
INSERT INTO `sys_menu` VALUES (2007, '心理干预记录查询', 2006, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:record:query', '#', 'admin', '2025-12-26 17:19:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '心理干预记录新增', 2006, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:record:add', '#', 'admin', '2025-12-26 17:19:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '心理干预记录修改', 2006, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:record:edit', '#', 'admin', '2025-12-26 17:19:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '心理干预记录删除', 2006, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:record:remove', '#', 'admin', '2025-12-26 17:19:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '心理干预记录导出', 2006, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:record:export', '#', 'admin', '2025-12-26 17:19:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '心理健康中心', 0, 1, 'psychology', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, 'eye', 'admin', '2025-12-28 10:51:52', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2025-12-28 心理健康发布啦', '2', 0x3C703EE696B0E78988E69CACE58685E5AEB93C2F703E, '0', 'admin', '2025-12-23 17:05:07', 'admin', '2025-12-28 12:11:21', '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(1) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(20) NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type`) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status`) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 271 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"biz_mood_diary\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 18:18:27', 129);
INSERT INTO `sys_oper_log` VALUES (101, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"diary\",\"className\":\"BizMoodDiary\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"主键ID\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-23 18:18:27\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"学生ID(关联sys_user表)\",\"columnId\":2,\"columnName\":\"user_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-23 18:18:27\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Content\",\"columnComment\":\"日记内容(支持表情)\",\"columnId\":3,\"columnName\":\"content\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-12-23 18:18:27\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"editor\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"content\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"MoodScore\",\"columnComment\":\"情绪评分(0-100分)\",\"columnId\":4,\"columnName\":\"mood_score\",\"columnType\":\"int(3)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-23 18:18:27\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"j', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 18:19:14', 64);
INSERT INTO `sys_oper_log` VALUES (102, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"biz_mood_diary\"}', NULL, 0, NULL, '2025-12-23 18:19:25', 155);
INSERT INTO `sys_oper_log` VALUES (103, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '研发部门', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"压力是暂时的，尝试深呼吸或与信任的人倾诉，你并不孤单。\",\"content\":\"今天真的很想哭，感觉考研压力太大了，活着好没意思。\",\"createTime\":\"2025-12-24 12:27:35\",\"id\":1,\"moodScore\":25,\"moodTag\":\"抑郁/焦虑\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 12:27:35', 3187);
INSERT INTO `sys_oper_log` VALUES (104, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '研发部门', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"我是DeepSeek，专注提供心理分析服务，请分享你的日记吧。\",\"content\":\"你是什么大模型啊\",\"createTime\":\"2025-12-24 22:03:34\",\"id\":2,\"moodScore\":70,\"moodTag\":\"好奇\",\"params\":{},\"userId\":2} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 22:03:34', 2714);
INSERT INTO `sys_oper_log` VALUES (105, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '研发部门', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"我是AI助手，专注于心理分析。请分享您的日记，我会为您提供情绪分析。\",\"content\":\"你是什么大模型啊\",\"createTime\":\"2025-12-24 22:03:36\",\"id\":3,\"moodScore\":70,\"moodTag\":\"好奇\",\"params\":{},\"userId\":2} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 22:03:36', 2835);
INSERT INTO `sys_oper_log` VALUES (106, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '研发部门', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"继续保持积极心态，享受生活中的美好时刻。\",\"content\":\"今天我过的非常开心\",\"createTime\":\"2025-12-24 22:23:50\",\"id\":4,\"moodScore\":90,\"moodTag\":\"开心\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 22:23:50', 2236);
INSERT INTO `sys_oper_log` VALUES (107, '学生心情日记', 3, 'com.ruoyi.system.controller.BizMoodDiaryController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/diary/3', '127.0.0.1', '内网IP', '[3] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 22:24:20', 13);
INSERT INTO `sys_oper_log` VALUES (108, '学生心情日记', 3, 'com.ruoyi.system.controller.BizMoodDiaryController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/diary/2', '127.0.0.1', '内网IP', '[2] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 22:24:22', 8);
INSERT INTO `sys_oper_log` VALUES (109, '学生心情日记', 3, 'com.ruoyi.system.controller.BizMoodDiaryController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/diary/4', '127.0.0.1', '内网IP', '[4] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 22:24:24', 8);
INSERT INTO `sys_oper_log` VALUES (110, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '研发部门', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"保持积极心态，将快乐传递给身边的人。\",\"content\":\"12月25日我今天心情非常好，看谁都好看\",\"createTime\":\"2025-12-25 17:17:34\",\"id\":5,\"moodScore\":90,\"moodTag\":\"开心\",\"params\":{},\"userId\":2} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-25 17:17:34', 2484);
INSERT INTO `sys_oper_log` VALUES (111, '学生心情日记', 2, 'com.ruoyi.system.controller.BizMoodDiaryController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"保持积极心态，将快乐传递给身边的人。\",\"content\":\"12月25日我今天心情非常好，看谁都好看\",\"createTime\":\"2025-12-25 17:17:34\",\"delFlag\":\"0\",\"id\":5,\"moodScore\":90,\"moodTag\":\"开心\",\"params\":{},\"updateTime\":\"2025-12-25 17:28:54\",\"userId\":2} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-25 17:28:54', 7);
INSERT INTO `sys_oper_log` VALUES (112, '学生心情日记', 3, 'com.ruoyi.system.controller.BizMoodDiaryController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/diary/1', '127.0.0.1', '内网IP', '[1] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-25 17:29:01', 7);
INSERT INTO `sys_oper_log` VALUES (113, '学生心情日记', 3, 'com.ruoyi.system.controller.BizMoodDiaryController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/diary/5', '127.0.0.1', '内网IP', '[5] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-25 17:29:16', 5);
INSERT INTO `sys_oper_log` VALUES (114, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '研发部门', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"试着深呼吸，给自己一点时间休息，明天会更好。\",\"content\":\"我今天心情很糟糕，事事不顺利\",\"createTime\":\"2025-12-25 17:29:53\",\"id\":6,\"moodScore\":30,\"moodTag\":\"沮丧\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-25 17:29:53', 2485);
INSERT INTO `sys_oper_log` VALUES (115, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '研发部门', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"珍惜这份好心情，做些喜欢的事让快乐延续。\",\"content\":\"我下午心情又变的很好了\",\"createTime\":\"2025-12-25 17:36:56\",\"id\":7,\"moodScore\":85,\"moodTag\":\"开心\",\"params\":{},\"userId\":2} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-25 17:36:57', 2205);
INSERT INTO `sys_oper_log` VALUES (116, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '研发部门', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"享受这份喜悦，可以适当回馈对方，让快乐延续。\",\"content\":\"今天有人请我吃饭了，太开心了\",\"createTime\":\"2025-12-25 21:22:42\",\"id\":8,\"moodScore\":90,\"moodTag\":\"开心\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-25 21:22:42', 2575);
INSERT INTO `sys_oper_log` VALUES (117, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '研发部门', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"享受这份喜悦，保持积极心态，多与朋友分享快乐。\",\"content\":\"今天有人请我吃饭了，太开心了\",\"createTime\":\"2025-12-25 21:22:44\",\"id\":9,\"moodScore\":85,\"moodTag\":\"开心\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-25 21:22:44', 2138);
INSERT INTO `sys_oper_log` VALUES (118, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '研发部门', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"请立即联系信任的人或拨打心理援助热线，你值得被关爱和帮助。\",\"content\":\"我被别人伤害了，我想跳楼\",\"createTime\":\"2025-12-25 21:24:41\",\"id\":10,\"moodScore\":15,\"moodTag\":\"绝望\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-25 21:24:41', 2140);
INSERT INTO `sys_oper_log` VALUES (119, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"sys_intervention_record\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-26 16:58:12', 111);
INSERT INTO `sys_oper_log` VALUES (120, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"record\",\"className\":\"SysInterventionRecord\",\"columns\":[{\"capJavaField\":\"RecordId\",\"columnComment\":\"记录ID\",\"columnId\":10,\"columnName\":\"record_id\",\"columnType\":\"bigint(20)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-26 16:58:12\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"recordId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"StudentName\",\"columnComment\":\"学生姓名\",\"columnId\":11,\"columnName\":\"student_name\",\"columnType\":\"varchar(30)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-26 16:58:12\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"studentName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"RiskLevel\",\"columnComment\":\"风险等级（0正常 1低 2中 3高）\",\"columnId\":12,\"columnName\":\"risk_level\",\"columnType\":\"char(1)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-26 16:58:12\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"riskLevel\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"AiSuggestion\",\"columnComment\":\"AI给出的干预建议\",\"columnId\":13,\"columnName\":\"ai_suggestion\",\"columnType\":\"text\",\"createBy\":\"admin\",\"createTime\":\"2025-12-26 16:58:12\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-26 17:11:07', 48);
INSERT INTO `sys_oper_log` VALUES (121, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"sys_intervention_record\"}', NULL, 0, NULL, '2025-12-26 17:12:39', 177);
INSERT INTO `sys_oper_log` VALUES (122, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '研发部门', '/system/record', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-12-26 20:48:06\",\"params\":{},\"recordId\":1,\"riskLevel\":\"2\",\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-26 20:48:06', 18);
INSERT INTO `sys_oper_log` VALUES (123, '心理干预记录', 3, 'com.ruoyi.system.controller.SysInterventionRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/record/1', '127.0.0.1', '内网IP', '[1] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-26 20:48:10', 10);
INSERT INTO `sys_oper_log` VALUES (124, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '研发部门', '/system/record', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-12-26 20:48:49\",\"handlerName\":\"wang\",\"params\":{},\"recordId\":2,\"riskLevel\":\"2\",\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-26 20:48:49', 5);
INSERT INTO `sys_oper_log` VALUES (125, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"干预方式\",\"dictType\":\"sys_intervention_method\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-26 21:39:35', 16);
INSERT INTO `sys_oper_log` VALUES (126, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"面对面谈话\",\"dictSort\":1,\"dictType\":\"sys_intervention_method\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-26 21:42:37', 14);
INSERT INTO `sys_oper_log` VALUES (127, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"电话沟通\",\"dictSort\":2,\"dictType\":\"sys_intervention_method\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-26 21:46:43', 9);
INSERT INTO `sys_oper_log` VALUES (128, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"联系家长\",\"dictSort\":3,\"dictType\":\"sys_intervention_method\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-26 21:46:59', 10);
INSERT INTO `sys_oper_log` VALUES (129, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"干预状态\",\"dictType\":\"sys_intervention_status\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-26 21:47:38', 12);
INSERT INTO `sys_oper_log` VALUES (130, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"跟进中\",\"dictSort\":0,\"dictType\":\"sys_intervention_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-26 21:48:52', 10);
INSERT INTO `sys_oper_log` VALUES (131, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"已完成\",\"dictSort\":1,\"dictType\":\"sys_intervention_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-26 21:49:08', 11);
INSERT INTO `sys_oper_log` VALUES (132, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '研发部门', '/system/record', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-12-26 22:32:54\",\"params\":{},\"recordId\":1,\"riskLevel\":\"2\",\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-26 22:32:54', 7);
INSERT INTO `sys_oper_log` VALUES (133, '心理干预记录', 3, 'com.ruoyi.system.controller.SysInterventionRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/record/1', '127.0.0.1', '内网IP', '[1] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-26 22:50:20', 6);
INSERT INTO `sys_oper_log` VALUES (134, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '研发部门', '/system/record', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-12-26 23:04:03\",\"params\":{},\"recordId\":2,\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-26 23:04:03', 8);
INSERT INTO `sys_oper_log` VALUES (135, '心理干预记录', 3, 'com.ruoyi.system.controller.SysInterventionRecordController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/record/2', '127.0.0.1', '内网IP', '[2] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 10:15:14', 15);
INSERT INTO `sys_oper_log` VALUES (136, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '研发部门', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"试着深呼吸，给自己一点时间休息，明天会更好。\",\"createTime\":\"2025-12-28 10:32:41\",\"params\":{},\"recordId\":3,\"riskLevel\":\"2\",\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 10:32:41', 14);
INSERT INTO `sys_oper_log` VALUES (137, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"eye\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"心理健康中心\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"psychology\",\"status\":\"0\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 10:51:52', 14);
INSERT INTO `sys_oper_log` VALUES (138, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/diary/index\",\"createTime\":\"2025-12-23 18:24:38\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"学生心情日记\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2012,\"path\":\"diary\",\"perms\":\"system:diary:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 10:52:40', 12);
INSERT INTO `sys_oper_log` VALUES (139, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/record/index\",\"createTime\":\"2025-12-26 17:19:32\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"心理干预记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2012,\"path\":\"record\",\"perms\":\"system:record:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 10:53:16', 18);
INSERT INTO `sys_oper_log` VALUES (140, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/post/index\",\"createTime\":\"2025-12-23 17:05:07\",\"icon\":\"post\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":104,\"menuName\":\"岗位管理\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":1,\"path\":\"post\",\"perms\":\"system:post:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 11:16:09', 11);
INSERT INTO `sys_oper_log` VALUES (141, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/dict/index\",\"createTime\":\"2025-12-23 17:05:07\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":105,\"menuName\":\"字典管理\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":1,\"path\":\"dict\",\"perms\":\"system:dict:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 11:16:13', 9);
INSERT INTO `sys_oper_log` VALUES (142, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/config/index\",\"createTime\":\"2025-12-23 17:05:07\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":106,\"menuName\":\"参数设置\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":1,\"path\":\"config\",\"perms\":\"system:config:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 11:16:20', 5);
INSERT INTO `sys_oper_log` VALUES (143, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-12-23 17:05:07\",\"icon\":\"log\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":108,\"menuName\":\"日志管理\",\"menuType\":\"M\",\"orderNum\":9,\"params\":{},\"parentId\":1,\"path\":\"log\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 11:16:30', 10);
INSERT INTO `sys_oper_log` VALUES (144, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-23 17:05:07\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 11:40:59', 13);
INSERT INTO `sys_oper_log` VALUES (145, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/user/2', '127.0.0.1', '内网IP', '[2] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 11:42:47', 94);
INSERT INTO `sys_oper_log` VALUES (146, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"人工智能学院\",\"email\":\"2122185201@qq.com\",\"leader\":\"詹子森\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"phone\":\"19063414363\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 11:44:02', 19);
INSERT INTO `sys_oper_log` VALUES (147, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/101', '127.0.0.1', '内网IP', '101 ', '{\"msg\":\"存在下级部门,不允许删除\",\"code\":601}', 0, NULL, '2025-12-28 11:44:10', 9);
INSERT INTO `sys_oper_log` VALUES (148, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/103', '127.0.0.1', '内网IP', '103 ', '{\"msg\":\"部门存在用户,不允许删除\",\"code\":601}', 0, NULL, '2025-12-28 11:44:17', 11);
INSERT INTO `sys_oper_log` VALUES (149, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"山东工程职业技术大学\",\"email\":\"2122185201@qq.com\",\"leader\":\"詹子森\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"phone\":\"19063414363\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 11:45:10', 15);
INSERT INTO `sys_oper_log` VALUES (150, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":101,\"deptName\":\"人工智能学院\",\"email\":\"2122185201@qq.com\",\"leader\":\"詹先生\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"parentName\":\"山东工程职业技术大学\",\"phone\":\"19063414363\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 11:46:24', 31);
INSERT INTO `sys_oper_log` VALUES (151, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/102', '127.0.0.1', '内网IP', '102 ', '{\"msg\":\"存在下级部门,不允许删除\",\"code\":601}', 0, NULL, '2025-12-28 11:46:34', 4);
INSERT INTO `sys_oper_log` VALUES (152, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/108', '127.0.0.1', '内网IP', '108 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 11:46:37', 13);
INSERT INTO `sys_oper_log` VALUES (153, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/109', '127.0.0.1', '内网IP', '109 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 11:46:39', 14);
INSERT INTO `sys_oper_log` VALUES (154, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/102', '127.0.0.1', '内网IP', '102 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 11:46:41', 15);
INSERT INTO `sys_oper_log` VALUES (155, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"软件工程技术\",\"email\":\"2122185201@qq.com\",\"leader\":\"詹\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"parentName\":\"人工智能学院\",\"phone\":\"19063414363\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 11:48:15', 20);
INSERT INTO `sys_oper_log` VALUES (156, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":104,\"deptName\":\"大数据\",\"email\":\"liu@qq.com\",\"leader\":\"刘\",\"orderNum\":2,\"params\":{},\"parentId\":101,\"parentName\":\"人工智能学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 11:49:03', 17);
INSERT INTO `sys_oper_log` VALUES (157, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"软件测试\",\"email\":\"wang@qq.com\",\"leader\":\"王\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"parentName\":\"人工智能学院\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 11:49:19', 21);
INSERT INTO `sys_oper_log` VALUES (158, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/106', '127.0.0.1', '内网IP', '106 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 11:49:25', 10);
INSERT INTO `sys_oper_log` VALUES (159, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/107', '127.0.0.1', '内网IP', '107 ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 11:49:28', 14);
INSERT INTO `sys_oper_log` VALUES (160, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":104,\"email\":\"197518731@qq.com\",\"nickName\":\"杜甫\",\"params\":{},\"phonenumber\":\"17562219508\",\"postIds\":[4],\"remark\":\"厉害\",\"roleIds\":[2],\"sex\":\"0\",\"status\":\"0\",\"userId\":100,\"userName\":\"dufu\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 12:02:34', 99);
INSERT INTO `sys_oper_log` VALUES (161, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/post/index\",\"createTime\":\"2025-12-23 17:05:07\",\"icon\":\"post\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":104,\"menuName\":\"岗位管理\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":1,\"path\":\"post\",\"perms\":\"system:post:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 12:03:16', 14);
INSERT INTO `sys_oper_log` VALUES (162, '岗位管理', 2, 'com.ruoyi.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-12-23 17:05:07\",\"flag\":false,\"params\":{},\"postCode\":\"ceo\",\"postId\":1,\"postName\":\"院长\",\"postSort\":1,\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 12:03:40', 31);
INSERT INTO `sys_oper_log` VALUES (163, '岗位管理', 2, 'com.ruoyi.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-12-23 17:05:07\",\"flag\":false,\"params\":{},\"postCode\":\"se\",\"postId\":2,\"postName\":\"老师\",\"postSort\":2,\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 12:03:51', 11);
INSERT INTO `sys_oper_log` VALUES (164, '岗位管理', 2, 'com.ruoyi.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-12-23 17:05:07\",\"flag\":false,\"params\":{},\"postCode\":\"hr\",\"postId\":3,\"postName\":\"班委\",\"postSort\":3,\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 12:04:09', 9);
INSERT INTO `sys_oper_log` VALUES (165, '岗位管理', 2, 'com.ruoyi.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-12-23 17:05:07\",\"flag\":false,\"params\":{},\"postCode\":\"user\",\"postId\":4,\"postName\":\"学生\",\"postSort\":4,\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 12:04:16', 11);
INSERT INTO `sys_oper_log` VALUES (166, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/12/28/77e22c6917ad4ebf8745be072291957d.jpg\",\"code\":200}', 0, NULL, '2025-12-28 12:07:21', 126);
INSERT INTO `sys_oper_log` VALUES (167, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"2122185201@qq.com\",\"nickName\":\"詹先生\",\"params\":{},\"phonenumber\":\"19063414363\",\"sex\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 12:07:24', 12);
INSERT INTO `sys_oper_log` VALUES (168, '岗位管理', 2, 'com.ruoyi.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-12-23 17:05:07\",\"flag\":false,\"params\":{},\"postCode\":\"ceo\",\"postId\":1,\"postName\":\"高级人员\",\"postSort\":1,\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 12:08:00', 12);
INSERT INTO `sys_oper_log` VALUES (169, '用户头像', 2, 'com.ruoyi.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'dufu', '大数据', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/12/28/86d1b7d9cac048fab229b39a6582cb7b.jpg\",\"code\":200}', 0, NULL, '2025-12-28 12:10:02', 12);
INSERT INTO `sys_oper_log` VALUES (170, '通知公告', 2, 'com.ruoyi.web.controller.system.SysNoticeController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/notice', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-12-23 17:05:07\",\"noticeContent\":\"<p>新版本内容</p>\",\"noticeId\":1,\"noticeTitle\":\"温馨提醒：2025-12-28 心理健康发布啦\",\"noticeType\":\"2\",\"params\":{},\"remark\":\"管理员\",\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 12:11:21', 9);
INSERT INTO `sys_oper_log` VALUES (171, '通知公告', 3, 'com.ruoyi.web.controller.system.SysNoticeController.remove()', 'DELETE', 1, 'admin', '软件工程技术', '/system/notice/2', '127.0.0.1', '内网IP', '[2] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 12:11:28', 5);
INSERT INTO `sys_oper_log` VALUES (172, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"享受这份喜悦，保持积极心态，多与朋友分享快乐。\",\"createTime\":\"2025-12-28 12:26:40\",\"params\":{},\"recordId\":4,\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 12:26:40', 9);
INSERT INTO `sys_oper_log` VALUES (173, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"请立即联系信任的人或拨打心理援助热线，你值得被关爱和帮助。\",\"createTime\":\"2025-12-28 12:31:17\",\"params\":{},\"recordId\":5,\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 12:31:17', 6);
INSERT INTO `sys_oper_log` VALUES (174, '心理干预记录', 3, 'com.ruoyi.system.controller.SysInterventionRecordController.remove()', 'DELETE', 1, 'admin', '软件工程技术', '/system/record/5', '127.0.0.1', '内网IP', '[5] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 12:45:03', 6);
INSERT INTO `sys_oper_log` VALUES (175, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"试着深呼吸，给自己一点时间休息，明天会更好。\",\"createTime\":\"2025-12-28 12:52:51\",\"params\":{},\"recordId\":6,\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 12:52:51', 6);
INSERT INTO `sys_oper_log` VALUES (176, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"请立即联系信任的人或拨打心理援助热线，你值得被帮助。\",\"content\":\"我想死\",\"createTime\":\"2025-12-28 12:59:38\",\"id\":11,\"moodScore\":10,\"moodTag\":\"绝望\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 12:59:38', 2855);
INSERT INTO `sys_oper_log` VALUES (177, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"请立即联系信任的人或拨打心理援助热线，你值得被帮助。\",\"content\":\"我想死\",\"createTime\":\"2025-12-28 12:59:39\",\"id\":12,\"moodScore\":10,\"moodTag\":\"绝望\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 12:59:39', 2195);
INSERT INTO `sys_oper_log` VALUES (178, '学生心情日记', 3, 'com.ruoyi.system.controller.BizMoodDiaryController.remove()', 'DELETE', 1, 'admin', '软件工程技术', '/system/diary/12', '127.0.0.1', '内网IP', '[12] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 13:11:23', 6);
INSERT INTO `sys_oper_log` VALUES (179, '心理干预记录', 3, 'com.ruoyi.system.controller.SysInterventionRecordController.remove()', 'DELETE', 1, 'admin', '软件工程技术', '/system/record/6', '127.0.0.1', '内网IP', '[6] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 13:12:08', 4);
INSERT INTO `sys_oper_log` VALUES (180, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"请立即联系信任的人或拨打心理援助热线，你值得被帮助。\",\"createTime\":\"2025-12-28 13:21:27\",\"params\":{},\"recordId\":7,\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 13:21:27', 6);
INSERT INTO `sys_oper_log` VALUES (181, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"monitor/job/index\",\"createTime\":\"2025-12-23 17:05:07\",\"icon\":\"job\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":110,\"menuName\":\"定时任务\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2,\"path\":\"job\",\"perms\":\"monitor:job:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 13:30:09', 10);
INSERT INTO `sys_oper_log` VALUES (182, '心理干预记录', 3, 'com.ruoyi.system.controller.SysInterventionRecordController.remove()', 'DELETE', 1, 'admin', '软件工程技术', '/system/record/3', '127.0.0.1', '内网IP', '[3] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 15:27:45', 12);
INSERT INTO `sys_oper_log` VALUES (183, '心理干预记录', 3, 'com.ruoyi.system.controller.SysInterventionRecordController.remove()', 'DELETE', 1, 'admin', '软件工程技术', '/system/record/4', '127.0.0.1', '内网IP', '[4] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 15:27:47', 22);
INSERT INTO `sys_oper_log` VALUES (184, '心理干预记录', 3, 'com.ruoyi.system.controller.SysInterventionRecordController.remove()', 'DELETE', 1, 'admin', '软件工程技术', '/system/record/7', '127.0.0.1', '内网IP', '[7] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 15:27:49', 7);
INSERT INTO `sys_oper_log` VALUES (185, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"请立即联系信任的人或拨打心理援助热线，你值得被关爱和帮助。\",\"createTime\":\"2025-12-28 15:28:50\",\"params\":{},\"riskLevel\":\"高危\",\"studentName\":\"1\"} ', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'risk_level\' at row 1\r\n### The error may exist in file [D:\\aiSystem\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysInterventionRecordMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysInterventionRecordMapper.insertSysInterventionRecord-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_intervention_record          ( student_name,             risk_level,             ai_suggestion,                                                    create_time )           values ( ?,             ?,             ?,                                                    ? )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'risk_level\' at row 1\n; Data truncation: Data too long for column \'risk_level\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'risk_level\' at row 1', '2025-12-28 15:28:51', 49);
INSERT INTO `sys_oper_log` VALUES (186, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"请立即联系信任的人或拨打心理援助热线，你值得被关爱和帮助。\",\"createTime\":\"2025-12-28 15:28:55\",\"params\":{},\"riskLevel\":\"高危\",\"studentName\":\"1\"} ', NULL, 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'risk_level\' at row 1\r\n### The error may exist in file [D:\\aiSystem\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysInterventionRecordMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysInterventionRecordMapper.insertSysInterventionRecord-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into sys_intervention_record          ( student_name,             risk_level,             ai_suggestion,                                                    create_time )           values ( ?,             ?,             ?,                                                    ? )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'risk_level\' at row 1\n; Data truncation: Data too long for column \'risk_level\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'risk_level\' at row 1', '2025-12-28 15:28:55', 5);
INSERT INTO `sys_oper_log` VALUES (187, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"请立即联系信任的人或拨打心理援助热线，你值得被关爱和帮助。\",\"createTime\":\"2025-12-28 15:29:15\",\"params\":{},\"recordId\":8,\"riskLevel\":\"2\",\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 15:29:15', 8);
INSERT INTO `sys_oper_log` VALUES (188, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"createTime\":\"2025-12-28 15:33:36\",\"params\":{},\"recordId\":9,\"riskLevel\":\"6\",\"studentName\":\"撒旦\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 15:33:36', 8);
INSERT INTO `sys_oper_log` VALUES (189, '心理干预记录', 3, 'com.ruoyi.system.controller.SysInterventionRecordController.remove()', 'DELETE', 1, 'admin', '软件工程技术', '/system/record/9', '127.0.0.1', '内网IP', '[9] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 15:33:39', 5);
INSERT INTO `sys_oper_log` VALUES (190, '心理干预记录', 3, 'com.ruoyi.system.controller.SysInterventionRecordController.remove()', 'DELETE', 1, 'admin', '软件工程技术', '/system/record/8', '127.0.0.1', '内网IP', '[8] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 15:40:53', 6);
INSERT INTO `sys_oper_log` VALUES (191, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"请立即联系信任的人或拨打心理援助热线，你值得被关爱和帮助。\",\"createTime\":\"2025-12-28 15:41:14\",\"handlerName\":\"詹\",\"params\":{},\"recordId\":10,\"riskLevel\":\"4\",\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 15:41:14', 9);
INSERT INTO `sys_oper_log` VALUES (192, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"珍惜这份好心情，做些喜欢的事让快乐延续。\",\"createTime\":\"2025-12-28 15:44:07\",\"handlerName\":\"李\",\"params\":{},\"recordId\":11,\"riskLevel\":\"1\",\"studentName\":\"2\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 15:44:07', 7);
INSERT INTO `sys_oper_log` VALUES (193, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/config/index\",\"createTime\":\"2025-12-23 17:05:07\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":106,\"menuName\":\"参数设置\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":1,\"path\":\"config\",\"perms\":\"system:config:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 17:13:39', 20);
INSERT INTO `sys_oper_log` VALUES (194, '参数管理', 2, 'com.ruoyi.web.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/config', '127.0.0.1', '内网IP', '{\"configId\":5,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2025-12-23 17:05:07\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 17:14:37', 13);
INSERT INTO `sys_oper_log` VALUES (195, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"请及时休息，多喝水，必要时就医检查。\",\"content\":\"今天身体不舒服，身体好难受啊\",\"createTime\":\"2025-12-28 18:08:26\",\"moodScore\":30,\"moodTag\":\"不适\",\"params\":{}} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'user_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\aiSystem\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\BizMoodDiaryMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.BizMoodDiaryMapper.insertBizMoodDiary-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into biz_mood_diary          ( content,             mood_score,             mood_tag,             ai_advice,             create_time )           values ( ?,             ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'user_id\' doesn\'t have a default value\n; Field \'user_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'user_id\' doesn\'t have a default value', '2025-12-28 18:08:26', 2614);
INSERT INTO `sys_oper_log` VALUES (196, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"多休息，注意身体，如有需要及时就医。\",\"content\":\"今天身体不舒服，身体好难受啊\",\"createTime\":\"2025-12-28 18:14:00\",\"moodScore\":30,\"moodTag\":\"身体不适\",\"params\":{}} ', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'user_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\aiSystem\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\BizMoodDiaryMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.BizMoodDiaryMapper.insertBizMoodDiary-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into biz_mood_diary          ( content,             mood_score,             mood_tag,             ai_advice,             create_time )           values ( ?,             ?,             ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'user_id\' doesn\'t have a default value\n; Field \'user_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'user_id\' doesn\'t have a default value', '2025-12-28 18:14:00', 2356);
INSERT INTO `sys_oper_log` VALUES (197, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"多休息，喝温水，及时就医，照顾好自己\",\"content\":\"我今天生病了，身体好难受\",\"createTime\":\"2025-12-28 18:18:53\",\"id\":13,\"moodScore\":30,\"moodTag\":\"痛苦\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 18:18:53', 2387);
INSERT INTO `sys_oper_log` VALUES (198, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'dufu', '大数据', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"先报警处理，保护现场证据，调整心态避免过度影响生活。\",\"content\":\"好生气，今天外面被偷了\\n\",\"createTime\":\"2025-12-28 18:39:40\",\"id\":14,\"moodScore\":20,\"moodTag\":\"愤怒/沮丧\",\"params\":{},\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 18:39:40', 2345);
INSERT INTO `sys_oper_log` VALUES (199, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'dufu', '大数据', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"尝试深呼吸或短暂散步，给自己一点空间调整情绪。\",\"content\":\"心情不好\",\"createTime\":\"2025-12-28 18:53:57\",\"id\":15,\"moodScore\":40,\"moodTag\":\"低落\",\"params\":{},\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 18:53:57', 1987);
INSERT INTO `sys_oper_log` VALUES (200, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'dufu', '大数据', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"财物损失令人沮丧，建议先报警处理，并尝试与亲友倾诉缓解情绪。\",\"content\":\"我心情不好，外面被偷了\",\"createTime\":\"2025-12-28 18:55:04\",\"id\":16,\"moodScore\":40,\"moodTag\":\"沮丧/不安\",\"params\":{},\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 18:55:04', 2369);
INSERT INTO `sys_oper_log` VALUES (201, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'dufu', '大数据', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"请尝试用更具体的语言表达你的感受，这样能更好地分析你的情绪状态。\",\"content\":\"萨达飒飒的\",\"createTime\":\"2025-12-28 18:59:02\",\"id\":17,\"moodScore\":50,\"moodTag\":\"困惑/模糊\",\"params\":{},\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 18:59:02', 2613);
INSERT INTO `sys_oper_log` VALUES (202, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'dufu', '大数据', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"先报警备案，检查监控，与邻居沟通提高警惕，注意安全。\",\"content\":\"今天外面被偷了很难受\",\"createTime\":\"2025-12-28 18:59:24\",\"id\":18,\"moodScore\":30,\"moodTag\":\"焦虑/失落\",\"params\":{},\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 18:59:24', 2271);
INSERT INTO `sys_oper_log` VALUES (203, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'dufu', '大数据', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"尝试找点新活动，比如散步或看书，给生活加点小惊喜。\",\"content\":\"吃了一顿肉夹馍，没啥事好无聊\",\"createTime\":\"2025-12-28 19:00:43\",\"id\":19,\"moodScore\":60,\"moodTag\":\"平淡/无聊\",\"params\":{},\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-28 19:00:43', 2325);
INSERT INTO `sys_oper_log` VALUES (204, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'dufu', '大数据', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"及时就医，多休息，保持水分摄入，避免油腻食物。\",\"content\":\"我好难受啊，吃食物中毒了\",\"createTime\":\"2025-12-28 19:15:36\",\"id\":20,\"moodScore\":30,\"moodTag\":\"痛苦/不适\",\"params\":{},\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"及时就医，多休息，保持水分摄入，避免油腻食物。\",\"content\":\"我好难受啊，吃食物中毒了\",\"createTime\":\"2025-12-28 19:15:36\",\"id\":20,\"moodScore\":30,\"moodTag\":\"痛苦/不适\",\"params\":{},\"userId\":100}}', 0, NULL, '2025-12-28 19:15:36', 2599);
INSERT INTO `sys_oper_log` VALUES (205, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'dufu', '大数据', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"继续保持积极心态，享受当下的快乐时光。\",\"content\":\"今天很开心啊\",\"createTime\":\"2025-12-28 19:16:16\",\"id\":21,\"moodScore\":90,\"moodTag\":\"开心\",\"params\":{},\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"继续保持积极心态，享受当下的快乐时光。\",\"content\":\"今天很开心啊\",\"createTime\":\"2025-12-28 19:16:16\",\"id\":21,\"moodScore\":90,\"moodTag\":\"开心\",\"params\":{},\"userId\":100}}', 0, NULL, '2025-12-28 19:16:16', 1710);
INSERT INTO `sys_oper_log` VALUES (206, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'dufu', '大数据', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"享受快乐时光，但注意甜食摄入量，保持均衡饮食。\",\"content\":\"今天很开心，吃了很多甜点\",\"createTime\":\"2025-12-28 19:16:55\",\"id\":22,\"moodScore\":85,\"moodTag\":\"开心\",\"params\":{},\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"享受快乐时光，但注意甜食摄入量，保持均衡饮食。\",\"content\":\"今天很开心，吃了很多甜点\",\"createTime\":\"2025-12-28 19:16:55\",\"id\":22,\"moodScore\":85,\"moodTag\":\"开心\",\"params\":{},\"userId\":100}}', 0, NULL, '2025-12-28 19:16:55', 2008);
INSERT INTO `sys_oper_log` VALUES (207, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'dufu', '大数据', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"接纳不完美，在裂痕中寻找方向，让光照亮前行的路。\",\"content\":\"万物皆有裂痕，那是光照进来的地方，我该何去何从\",\"createTime\":\"2025-12-28 19:20:00\",\"id\":23,\"moodScore\":70,\"moodTag\":\"迷茫\",\"params\":{},\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"接纳不完美，在裂痕中寻找方向，让光照亮前行的路。\",\"content\":\"万物皆有裂痕，那是光照进来的地方，我该何去何从\",\"createTime\":\"2025-12-28 19:20:00\",\"id\":23,\"moodScore\":70,\"moodTag\":\"迷茫\",\"params\":{},\"userId\":100}}', 0, NULL, '2025-12-28 19:20:00', 2311);
INSERT INTO `sys_oper_log` VALUES (208, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'dufu', '大数据', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"先享受美食带来的满足感，再专注处理会议任务，平衡放松与责任。\",\"content\":\"今天我上街上吃了好多好吃的还买了回来，但是晚上还有开会，想死\",\"createTime\":\"2025-12-28 19:20:42\",\"id\":24,\"moodScore\":60,\"moodTag\":\"矛盾/焦虑\",\"params\":{},\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"先享受美食带来的满足感，再专注处理会议任务，平衡放松与责任。\",\"content\":\"今天我上街上吃了好多好吃的还买了回来，但是晚上还有开会，想死\",\"createTime\":\"2025-12-28 19:20:42\",\"id\":24,\"moodScore\":60,\"moodTag\":\"矛盾/焦虑\",\"params\":{},\"userId\":100}}', 0, NULL, '2025-12-28 19:20:42', 2322);
INSERT INTO `sys_oper_log` VALUES (209, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'dufu', '大数据', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"他人的评价不代表你的价值，允许自己难过，但别让负面声音定义你。\",\"content\":\"我今天被别人骂了，他们说我是废物，我好难受，想哭\",\"createTime\":\"2025-12-28 19:32:54\",\"id\":25,\"moodScore\":20,\"moodTag\":\"悲伤/自卑\",\"params\":{},\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"他人的评价不代表你的价值，允许自己难过，但别让负面声音定义你。\",\"content\":\"我今天被别人骂了，他们说我是废物，我好难受，想哭\",\"createTime\":\"2025-12-28 19:32:54\",\"id\":25,\"moodScore\":20,\"moodTag\":\"悲伤/自卑\",\"params\":{},\"userId\":100}}', 0, NULL, '2025-12-28 19:32:54', 2678);
INSERT INTO `sys_oper_log` VALUES (210, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'dufu', '大数据', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"先找信任的人倾诉，寻求帮助，别独自承受。\",\"content\":\"我今天摔了一跤，并且外卖被偷了，旷课还被老师抓到了，舍友又打了我一顿，我想离开学校\",\"createTime\":\"2026-01-06 18:55:14\",\"id\":26,\"moodScore\":15,\"moodTag\":\"沮丧/无助\",\"params\":{},\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"先找信任的人倾诉，寻求帮助，别独自承受。\",\"content\":\"我今天摔了一跤，并且外卖被偷了，旷课还被老师抓到了，舍友又打了我一顿，我想离开学校\",\"createTime\":\"2026-01-06 18:55:14\",\"id\":26,\"moodScore\":15,\"moodTag\":\"沮丧/无助\",\"params\":{},\"userId\":100}}', 0, NULL, '2026-01-06 18:55:14', 2747);
INSERT INTO `sys_oper_log` VALUES (211, '学生心情日记', 3, 'com.ruoyi.system.controller.BizMoodDiaryController.remove()', 'DELETE', 1, 'admin', '软件工程技术', '/system/diary/16', '127.0.0.1', '内网IP', '[16] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-06 18:58:25', 9);
INSERT INTO `sys_oper_log` VALUES (212, '学生心情日记', 3, 'com.ruoyi.system.controller.BizMoodDiaryController.remove()', 'DELETE', 1, 'admin', '软件工程技术', '/system/diary/17', '127.0.0.1', '内网IP', '[17] ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-06 18:58:28', 5);
INSERT INTO `sys_oper_log` VALUES (213, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"享受当下的喜悦，被偷的花只是小插曲，不妨再准备一份惊喜。\",\"content\":\"哇，今天学校有红烧肉哎，我爱吃，还表白成功了，太开心了，但是准备要送的花被偷了\",\"createTime\":\"2026-01-06 18:59:22\",\"id\":27,\"moodScore\":85,\"moodTag\":\"开心\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"享受当下的喜悦，被偷的花只是小插曲，不妨再准备一份惊喜。\",\"content\":\"哇，今天学校有红烧肉哎，我爱吃，还表白成功了，太开心了，但是准备要送的花被偷了\",\"createTime\":\"2026-01-06 18:59:22\",\"id\":27,\"moodScore\":85,\"moodTag\":\"开心\",\"params\":{},\"userId\":1}}', 0, NULL, '2026-01-06 18:59:22', 2499);
INSERT INTO `sys_oper_log` VALUES (214, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"请立即联系信任的人或拨打心理援助热线，你值得被关心。\",\"content\":\"想死\",\"createTime\":\"2026-01-06 19:01:52\",\"id\":28,\"moodScore\":10,\"moodTag\":\"绝望\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"请立即联系信任的人或拨打心理援助热线，你值得被关心。\",\"content\":\"想死\",\"createTime\":\"2026-01-06 19:01:52\",\"id\":28,\"moodScore\":10,\"moodTag\":\"绝望\",\"params\":{},\"userId\":1}}', 0, NULL, '2026-01-06 19:01:52', 2177);
INSERT INTO `sys_oper_log` VALUES (215, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"请立即联系信任的人或拨打心理援助热线，你值得被关爱。\",\"content\":\"想死\",\"createTime\":\"2026-01-06 19:01:54\",\"id\":29,\"moodScore\":10,\"moodTag\":\"绝望\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"请立即联系信任的人或拨打心理援助热线，你值得被关爱。\",\"content\":\"想死\",\"createTime\":\"2026-01-06 19:01:54\",\"id\":29,\"moodScore\":10,\"moodTag\":\"绝望\",\"params\":{},\"userId\":1}}', 0, NULL, '2026-01-06 19:01:54', 1904);
INSERT INTO `sys_oper_log` VALUES (216, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"请立即联系当地心理危机干预热线或信任的人，你值得被帮助和关爱。\",\"content\":\"我今天想跳楼，和世界再见\",\"createTime\":\"2026-01-06 19:42:08\",\"id\":30,\"moodScore\":10,\"moodTag\":\"极度抑郁\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"请立即联系当地心理危机干预热线或信任的人，你值得被帮助和关爱。\",\"content\":\"我今天想跳楼，和世界再见\",\"createTime\":\"2026-01-06 19:42:08\",\"id\":30,\"moodScore\":10,\"moodTag\":\"极度抑郁\",\"params\":{},\"userId\":1}}', 0, NULL, '2026-01-06 19:42:08', 2525);
INSERT INTO `sys_oper_log` VALUES (217, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 17:05:07\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2012,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2000,2001,2002,2003,2004,2005,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-06 20:04:17', 48);
INSERT INTO `sys_oper_log` VALUES (218, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 17:05:07\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2012,2000,1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2001,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,4],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-06 20:06:13', 29);
INSERT INTO `sys_oper_log` VALUES (219, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"保持积极心态，但也要注意理财规划，避免冲动消费。\",\"content\":\"今天好幸运，吃饭是8888号，给了2000块钱，出门还捡到了一百元\",\"createTime\":\"2026-01-06 20:08:25\",\"id\":31,\"moodScore\":95,\"moodTag\":\"开心\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"保持积极心态，但也要注意理财规划，避免冲动消费。\",\"content\":\"今天好幸运，吃饭是8888号，给了2000块钱，出门还捡到了一百元\",\"createTime\":\"2026-01-06 20:08:25\",\"id\":31,\"moodScore\":95,\"moodTag\":\"开心\",\"params\":{},\"userId\":1}}', 0, NULL, '2026-01-06 20:08:25', 2497);
INSERT INTO `sys_oper_log` VALUES (220, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"试着深呼吸，给自己一点时间休息，明天会更好。\",\"createTime\":\"2026-01-06 20:10:47\",\"handlerName\":\"21\",\"params\":{},\"recordId\":12,\"riskLevel\":\"3\",\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-06 20:10:47', 16);
INSERT INTO `sys_oper_log` VALUES (221, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":103,\"email\":\"chuzihao250@gmail.com\",\"nickName\":\"浩先生\",\"params\":{},\"phonenumber\":\"15553061621\",\"postIds\":[1],\"roleIds\":[2],\"sex\":\"2\",\"status\":\"0\",\"userId\":101,\"userName\":\"chuzihao\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-13 17:12:32', 106);
INSERT INTO `sys_oper_log` VALUES (222, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'chuzihao', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"请立即联系信任的人或拨打心理援助热线，你值得被倾听和帮助。\",\"content\":\"我想死，外卖被偷了，还失恋了\",\"createTime\":\"2026-01-13 17:13:53\",\"id\":32,\"moodScore\":15,\"moodTag\":\"绝望\",\"params\":{},\"userId\":101} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"请立即联系信任的人或拨打心理援助热线，你值得被倾听和帮助。\",\"content\":\"我想死，外卖被偷了，还失恋了\",\"createTime\":\"2026-01-13 17:13:53\",\"id\":32,\"moodScore\":15,\"moodTag\":\"绝望\",\"params\":{},\"userId\":101}}', 0, NULL, '2026-01-13 17:13:53', 2976);
INSERT INTO `sys_oper_log` VALUES (223, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'chuzihao', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"保持开放心态，随时准备分享你的想法或感受。\",\"content\":\"你好\",\"createTime\":\"2026-01-13 17:15:38\",\"id\":33,\"moodScore\":50,\"moodTag\":\"平静\",\"params\":{},\"userId\":101} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"保持开放心态，随时准备分享你的想法或感受。\",\"content\":\"你好\",\"createTime\":\"2026-01-13 17:15:38\",\"id\":33,\"moodScore\":50,\"moodTag\":\"平静\",\"params\":{},\"userId\":101}}', 0, NULL, '2026-01-13 17:15:38', 8615);
INSERT INTO `sys_oper_log` VALUES (224, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'chuzihao', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"享受甜食时注意适量，搭配水果或坚果更健康。\",\"content\":\"今天吃什么啊，我想吃甜食\",\"createTime\":\"2026-01-13 17:16:07\",\"id\":34,\"moodScore\":70,\"moodTag\":\"轻松/愉悦\",\"params\":{},\"userId\":101} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"享受甜食时注意适量，搭配水果或坚果更健康。\",\"content\":\"今天吃什么啊，我想吃甜食\",\"createTime\":\"2026-01-13 17:16:07\",\"id\":34,\"moodScore\":70,\"moodTag\":\"轻松/愉悦\",\"params\":{},\"userId\":101}}', 0, NULL, '2026-01-13 17:16:07', 2510);
INSERT INTO `sys_oper_log` VALUES (225, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"保持开放心态，随时准备分享你的想法或感受。\",\"content\":\"活着\",\"createTime\":\"2026-01-13 17:18:43\",\"params\":{},\"recordId\":13,\"riskLevel\":\"4\",\"studentName\":\"101\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-13 17:18:43', 10);
INSERT INTO `sys_oper_log` VALUES (226, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"保持积极心态，享受当下的快乐时光。\",\"content\":\"我今天感觉开心 😄\",\"createTime\":\"2026-01-24 21:13:22\",\"id\":35,\"moodScore\":85,\"moodTag\":\"开心\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"保持积极心态，享受当下的快乐时光。\",\"content\":\"我今天感觉开心 😄\",\"createTime\":\"2026-01-24 21:13:22\",\"id\":35,\"moodScore\":85,\"moodTag\":\"开心\",\"params\":{},\"userId\":1}}', 0, NULL, '2026-01-24 21:13:22', 2177);
INSERT INTO `sys_oper_log` VALUES (227, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"恭喜！享受这特别的一天，珍惜每一刻美好时光。\",\"content\":\"我今天要结婚喽\",\"createTime\":\"2026-01-24 21:46:34\",\"id\":36,\"moodScore\":95,\"moodTag\":\"开心\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"恭喜！享受这特别的一天，珍惜每一刻美好时光。\",\"content\":\"我今天要结婚喽\",\"createTime\":\"2026-01-24 21:46:34\",\"id\":36,\"moodScore\":95,\"moodTag\":\"开心\",\"params\":{},\"userId\":1}}', 0, NULL, '2026-01-24 21:46:34', 2029);
INSERT INTO `sys_oper_log` VALUES (228, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"金钱损失难免，别让小事影响心情，下次注意保管就好。\",\"content\":\"下午，我丢失了30块钱，有点难受\",\"createTime\":\"2026-01-24 21:51:25\",\"id\":37,\"moodScore\":60,\"moodTag\":\"失落\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"金钱损失难免，别让小事影响心情，下次注意保管就好。\",\"content\":\"下午，我丢失了30块钱，有点难受\",\"createTime\":\"2026-01-24 21:51:25\",\"id\":37,\"moodScore\":60,\"moodTag\":\"失落\",\"params\":{},\"userId\":1}}', 0, NULL, '2026-01-24 21:51:25', 2089);
INSERT INTO `sys_oper_log` VALUES (229, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 17:05:07\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-24 22:25:06', 59);
INSERT INTO `sys_oper_log` VALUES (230, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 17:05:07\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-24 22:25:30', 21);
INSERT INTO `sys_oper_log` VALUES (231, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 17:05:07\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"学生\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-24 22:25:50', 17);
INSERT INTO `sys_oper_log` VALUES (232, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 17:05:07\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"学生们\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-24 22:26:52', 16);
INSERT INTO `sys_oper_log` VALUES (233, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"roleId\":100,\"roleKey\":\"3\",\"roleName\":\"学生\",\"roleSort\":3,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-24 22:28:07', 12);
INSERT INTO `sys_oper_log` VALUES (234, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 17:05:07\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2012,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"学生们\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-24 22:28:24', 20);
INSERT INTO `sys_oper_log` VALUES (235, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 17:05:07\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2012,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"老师\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-24 22:28:45', 22);
INSERT INTO `sys_oper_log` VALUES (236, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2026-01-24 22:28:07\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"roleId\":100,\"roleKey\":\"lower\",\"roleName\":\"学生\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-24 22:28:54', 17);
INSERT INTO `sys_oper_log` VALUES (237, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2026-01-24 22:28:07\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"roleId\":100,\"roleKey\":\"lower\",\"roleName\":\"学生\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-24 22:29:02', 15);
INSERT INTO `sys_oper_log` VALUES (238, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/12/28/86d1b7d9cac048fab229b39a6582cb7b.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-12-28 12:02:34\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":104,\"deptName\":\"大数据\",\"leader\":\"刘\",\"orderNum\":2,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":104,\"email\":\"197518731@qq.com\",\"loginDate\":\"2026-01-06 20:06:28\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"杜甫\",\"params\":{},\"phonenumber\":\"17562219508\",\"postIds\":[4],\"remark\":\"厉害\",\"roleIds\":[100],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"老师\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"dufu\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-24 22:29:13', 37);
INSERT INTO `sys_oper_log` VALUES (239, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"保持这份平和，享受当下，适当放松身心。\",\"content\":\"我今天感觉平静 🙂\",\"createTime\":\"2026-01-24 22:30:32\",\"id\":38,\"moodScore\":85,\"moodTag\":\"平静\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"保持这份平和，享受当下，适当放松身心。\",\"content\":\"我今天感觉平静 🙂\",\"createTime\":\"2026-01-24 22:30:32\",\"id\":38,\"moodScore\":85,\"moodTag\":\"平静\",\"params\":{},\"userId\":1}}', 0, NULL, '2026-01-24 22:30:32', 1990);
INSERT INTO `sys_oper_log` VALUES (240, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"保持这种平和心态，享受当下，适当放松或冥想以延续好状态。\",\"content\":\"我今天感觉平静 🙂\",\"createTime\":\"2026-01-24 22:32:29\",\"id\":39,\"moodScore\":85,\"moodTag\":\"平静\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"保持这种平和心态，享受当下，适当放松或冥想以延续好状态。\",\"content\":\"我今天感觉平静 🙂\",\"createTime\":\"2026-01-24 22:32:29\",\"id\":39,\"moodScore\":85,\"moodTag\":\"平静\",\"params\":{},\"userId\":1}}', 0, NULL, '2026-01-24 22:32:29', 2231);
INSERT INTO `sys_oper_log` VALUES (241, '心理干预记录', 2, 'com.ruoyi.system.controller.SysInterventionRecordController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"珍惜这份好心情，做些喜欢的事让快乐延续。\",\"content\":\"不错，我也为你开心\",\"createTime\":\"2025-12-28 15:44:08\",\"handlerName\":\"李\",\"params\":{},\"recordId\":11,\"riskLevel\":\"1\",\"status\":\"0\",\"studentName\":\"2\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-25 13:36:10', 24);
INSERT INTO `sys_oper_log` VALUES (242, '心理干预记录', 2, 'com.ruoyi.system.controller.SysInterventionRecordController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"请立即联系信任的人或拨打心理援助热线，你值得被关爱和帮助。\",\"content\":\"快来找我\",\"createTime\":\"2025-12-28 15:41:14\",\"handlerName\":\"詹\",\"params\":{},\"recordId\":10,\"riskLevel\":\"4\",\"status\":\"0\",\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-25 13:36:27', 6);
INSERT INTO `sys_oper_log` VALUES (243, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"先处理伤口，深呼吸冷静，下雪天注意安全，别让小事影响心情。\",\"content\":\"今天下雪，走在路上滑倒了，摔倒了手指头，气死我了\",\"createTime\":\"2026-01-25 13:39:23\",\"id\":40,\"moodScore\":35,\"moodTag\":\"愤怒/沮丧\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"先处理伤口，深呼吸冷静，下雪天注意安全，别让小事影响心情。\",\"content\":\"今天下雪，走在路上滑倒了，摔倒了手指头，气死我了\",\"createTime\":\"2026-01-25 13:39:23\",\"id\":40,\"moodScore\":35,\"moodTag\":\"愤怒/沮丧\",\"params\":{},\"userId\":1}}', 0, NULL, '2026-01-25 13:39:23', 2257);
INSERT INTO `sys_oper_log` VALUES (244, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"先处理伤口，深呼吸冷静，下雪天注意安全，别让小事影响心情。\",\"content\":\"赶紧去医务室，包扎一下哦\",\"createTime\":\"2026-01-25 13:40:26\",\"params\":{},\"recordId\":14,\"riskLevel\":\"2\",\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-25 13:40:26', 12);
INSERT INTO `sys_oper_log` VALUES (245, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2026-01-24 22:28:07\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2012,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011],\"params\":{},\"roleId\":100,\"roleKey\":\"lower\",\"roleName\":\"学生\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-25 13:53:49', 46);
INSERT INTO `sys_oper_log` VALUES (246, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"先报警处理，保护现场证据，调整心态避免过度影响生活。\",\"content\":\"那老师也感到伤心，偷外卖就应该放逐\",\"createTime\":\"2026-01-25 13:55:40\",\"params\":{},\"recordId\":15,\"riskLevel\":\"2\",\"studentName\":\"100\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-25 13:55:40', 12);
INSERT INTO `sys_oper_log` VALUES (247, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/12/28/86d1b7d9cac048fab229b39a6582cb7b.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-12-28 12:02:34\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":104,\"deptName\":\"大数据\",\"leader\":\"刘\",\"orderNum\":2,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":104,\"email\":\"197518731@qq.com\",\"loginDate\":\"2026-01-25 14:12:40\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"杜甫\",\"params\":{},\"phonenumber\":\"17562219508\",\"postIds\":[4],\"remark\":\"厉害\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"lower\",\"roleName\":\"学生\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"dufu\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-25 14:37:52', 39);
INSERT INTO `sys_oper_log` VALUES (248, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/12/28/86d1b7d9cac048fab229b39a6582cb7b.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-12-28 12:02:34\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":104,\"deptName\":\"大数据\",\"leader\":\"刘\",\"orderNum\":2,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":104,\"email\":\"197518731@qq.com\",\"loginDate\":\"2026-01-25 14:57:12\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"杜甫\",\"params\":{},\"phonenumber\":\"17562219508\",\"postIds\":[4],\"remark\":\"厉害\",\"roleIds\":[100],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"老师\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"dufu\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-25 14:58:25', 52);
INSERT INTO `sys_oper_log` VALUES (249, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"gemini\",\"createTime\":\"2026-01-25 21:21:04\",\"delFlag\":\"0\",\"email\":\"\",\"loginIp\":\"\",\"nickName\":\"gemini\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2026-01-25 21:21:04\",\"roleIds\":[2],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":102,\"userName\":\"gemini\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-25 21:36:43', 34);
INSERT INTO `sys_oper_log` VALUES (250, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', '软件工程技术', '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":102} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-25 21:37:42', 73);
INSERT INTO `sys_oper_log` VALUES (251, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', '软件工程技术', '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":103} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-25 21:43:33', 74);
INSERT INTO `sys_oper_log` VALUES (252, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'dufu', '大数据', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"保持积极心态，享受当下美好时光！\",\"content\":\"我今天感觉开心 😄\",\"createTime\":\"2026-01-25 22:39:34\",\"id\":41,\"moodScore\":90,\"moodTag\":\"开心\",\"params\":{},\"userId\":100} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"保持积极心态，享受当下美好时光！\",\"content\":\"我今天感觉开心 😄\",\"createTime\":\"2026-01-25 22:39:34\",\"id\":41,\"moodScore\":90,\"moodTag\":\"开心\",\"params\":{},\"userId\":100}}', 0, NULL, '2026-01-25 22:39:34', 2467);
INSERT INTO `sys_oper_log` VALUES (253, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"先处理伤口，深呼吸冷静，下雪天注意安全，别让小事影响心情。\",\"content\":\"别摔到\",\"createTime\":\"2026-01-26 13:51:00\",\"handlerName\":\"楚\",\"params\":{},\"recordId\":16,\"riskLevel\":\"2\",\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-26 13:51:00', 16);
INSERT INTO `sys_oper_log` VALUES (254, '心理干预记录', 2, 'com.ruoyi.system.controller.SysInterventionRecordController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"先处理伤口，深呼吸冷静，下雪天注意安全，别让小事影响心情。\",\"content\":\"别摔到\",\"createTime\":\"2026-01-26 13:51:00\",\"handlerName\":\"楚\",\"params\":{},\"recordId\":16,\"riskLevel\":\"4\",\"status\":\"0\",\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-26 13:51:23', 0);
INSERT INTO `sys_oper_log` VALUES (255, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"尝试深呼吸，专注于当下，减少对未来的担忧。\",\"content\":\"我今天感觉焦虑 😫\",\"createTime\":\"2026-01-26 13:58:56\",\"id\":42,\"moodScore\":26,\"moodTag\":\"焦虑\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"尝试深呼吸，专注于当下，减少对未来的担忧。\",\"content\":\"我今天感觉焦虑 😫\",\"createTime\":\"2026-01-26 13:58:56\",\"id\":42,\"moodScore\":26,\"moodTag\":\"焦虑\",\"params\":{},\"userId\":1}}', 0, NULL, '2026-01-26 13:58:56', 3484);
INSERT INTO `sys_oper_log` VALUES (256, '心理干预记录', 2, 'com.ruoyi.system.controller.SysInterventionRecordController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"先处理伤口，深呼吸冷静，下雪天注意安全，别让小事影响心情。\",\"content\":\"别摔到\",\"createTime\":\"2026-01-26 13:51:00\",\"handlerName\":\"楚\",\"params\":{},\"recordId\":16,\"riskLevel\":\"4\",\"status\":\"1\",\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-26 14:08:42', 7);
INSERT INTO `sys_oper_log` VALUES (257, '心理干预记录', 2, 'com.ruoyi.system.controller.SysInterventionRecordController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"先报警处理，保护现场证据，调整心态避免过度影响生活。\",\"content\":\"那老师也感到伤心，偷外卖就应该放逐\",\"createTime\":\"2026-01-25 13:55:40\",\"params\":{},\"recordId\":15,\"riskLevel\":\"2\",\"status\":\"2\",\"studentName\":\"100\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-26 14:08:46', 11);
INSERT INTO `sys_oper_log` VALUES (258, '心理干预记录', 2, 'com.ruoyi.system.controller.SysInterventionRecordController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"保持开放心态，随时准备分享你的想法或感受。\",\"content\":\"活着\",\"createTime\":\"2026-01-13 17:18:43\",\"params\":{},\"recordId\":13,\"riskLevel\":\"4\",\"status\":\"3\",\"studentName\":\"101\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-26 14:08:50', 6);
INSERT INTO `sys_oper_log` VALUES (259, '心理干预记录', 2, 'com.ruoyi.system.controller.SysInterventionRecordController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"先处理伤口，深呼吸冷静，下雪天注意安全，别让小事影响心情。\",\"content\":\"赶紧去医务室，包扎一下哦\",\"createTime\":\"2026-01-25 13:40:27\",\"params\":{},\"recordId\":14,\"riskLevel\":\"2\",\"status\":\"1\",\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-26 14:08:59', 7);
INSERT INTO `sys_oper_log` VALUES (260, '心理干预记录', 2, 'com.ruoyi.system.controller.SysInterventionRecordController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"试着深呼吸，给自己一点时间休息，明天会更好。\",\"createTime\":\"2026-01-06 20:10:48\",\"handlerName\":\"21\",\"params\":{},\"recordId\":12,\"riskLevel\":\"3\",\"status\":\"2\",\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-26 14:09:06', 6);
INSERT INTO `sys_oper_log` VALUES (261, '心理干预记录', 2, 'com.ruoyi.system.controller.SysInterventionRecordController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"珍惜这份好心情，做些喜欢的事让快乐延续。\",\"content\":\"不错，我也为你开心\",\"createTime\":\"2025-12-28 15:44:08\",\"handlerName\":\"李\",\"params\":{},\"recordId\":11,\"riskLevel\":\"1\",\"status\":\"2\",\"studentName\":\"2\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-26 14:09:10', 5);
INSERT INTO `sys_oper_log` VALUES (262, '心理干预记录', 2, 'com.ruoyi.system.controller.SysInterventionRecordController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"请立即联系信任的人或拨打心理援助热线，你值得被关爱和帮助。\",\"content\":\"快来找我\",\"createTime\":\"2025-12-28 15:41:14\",\"handlerName\":\"詹\",\"params\":{},\"recordId\":10,\"riskLevel\":\"4\",\"status\":\"2\",\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-26 14:09:14', 9);
INSERT INTO `sys_oper_log` VALUES (263, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/12/28/86d1b7d9cac048fab229b39a6582cb7b.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-12-28 12:02:34\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":104,\"deptName\":\"大数据\",\"leader\":\"刘\",\"orderNum\":2,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":104,\"email\":\"197518731@qq.com\",\"loginDate\":\"2026-01-25 22:39:25\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"杜甫\",\"params\":{},\"phonenumber\":\"17562219508\",\"postIds\":[2],\"remark\":\"厉害\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"lower\",\"roleName\":\"学生\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"dufu\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-26 14:09:49', 54);
INSERT INTO `sys_oper_log` VALUES (264, '学生心情日记', 1, 'com.ruoyi.system.controller.BizMoodDiaryController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/diary', '127.0.0.1', '内网IP', '{\"aiAdvice\":\"请立即联系心理危机干预热线或信任的人，生命安全最重要。\",\"content\":\"我今天赌博输了100万，我想杀人，并带个人一起走\",\"createTime\":\"2026-01-26 15:02:11\",\"id\":43,\"moodScore\":9,\"moodTag\":\"绝望/暴力倾向\",\"params\":{},\"userId\":1} ', '{\"msg\":\"操作成功\",\"code\":200,\"data\":{\"aiAdvice\":\"请立即联系心理危机干预热线或信任的人，生命安全最重要。\",\"content\":\"我今天赌博输了100万，我想杀人，并带个人一起走\",\"createTime\":\"2026-01-26 15:02:11\",\"id\":43,\"moodScore\":9,\"moodTag\":\"绝望/暴力倾向\",\"params\":{},\"userId\":1}}', 0, NULL, '2026-01-26 15:02:11', 2929);
INSERT INTO `sys_oper_log` VALUES (265, '心理干预记录', 1, 'com.ruoyi.system.controller.SysInterventionRecordController.add()', 'POST', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"aiSuggestion\":\"请立即联系心理危机干预热线或信任的人，生命安全最重要。\",\"content\":\"唉\",\"createTime\":\"2026-01-26 15:03:35\",\"handlerName\":\"22\",\"params\":{},\"recordId\":17,\"riskLevel\":\"4\",\"status\":\"2\",\"studentName\":\"1\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-26 15:03:35', 12);
INSERT INTO `sys_oper_log` VALUES (266, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"gemini\",\"createTime\":\"2026-01-25 21:21:04\",\"delFlag\":\"0\",\"email\":\"\",\"loginDate\":\"2026-01-25 21:38:02\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"gemini\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2026-01-25 21:37:42\",\"roleIds\":[100],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"老师\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":102,\"userName\":\"gemini\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-26 15:51:22', 197);
INSERT INTO `sys_oper_log` VALUES (267, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"chatgpt\",\"createTime\":\"2026-01-25 21:38:32\",\"delFlag\":\"0\",\"email\":\"\",\"loginDate\":\"2026-01-25 22:33:56\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"chatgpt\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2026-01-25 21:43:33\",\"roleIds\":[100],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":103,\"userName\":\"chatgpt\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-26 15:51:26', 18);
INSERT INTO `sys_oper_log` VALUES (268, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/12/28/86d1b7d9cac048fab229b39a6582cb7b.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-12-28 12:02:34\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":104,\"deptName\":\"大数据\",\"leader\":\"刘\",\"orderNum\":2,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":104,\"email\":\"197518731@qq.com\",\"loginDate\":\"2026-01-26 16:37:16\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"杜甫\",\"params\":{},\"phonenumber\":\"17562219508\",\"postIds\":[2],\"remark\":\"厉害\",\"roleIds\":[100],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"老师\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"dufu\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-26 16:40:37', 54);
INSERT INTO `sys_oper_log` VALUES (269, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"/profile/avatar/2025/12/28/86d1b7d9cac048fab229b39a6582cb7b.jpg\",\"createBy\":\"admin\",\"createTime\":\"2025-12-28 12:02:34\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":104,\"deptName\":\"大数据\",\"leader\":\"刘\",\"orderNum\":2,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":104,\"email\":\"197518731@qq.com\",\"loginDate\":\"2026-01-26 16:37:16\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"杜甫\",\"params\":{},\"phonenumber\":\"17562219508\",\"postIds\":[4,3],\"remark\":\"厉害\",\"roleIds\":[100],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"lower\",\"roleName\":\"学生\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"dufu\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-26 16:40:44', 30);
INSERT INTO `sys_oper_log` VALUES (270, '心理干预记录', 2, 'com.ruoyi.system.controller.SysInterventionRecordController.edit()', 'PUT', 1, 'admin', '软件工程技术', '/system/record', '127.0.0.1', '内网IP', '{\"content\":\"唉\\n【系统提醒】学生于 2026-01-27 15:29:51 点击了“预约咨询”，请及时联系。\",\"params\":{},\"recordId\":17,\"status\":\"0\"} ', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 15:29:52', 16);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '高级人员', 1, '0', 'admin', '2025-12-23 17:05:07', 'admin', '2025-12-28 12:08:00', '');
INSERT INTO `sys_post` VALUES (2, 'se', '老师', 2, '0', 'admin', '2025-12-23 17:05:07', 'admin', '2025-12-28 12:03:51', '');
INSERT INTO `sys_post` VALUES (3, 'hr', '班委', 3, '0', 'admin', '2025-12-23 17:05:07', 'admin', '2025-12-28 12:04:09', '');
INSERT INTO `sys_post` VALUES (4, 'user', '学生', 4, '0', 'admin', '2025-12-23 17:05:07', 'admin', '2025-12-28 12:04:16', '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-12-23 17:05:07', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '老师', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-12-23 17:05:07', 'admin', '2026-01-24 22:28:45', '普通角色');
INSERT INTO `sys_role` VALUES (100, '学生', 'lower', 3, '1', 1, 1, '0', '0', 'admin', '2026-01-24 22:28:07', 'admin', '2026-01-25 13:53:49', NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 2000);
INSERT INTO `sys_role_menu` VALUES (2, 2001);
INSERT INTO `sys_role_menu` VALUES (2, 2002);
INSERT INTO `sys_role_menu` VALUES (2, 2003);
INSERT INTO `sys_role_menu` VALUES (2, 2004);
INSERT INTO `sys_role_menu` VALUES (2, 2005);
INSERT INTO `sys_role_menu` VALUES (2, 2006);
INSERT INTO `sys_role_menu` VALUES (2, 2007);
INSERT INTO `sys_role_menu` VALUES (2, 2008);
INSERT INTO `sys_role_menu` VALUES (2, 2009);
INSERT INTO `sys_role_menu` VALUES (2, 2010);
INSERT INTO `sys_role_menu` VALUES (2, 2011);
INSERT INTO `sys_role_menu` VALUES (2, 2012);
INSERT INTO `sys_role_menu` VALUES (100, 2000);
INSERT INTO `sys_role_menu` VALUES (100, 2001);
INSERT INTO `sys_role_menu` VALUES (100, 2002);
INSERT INTO `sys_role_menu` VALUES (100, 2003);
INSERT INTO `sys_role_menu` VALUES (100, 2004);
INSERT INTO `sys_role_menu` VALUES (100, 2005);
INSERT INTO `sys_role_menu` VALUES (100, 2006);
INSERT INTO `sys_role_menu` VALUES (100, 2007);
INSERT INTO `sys_role_menu` VALUES (100, 2008);
INSERT INTO `sys_role_menu` VALUES (100, 2009);
INSERT INTO `sys_role_menu` VALUES (100, 2010);
INSERT INTO `sys_role_menu` VALUES (100, 2011);
INSERT INTO `sys_role_menu` VALUES (100, 2012);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime(0) NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime(0) NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 107 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '詹先生', '00', '2122185201@qq.com', '19063414363', '0', '/profile/avatar/2025/12/28/77e22c6917ad4ebf8745be072291957d.jpg', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2026-01-27 15:07:52', '2025-12-23 17:05:07', 'admin', '2025-12-23 17:05:07', '', '2025-12-28 12:07:24', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '2', '127.0.0.1', '2025-12-23 17:05:07', '2025-12-23 17:05:07', 'admin', '2025-12-23 17:05:07', '', NULL, '测试员');
INSERT INTO `sys_user` VALUES (100, 104, 'dufu', '杜甫', '00', '197518731@qq.com', '17562219508', '0', '/profile/avatar/2025/12/28/86d1b7d9cac048fab229b39a6582cb7b.jpg', '$2a$10$w/qptYM.MCyb0gVaW2n3TeVC0Tqgr7jndmUpbQ9T99toynRVSorTK', '0', '0', '127.0.0.1', '2026-01-27 15:36:19', NULL, 'admin', '2025-12-28 12:02:34', 'admin', '2026-01-26 16:40:44', '厉害');
INSERT INTO `sys_user` VALUES (101, 103, 'chuzihao', '浩先生', '00', 'chuzihao250@gmail.com', '15553061621', '2', '', '$2a$10$SQkm0XE2qBzDshVdU9rgNebW6bqyAG8Vc57imG65Y.STthsxz6Swy', '0', '0', '127.0.0.1', '2026-01-13 17:13:12', NULL, 'admin', '2026-01-13 17:12:32', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (102, NULL, 'gemini', 'gemini', '00', '', '', '0', '', '$2a$10$R9HSqfk1QUR89tlE86v.sOGrZmjtgUifpnl4iFGNYPzZOCvu.5Xxi', '0', '0', '127.0.0.1', '2026-01-25 21:38:02', '2026-01-25 21:37:42', 'gemini', '2026-01-25 21:21:04', 'admin', '2026-01-26 15:51:22', NULL);
INSERT INTO `sys_user` VALUES (103, NULL, 'chatgpt', 'chatgpt', '00', '', '', '0', '', '$2a$10$Xjdwl9w7u4TO734xJpgdM.gha/FcZ3xH/8ZQymDfowcg39ZBD8UBi', '0', '0', '127.0.0.1', '2026-01-25 22:33:56', '2026-01-25 21:43:33', 'chatgpt', '2026-01-25 21:38:32', 'admin', '2026-01-26 15:51:26', NULL);
INSERT INTO `sys_user` VALUES (104, NULL, 'xiaoxian', 'xiaoxian', '00', '', '', '0', '', '$2a$10$qzJYSDWCCweKSBG6DZyFHOq4oJfmQ3aZCsFcc0CQ6esqFSQO84gp.', '0', '0', '', NULL, '2026-01-25 21:44:09', 'xiaoxian', '2026-01-25 21:44:08', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (105, NULL, 'test_debug', 'test_debug', '00', '', '', '0', '', '$2a$10$aA7DBHfE18ajPVZf5K/qienue.zwVICKo4sk9K1TUqTvqpZjPScQq', '0', '0', '127.0.0.1', '2026-01-25 22:07:31', '2026-01-25 22:07:21', 'test_debug', '2026-01-25 22:07:21', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (106, NULL, 'test_debug2', 'test_debug2', '00', '', '', '0', '', '$2a$10$0SWuY2imSLKVHh7.WmLYLeOANnboMIU1gSQQ1gnV7N1il.qqwPuIW', '0', '0', '127.0.0.1', '2026-01-25 22:29:36', '2026-01-25 22:29:24', 'test_debug2', '2026-01-25 22:29:24', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (100, 3);
INSERT INTO `sys_user_post` VALUES (100, 4);
INSERT INTO `sys_user_post` VALUES (101, 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (100, 100);
INSERT INTO `sys_user_role` VALUES (101, 2);
INSERT INTO `sys_user_role` VALUES (102, 100);
INSERT INTO `sys_user_role` VALUES (103, 100);
INSERT INTO `sys_user_role` VALUES (106, 100);

SET FOREIGN_KEY_CHECKS = 1;
