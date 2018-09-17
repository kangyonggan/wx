
DROP DATABASE IF EXISTS ck;

CREATE DATABASE ck
  DEFAULT CHARACTER SET utf8
  COLLATE utf8_general_ci;

USE ck;

-- ----------------------------
--  Table structure for tb_user
-- ----------------------------
DROP TABLE
IF EXISTS tb_user;

CREATE TABLE tb_user
(
  user_id      BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '用户ID',
  mobile_no    VARCHAR(20)                           NOT NULL
  COMMENT '手机号',
  password     VARCHAR(64)                           NOT NULL
  COMMENT '密码',
  salt         VARCHAR(64)                           NOT NULL
  COMMENT '密码盐',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '用户表';
CREATE UNIQUE INDEX mobile_no_UNIQUE
  ON tb_user (mobile_no);

-- ----------------------------
--  Table structure for tb_user_profile
-- ----------------------------
DROP TABLE
IF EXISTS tb_user_profile;

CREATE TABLE tb_user_profile
(
  user_id      BIGINT(20)   NOT NULL
  COMMENT '用户ID',
  email        VARCHAR(64)  NOT NULL                    DEFAULT ''
  COMMENT '电子邮件',
  email_valid  TINYINT      NOT NULL                    DEFAULT 0
  COMMENT '邮件是否验证:{0:未验证, 1:已验证}',
  name         VARCHAR(32)  NOT NULL                    DEFAULT ''
  COMMENT '姓名',
  id_type      VARCHAR(1)   NOT NULL                    DEFAULT ''
  COMMENT '证件类型',
  id_no        VARCHAR(128) NOT NULL                    DEFAULT ''
  COMMENT '证件号码',
  ip_addr      VARCHAR(20)  NOT NULL                    DEFAULT ''
  COMMENT 'IP地址',
  skin         VARCHAR(20)  NOT NULL                    DEFAULT ''
  COMMENT '皮肤',
  is_deleted   TINYINT      NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP    NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP    NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '用户信息表';
CREATE UNIQUE INDEX user_id_UNIQUE
  ON tb_user (user_id);

-- ----------------------------
--  Table structure for tb_role
-- ----------------------------
DROP TABLE
IF EXISTS tb_role;

CREATE TABLE tb_role
(
  role_id      BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  role_code    VARCHAR(32)                           NOT NULL
  COMMENT '角色代码',
  role_name    VARCHAR(32)                           NOT NULL
  COMMENT '角色名称',
  is_deleted   TINYINT                               NOT NULL                DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '角色表';
CREATE UNIQUE INDEX role_code_UNIQUE
  ON tb_role (role_code);

-- ----------------------------
--  Table structure for tb_menu
-- ----------------------------
DROP TABLE
IF EXISTS tb_menu;

CREATE TABLE tb_menu
(
  menu_id      BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  menu_code    VARCHAR(32)                           NOT NULL
  COMMENT '菜单代码',
  menu_name    VARCHAR(32)                           NOT NULL
  COMMENT '菜单名称',
  parent_code  VARCHAR(32)                           NOT NULL                DEFAULT ''
  COMMENT '父菜单代码',
  url          VARCHAR(128)                          NOT NULL                DEFAULT ''
  COMMENT '菜单地址',
  sort         INT(11)                               NOT NULL                DEFAULT 0
  COMMENT '菜单排序(从0开始)',
  icon         VARCHAR(128)                          NOT NULL                DEFAULT ''
  COMMENT '菜单图标的样式',
  is_deleted   TINYINT                               NOT NULL                DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '菜单表';
CREATE INDEX sort_ix
  ON tb_menu (sort);
CREATE UNIQUE INDEX menu_code_UNIQUE
  ON tb_menu (menu_code);

-- ----------------------------
--  Table structure for tb_user_role
-- ----------------------------
DROP TABLE
IF EXISTS tb_user_role;

CREATE TABLE tb_user_role
(
  user_id BIGINT(20) NOT NULL
  COMMENT '用户ID',
  role_id BIGINT(20) NOT NULL
  COMMENT '角色ID',
  PRIMARY KEY (user_id, role_id)
)
  COMMENT '用户角色表';

-- ----------------------------
--  Table structure for rtb_ole_menu
-- ----------------------------
DROP TABLE
IF EXISTS tb_role_menu;

CREATE TABLE tb_role_menu
(
  role_id BIGINT(20) NOT NULL
  COMMENT '角色ID',
  menu_id BIGINT(20) NOT NULL
  COMMENT '菜单ID',
  PRIMARY KEY (role_id, menu_id)
)
  COMMENT '角色菜单表';

-- ----------------------------
--  Table structure for tb_dict
-- ----------------------------
DROP TABLE
IF EXISTS tb_dict;

CREATE TABLE tb_dict
(
  dict_id      BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '字典ID',
  dict_type    VARCHAR(20)                           NOT NULL
  COMMENT '字典类型',
  dict_code    VARCHAR(64)                           NOT NULL
  COMMENT '字典代码',
  value        VARCHAR(256)                          NOT NULL
  COMMENT '值',
  remark       VARCHAR(256)                          NOT NULL                    DEFAULT ''
  COMMENT '备注',
  sort         INT(11)                               NOT NULL                    DEFAULT 0
  COMMENT '排序（从0开始）',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '字典表';
CREATE UNIQUE INDEX type_code_UNIQUE
  ON tb_dict (dict_type, dict_code);

-- ----------------------------
--  Table structure for tb_sms
-- ----------------------------
DROP TABLE
IF EXISTS tb_sms;

CREATE TABLE tb_sms
(
  sms_id       BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '短信ID',
  mobile_no    VARCHAR(20)                           NOT NULL
  COMMENT '手机号',
  code         VARCHAR(64)                           NOT NULL                    DEFAULT ''
  COMMENT '验证码',
  type         VARCHAR(16)                           NOT NULL                    DEFAULT ''
  COMMENT '短信类型',
  ip_addr      VARCHAR(20)                           NOT NULL                    DEFAULT ''
  COMMENT 'IP地址',
  request_id   VARCHAR(64)                           NOT NULL                    DEFAULT ''
  COMMENT '平台流水',
  resp_co      VARCHAR(64)                           NOT NULL                    DEFAULT ''
  COMMENT '响应码',
  resp_msg     VARCHAR(256)                          NOT NULL                    DEFAULT ''
  COMMENT '响应码描述',
  mer_resp_co  VARCHAR(64)                           NOT NULL                    DEFAULT ''
  COMMENT '商户响应码',
  mer_resp_msg VARCHAR(256)                          NOT NULL                    DEFAULT ''
  COMMENT '商户响应码描述',
  resp_data    VARCHAR(2048)                         NOT NULL                    DEFAULT ''
  COMMENT '响应数据',
  send_st      CHAR(1)                               NOT NULL                    DEFAULT 'N'
  COMMENT '发送状态:{N: 未知，Y:成功，F:失败,E:异常}',
  is_debug     TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '是否调试:{0:否, 1:是}',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '短信表';
CREATE INDEX ix_mobile_no_type
  ON tb_sms (mobile_no, type);
CREATE INDEX ix_send_st
  ON tb_sms (send_st);

-- ----------------------------
--  Table structure for tb_email
-- ----------------------------
DROP TABLE
IF EXISTS tb_email;

CREATE TABLE tb_email
(
  email_id     BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '邮件ID',
  user_id      BIGINT(20)                            NOT NULL                    DEFAULT 0
  COMMENT '用户ID',
  name         VARCHAR(32)                           NOT NULL                    DEFAULT ''
  COMMENT '姓名',
  url          VARCHAR(256)                          NOT NULL                    DEFAULT ''
  COMMENT '链接',
  subject      VARCHAR(64)                           NOT NULL                    DEFAULT ''
  COMMENT '标题',
  is_html      TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '是否是html',
  from_email   VARCHAR(64)                           NOT NULL                    DEFAULT ''
  COMMENT '发送方',
  to_email     VARCHAR(64)                           NOT NULL                    DEFAULT ''
  COMMENT '接收方',
  type         VARCHAR(16)                           NOT NULL                    DEFAULT ''
  COMMENT '邮件类型',
  ip_addr      VARCHAR(20)                           NOT NULL                    DEFAULT ''
  COMMENT 'IP地址',
  token        VARCHAR(64)                           NOT NULL                    DEFAULT ''
  COMMENT '令牌',
  content      LONGTEXT
  COMMENT '邮件内容',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '邮件表';
CREATE INDEX token_UNIQUE
  ON tb_email (token);
CREATE INDEX ix_type
  ON tb_email (type);

-- ----------------------------
--  Table structure for tb_login_log
-- ----------------------------
DROP TABLE
IF EXISTS tb_login_log;

CREATE TABLE tb_login_log
(
  login_id     BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '登录ID',
  user_id      BIGINT(20)                            NOT NULL
  COMMENT '用户ID',
  mobile_no    VARCHAR(32)                           NOT NULL
  COMMENT '手机号',
  ip_addr      VARCHAR(20)                           NOT NULL                    DEFAULT ''
  COMMENT '登录IP',
  app_source   VARCHAR(3)                            NOT NULL                    DEFAULT ''
  COMMENT '应用来源',
  jsessionid   VARCHAR(64)                           NOT NULL                    DEFAULT ''
  COMMENT 'jsessionid',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '登录日志表';
CREATE INDEX ix_mobile_no
  ON tb_login_log (mobile_no);

-- ----------------------------
--  Table structure for tb_game
-- ----------------------------
DROP TABLE
IF EXISTS tb_game;

CREATE TABLE tb_game
(
  game_id      BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '对局ID',
  region_no    INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '大区编号',
  game_type    INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '比赛类别',
  map_code     INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '地图',
  victory_team TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '胜利队伍',
  begin_time   BIGINT(20)                            NOT NULL                    DEFAULT 0
  COMMENT '开始时间',
  end_time     BIGINT(20)                            NOT NULL                    DEFAULT 0
  COMMENT '结束时间',
  source_ip    VARCHAR(20)                           NOT NULL                    DEFAULT ''
  COMMENT '来源IP',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '对局表';
CREATE INDEX ix_game_type
  ON tb_game (game_type);
CREATE INDEX ix_map_code
  ON tb_game (map_code);

-- ----------------------------
--  Table structure for tb_record
-- ----------------------------
DROP TABLE
IF EXISTS tb_record;

CREATE TABLE tb_record
(
  record_id    BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '记录ID',
  game_id      BIGINT(20)                            NOT NULL
  COMMENT '对局ID',
  mobile_no    VARCHAR(20)                           NOT NULL                    DEFAULT ''
  COMMENT '手机号',
  racer        VARCHAR(32)                           NOT NULL                    DEFAULT ''
  COMMENT '参赛车手',
  car_no       INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '车辆编号',
  team         TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '队伍',
  rank         INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '名次',
  score        INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '成绩',
  exp          INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '经验',
  coin         INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '金币',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '记录表';
CREATE INDEX ix_score
  ON tb_record (score);

-- ----------------------------
--  Table structure for tb_game_his
-- ----------------------------
DROP TABLE
IF EXISTS tb_game_his;

CREATE TABLE tb_game_his
(
  game_id      BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '对局ID',
  region_no    INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '大区编号',
  game_type    INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '比赛类别',
  map_code     INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '地图',
  victory_team TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '胜利队伍',
  begin_time   BIGINT(20)                            NOT NULL                    DEFAULT 0
  COMMENT '开始时间',
  end_time     BIGINT(20)                            NOT NULL                    DEFAULT 0
  COMMENT '结束时间',
  source_ip    VARCHAR(20)                           NOT NULL                    DEFAULT ''
  COMMENT '来源IP',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '对局表';
CREATE INDEX ix_game_type
  ON tb_game_his (game_type);
CREATE INDEX ix_map_code
  ON tb_game_his (map_code);

-- ----------------------------
--  Table structure for tb_record_his
-- ----------------------------
DROP TABLE
IF EXISTS tb_record_his;

CREATE TABLE tb_record_his
(
  record_id    BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '记录ID',
  game_id      BIGINT(20)                            NOT NULL
  COMMENT '对局ID',
  mobile_no    VARCHAR(20)                           NOT NULL                    DEFAULT ''
  COMMENT '手机号',
  racer        VARCHAR(32)                           NOT NULL                    DEFAULT ''
  COMMENT '参赛车手',
  car_no       INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '车辆编号',
  team         TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '队伍',
  rank         INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '名次',
  score        INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '成绩',
  exp          INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '经验',
  coin         INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '金币',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '记录表';
CREATE INDEX ix_score
  ON tb_record_his (score);

-- ----------------------------
--  Table structure for tb_channel
-- ----------------------------
DROP TABLE
IF EXISTS tb_channel;

CREATE TABLE tb_channel
(
  channel_id   BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '通道ID',
  channel_no   CHAR(3)                               NOT NULL
  COMMENT '通道编号',
  channel_name VARCHAR(32)                           NOT NULL
  COMMENT '通道名称',
  pause_begin  TIMESTAMP                             NULL
  COMMENT '暂停开始时间',
  pause_end    TIMESTAMP                             NULL
  COMMENT '暂停结束时间',
  pause_reason VARCHAR(200)                          NOT NULL                    DEFAULT ''
  COMMENT '暂停文案',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '通道表';
CREATE UNIQUE INDEX channel_no_UNIQUE
  ON tb_channel (channel_no);

-- ----------------------------
--  Table structure for tb_tran
-- ----------------------------
DROP TABLE
IF EXISTS tb_tran;

CREATE TABLE tb_tran
(
  tran_id      BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '交易ID',
  channel_no   CHAR(3)                               NOT NULL
  COMMENT '通道编号',
  tran_co      CHAR(3)                               NOT NULL
  COMMENT '交易代码',
  tran_name    VARCHAR(32)                           NOT NULL
  COMMENT '交易名称',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '通道表';
CREATE UNIQUE INDEX channel_tran_UNIQUE
  ON tb_tran (channel_no, tran_co);

-- ----------------------------
--  Table structure for tb_command
-- ----------------------------
DROP TABLE
IF EXISTS tb_command;

CREATE TABLE tb_command
(
  command_id   BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '指令ID',
  channel_no   CHAR(3)                               NOT NULL
  COMMENT '通道编号',
  accept_mode  CHAR(2)                               NOT NULL
  COMMENT '请求方式',
  serial_no    CHAR(32)                              NOT NULL
  COMMENT '流水号',
  user_id      BIGINT(20)                            NOT NULL
  COMMENT '用户号',
  tran_date    CHAR(8)                               NOT NULL
  COMMENT '交易日期',
  tran_time    CHAR(6)                               NOT NULL
  COMMENT '交易时间',
  tran_co      CHAR(3)                               NOT NULL
  COMMENT '交易代码',
  product_co   VARCHAR(3)                            NOT NULL                    DEFAULT ''
  COMMENT '产品代码',
  client_ip    VARCHAR(20)                           NOT NULL                    DEFAULT ''
  COMMENT 'IP地址',
  cur_co       VARCHAR(3)                            NOT NULL                    DEFAULT ''
  COMMENT '币种',
  amount       DECIMAL(16, 2)                        NOT NULL                    DEFAULT 0
  COMMENT '交易金额',
  tran_remark  VARCHAR(320)                          NOT NULL                    DEFAULT ''
  COMMENT '交易附言',
  ref_app_no   VARCHAR(32)                           NOT NULL                    DEFAULT ''
  COMMENT '申请编号',
  app_source   VARCHAR(3)                            NOT NULL                    DEFAULT ''
  COMMENT '应用来源',
  qry_count    INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '查询次数',
  lock_st      VARCHAR(8)                            NOT NULL
  COMMENT '锁状态 N-未上锁，Lxx-交易锁，Qxx-查询锁',
  tran_st      VARCHAR(1)                            NOT NULL                    DEFAULT 'N'
  COMMENT '交易状态 N-待处理，Y-成功，F-失败，I-处理中，E-异常',
  reverse_st   VARCHAR(1)                            NOT NULL                    DEFAULT 'N'
  COMMENT '冲正状态 N-未冲正，Y-已冲正',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '指令表';
CREATE UNIQUE INDEX serial_no_UNIQUE
  ON tb_command (serial_no);
CREATE INDEX ix_tran_co
  ON tb_command (tran_co);
CREATE INDEX ix_tran_st
  ON tb_command (tran_st);

-- ----------------------------
--  Table structure for tb_resp_rel
-- ----------------------------
DROP TABLE
IF EXISTS tb_resp_rel;

CREATE TABLE tb_resp_rel
(
  resp_rel_id  BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '响应码关系ID',
  channel_no   CHAR(3)                               NOT NULL
  COMMENT '通道编号',
  resp_co      VARCHAR(64)                           NOT NULL                    DEFAULT ''
  COMMENT '响应码',
  resp_msg     VARCHAR(1000)                         NOT NULL                    DEFAULT ''
  COMMENT '响应消息',
  mer_resp_co  VARCHAR(64)                           NOT NULL                    DEFAULT ''
  COMMENT '商户响应码',
  mer_resp_msg VARCHAR(1000)                         NOT NULL                    DEFAULT ''
  COMMENT '商户响应消息',
  tran_st      VARCHAR(1)                            NOT NULL                    DEFAULT ''
  COMMENT '交易状态 Y-成功，F-失败，I-处理中，E-异常',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '响应码关系表';
CREATE UNIQUE INDEX channel_resp_UNIQUE
  ON tb_resp_rel (channel_no, resp_co);

-- ----------------------------
--  Table structure for tb_respond
-- ----------------------------
DROP TABLE
IF EXISTS tb_respond;

CREATE TABLE tb_respond
(
  respond_id     BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '响应ID',
  channel_no     CHAR(3)                               NOT NULL
  COMMENT '通道编号',
  serial_no      CHAR(32)                              NOT NULL
  COMMENT '流水号',
  resp_date      CHAR(8)                               NOT NULL                    DEFAULT ''
  COMMENT '响应日期',
  resp_time      CHAR(6)                               NOT NULL                    DEFAULT ''
  COMMENT '响应时间',
  tran_co        CHAR(3)                               NOT NULL                    DEFAULT ''
  COMMENT '交易代码',
  amount         DECIMAL(16, 2)                        NOT NULL                    DEFAULT 0
  COMMENT '交易金额',
  success_amount DECIMAL(16, 2)                        NOT NULL                    DEFAULT 0
  COMMENT '成功金额',
  resp_co        VARCHAR(20)                           NOT NULL                    DEFAULT ''
  COMMENT '响应码',
  resp_msg       VARCHAR(1000)                         NOT NULL                    DEFAULT ''
  COMMENT '响应消息',
  mer_resp_co    VARCHAR(20)                           NOT NULL                    DEFAULT ''
  COMMENT '商户响应码',
  mer_resp_msg   VARCHAR(1000)                         NOT NULL                    DEFAULT ''
  COMMENT '商户响应消息',
  tran_st        VARCHAR(1)                            NOT NULL                    DEFAULT ''
  COMMENT '交易状态 Y-成功，F-失败，I-处理中，E-异常',
  is_deleted     TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time   TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time   TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '响应表';
CREATE INDEX ix_serial_no
  ON tb_respond (serial_no);

-- ----------------------------
--  Table structure for tb_category
-- ----------------------------
DROP TABLE
IF EXISTS tb_category;

CREATE TABLE tb_category
(
  category_id   BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '栏目ID',
  category_code VARCHAR(20)                           NOT NULL
  COMMENT '栏目代码',
  category_name VARCHAR(20)                           NOT NULL
  COMMENT '栏目名称',
  sort         INT(11)                               NOT NULL                DEFAULT 0
  COMMENT '栏目排序(从0开始)',
  is_deleted    TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time  TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time  TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '栏目表';
CREATE UNIQUE INDEX category_code_UNIQUE
  ON tb_category (category_code);

-- ----------------------------
--  Table structure for tb_article
-- ----------------------------
DROP TABLE
IF EXISTS tb_article;

CREATE TABLE tb_article
(
  article_id      BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '文章ID',
  category_code   VARCHAR(20)                           NOT NULL
  COMMENT '栏目代码',
  title           VARCHAR(128)                          NOT NULL
  COMMENT '标题',
  summary         VARCHAR(256)                          NOT NULL                    DEFAULT ''
  COMMENT '摘要',
  content         LONGTEXT                              NOT NULL
  COMMENT '文章内容',
  hits            INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '阅读量',
  created_user_id BIGINT(20)                            NOT NULL
  COMMENT '创建人',
  status          VARCHAR(32)                           NOT NULL                    DEFAULT ''
  COMMENT '状态',
  is_deleted      TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time    TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time    TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '文章表';
CREATE INDEX ix_category_code
  ON tb_article (category_code);

-- ----------------------------
--  Table structure for tb_user_info
-- ----------------------------
DROP TABLE
IF EXISTS tb_user_info;

CREATE TABLE tb_user_info
(
  user_id        BIGINT(20)   NOT NULL
  COMMENT '用户ID',
  nick_name      VARCHAR(20)  NOT NULL                    DEFAULT ''
  COMMENT '昵称',
  avatar         VARCHAR(128) NOT NULL                    DEFAULT ''
  COMMENT '头像',
  gender         CHAR(1)      NOT NULL                    DEFAULT 'N'
  COMMENT '性别：{M: 男，F: 女，N: 未知}',
  coin           INTEGER      NOT NULL                    DEFAULT 100
  COMMENT '金币',
  exp            INTEGER      NOT NULL                    DEFAULT 0
  COMMENT '经验',
  level          INTEGER      NOT NULL                    DEFAULT 0
  COMMENT '等级',
  sign_days      INTEGER      NOT NULL                    DEFAULT 0
  COMMENT '累计签到天数',
  last_sign_date CHAR(8)      NOT NULL                    DEFAULT ''
  COMMENT '最后签到日期',
  is_deleted     TINYINT      NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time   TIMESTAMP    NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time   TIMESTAMP    NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '用户信息表';

-- ----------------------------
--  Table structure for tb_forum
-- ----------------------------
DROP TABLE
IF EXISTS tb_forum;

CREATE TABLE tb_forum
(
  forum_id        BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '版块ID',
  forum_name      VARCHAR(20)                           NOT NULL
  COMMENT '版块名称',
  parent_forum_id BIGINT(20)                            NOT NULL                    DEFAULT 0
  COMMENT '父版块ID',
  admin_user_id   BIGINT(20)                            NOT NULL                    DEFAULT 0
  COMMENT '版主ID',
  sort            INT(11)                               NOT NULL                    DEFAULT 0
  COMMENT '排序(从0开始)',
  is_deleted      TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time    TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time    TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '版块表';

-- ----------------------------
--  Table structure for tb_topic
-- ----------------------------
DROP TABLE
IF EXISTS tb_topic;

CREATE TABLE tb_topic
(
  topic_id          BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '帖子ID',
  forum_id          BIGINT(20)                            NOT NULL
  COMMENT '版块ID',
  title             VARCHAR(64)                           NOT NULL
  COMMENT '标题',
  title_highlight   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '标题高亮',
  content           LONGTEXT                              NOT NULL
  COMMENT '内容',
  is_stick          TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '是否置顶',
  stick_expire_date TIMESTAMP                             NULL
  COMMENT '置顶过期时间',
  up_num            INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '顶数量',
  down_num          INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '踩数量',
  read_num          INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '阅读数量',
  user_id           BIGINT(20)                            NOT NULL                    DEFAULT 0
  COMMENT '发帖人ID',
  is_deleted        TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time      TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time      TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '帖子表';
CREATE INDEX ix_forum_id
  ON tb_topic (forum_id);

-- ----------------------------
--  Table structure for tb_reply
-- ----------------------------
DROP TABLE
IF EXISTS tb_reply;

CREATE TABLE tb_reply
(
  reply_id        BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '回复ID',
  topic_id        BIGINT(20)                            NOT NULL
  COMMENT '帖子ID',
  parent_reply_id BIGINT(20)                            NOT NULL                    DEFAULT 0
  COMMENT '父回复ID',
  content         LONGTEXT                              NOT NULL
  COMMENT '内容',
  up_num          INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '顶数量',
  down_num        INTEGER                               NOT NULL                    DEFAULT 0
  COMMENT '踩数量',
  user_id         BIGINT(20)                            NOT NULL                    DEFAULT 0
  COMMENT '回复人ID',
  is_deleted      TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time    TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time    TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '回复表';
CREATE INDEX ix_topic_id
  ON tb_reply (topic_id);

-- ----------------------------
--  Table structure for tb_error_log
-- ----------------------------
DROP TABLE
IF EXISTS tb_error_log;

CREATE TABLE tb_error_log
(
  error_id     BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '异常ID',
  mobile_no    VARCHAR(32)                           NOT NULL                    DEFAULT ''
  COMMENT '手机号',
  source_ip    VARCHAR(20)                           NOT NULL                    DEFAULT ''
  COMMENT '来源IP',
  app_source   VARCHAR(3)                            NOT NULL                    DEFAULT ''
  COMMENT '应用来源',
  err_msg      LONGTEXT                              NOT NULL
  COMMENT '异常信息',
  is_deleted   TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '逻辑删除:{0:未删除, 1:已删除}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '异常日志表';
CREATE INDEX ix_mobile_no
  ON tb_error_log (mobile_no);
CREATE INDEX ix_app_source
  ON tb_error_log (app_source);

#====================初始数据====================#

-- ----------------------------
--  data for tb_user
-- ----------------------------
INSERT INTO tb_user
(user_id, mobile_no, PASSWORD, salt)
VALUES
  # 密码：11111111
  (1, '18888888888', '8d0d54520fe0466ac80827d9f2f038b22e3c7c2d', 'd820c214488d7c6f');

INSERT INTO tb_user_profile
(user_id, email, email_valid, name, id_type, id_no, ip_addr)
VALUES
  (1, '', 0, '管理员', '0', '', '127.0.0.1');

INSERT INTO tb_user_info
(user_id, nick_name, avatar) VALUES (1, '管理员', 'app/images/logo.png');

-- ----------------------------
--  data for tb_role
-- ----------------------------
INSERT INTO tb_role
(role_id, role_code, role_name)
VALUES
  (1, 'ROLE_ADMIN', '管理员'),
  (2, 'ROLE_FORUM', '版主');

-- ----------------------------
--  data for tb_menu
-- ----------------------------
INSERT INTO tb_menu
(menu_id, menu_code, menu_name, parent_code, url, sort, icon)
VALUES
  (1, 'DASHBOARD', '工作台', '', 'dashboard', 0, 'menu-icon fa fa-dashboard'),

  (10, 'SYSTEM', '系统', '', '', 1, 'menu-icon fa fa-cogs'),
  (11, 'SYSTEM_USER', '用户管理', 'SYSTEM', 'dashboard/system/user', 0, ''),
  (12, 'SYSTEM_ROLE', '角色管理', 'SYSTEM', 'dashboard/system/role', 1, ''),
  (13, 'SYSTEM_MENU', '菜单管理', 'SYSTEM', 'dashboard/system/menu', 2, ''),

  (20, 'CONTENT', '内容', '', '', 2, 'menu-icon fa fa-folder-open-o'),
  (21, 'CONTENT_DICT', '字典管理', 'CONTENT', 'dashboard/content/dict', 0, ''),

  (30, 'QUERY', '查询', '', '', 3, 'menu-icon fa fa-laptop'),
  (31, 'QUERY_SMS', '短信查询', 'QUERY', 'dashboard/query/sms', 0, ''),
  (32, 'QUERY_EMAIL', '邮件查询', 'QUERY', 'dashboard/query/email', 1, ''),
  (33, 'QUERY_LOGIN', '登录日志查询', 'QUERY', 'dashboard/query/login', 2, ''),
  (34, 'QUERY_GAME', '对局记录查询', 'QUERY', 'dashboard/query/game', 3, ''),
  (35, 'QUERY_ERROR', '异常日志查询', 'QUERY', 'dashboard/query/error', 4, ''),

  (40, 'SITES', '网站', '', '', 4, 'menu-icon fa fa-globe'),
  (41, 'SITES_CATEGORY', '栏目管理', 'SITES', 'dashboard/sites/category', 0, ''),
  (42, 'SITES_ARTICLE', '文章管理', 'SITES', 'dashboard/sites/article', 1, ''),
  (43, 'SITES_FORUM', '版块管理', 'SITES', 'dashboard/sites/forum', 2, ''),
  (44, 'SITES_TOPIC', '帖子管理', 'SITES', 'dashboard/sites/topic', 3, ''),
  (45, 'SITES_USER', '论坛用户', 'SITES', 'dashboard/sites/user', 4, ''),

  (50, 'TRADE', '交易', '', '', 4, 'menu-icon fa fa-credit-card'),
  (51, 'TRADE_COMMAND', '交易查询', 'TRADE', 'dashboard/trade/command', 0, ''),
  (52, 'TRADE_RESP_REL', '错误码管理', 'TRADE', 'dashboard/trade/respRel', 1, ''),

  (60, 'STAT', '统计', '', '', 5, 'menu-icon fa fa-bar-chart-o'),
  (61, 'STAT_USER', '注册统计', 'STAT', 'dashboard/stat/user', 0, ''),
  (62, 'STAT_LOGIN', '登录统计', 'STAT', 'dashboard/stat/login', 1, ''),

  (90, 'USER', '我的', '', '', 9, 'menu-icon fa fa-user'),
  (91, 'USER_PROFILE', '个人资料', 'USER', 'dashboard/user/profile', 0, '');

-- ----------------------------
--  data for tb_user_role
-- ----------------------------
INSERT INTO tb_user_role
VALUES
  (1, 1);

-- ----------------------------
--  data for tb_role_menu
-- ----------------------------
INSERT INTO tb_role_menu SELECT
                           1,
                           menu_id
                         FROM tb_menu;
INSERT INTO tb_role_menu
VALUES
  (2, 1),
  (2, 40),
  (2, 44);

-- ----------------------------
--  data for tb_channel
-- ----------------------------
INSERT INTO tb_channel
(channel_no, channel_name)
VALUES ('100', 'Paymax');

-- ----------------------------
--  data for tb_tran
-- ----------------------------
INSERT INTO tb_tran
(channel_no, tran_co, tran_name)
VALUES ('100', '001', '充值');

-- ----------------------------
--  data for tb_category
-- ----------------------------
delete from tb_category;
INSERT INTO tb_category
(category_code, category_name, sort)
VALUES
  ('announcement', '公告', 0),
  ('news', '新闻', 1),
  ('activity', '活动', 2);

-- ----------------------------
--  data for tb_dict
-- ----------------------------
INSERT INTO tb_dict
(dict_type, dict_code, value, sort)
VALUES
  ('CUR_CO', 'CNY', '人民币', 0),
  ('PRODUCT_CO', '001', '福动点券', 0),
  ('ID_TYPE', '0', '身份证', 0),
  ('LINK', 'download-ck', 'https://pan.baidu.com/s/1HJoeKDFt-oo4M6wGO2M9Kw', 0),
  ('SMS_TYPE', 'REGISTER', '注册', 0),
  ('SMS_TYPE', 'FORGOT', '找回密码', 1),
  ('EMAIL_TYPE', 'BIND', '邮箱绑定', 0),
  ('EMAIL_TYPE', 'FORGOT', '找回密码', 1),
  ('GAME_TYPE', '0', '个人竞速', 0),
  ('GAME_TYPE', '1', '组队竞速', 1),
  ('GAME_TYPE', '2', '个人道具', 2),
  ('GAME_TYPE', '3', '组队道具', 3),
  ('REGION_NO', '0', '内测', 0);

-- ----------------------------
--  data for tb_resp_rel
-- ----------------------------
INSERT INTO tb_resp_rel
(channel_no, resp_co, resp_msg, mer_resp_co, mer_resp_msg, tran_st)
VALUES
  ('sms', 'OK', '请求成功', '0000', '短信发送成功', 'Y'),
  ('sms', 'isp.RAM_PERMISSION_DENY', 'RAM权限DENY', '0001', '短信服务异常，请联系客服。', 'F'),
  ('sms', 'isv.OUT_OF_SERVICE', '业务停机', '0002', '短信服务异常，请联系客服。', 'F'),
  ('sms', 'isv.PRODUCT_UN_SUBSCRIPT', '未开通云通信产品的阿里云客户', '0003', '短信服务异常，请联系客服。', 'F'),
  ('sms', 'isv.PRODUCT_UNSUBSCRIBE', '产品未开通', '0004', '短信服务异常，请联系客服。', 'F'),
  ('sms', 'isv.ACCOUNT_NOT_EXISTS', '账户不存在', '0005', '短信服务异常，请联系客服。', 'F'),
  ('sms', 'isv.ACCOUNT_ABNORMAL', '账户异常', '0006', '短信服务异常，请联系客服。', 'F'),
  ('sms', 'isv.SMS_TEMPLATE_ILLEGAL', '短信模板不合法', '0007', '短信服务异常，请联系客服。', 'F'),
  ('sms', 'isv.SMS_SIGNATURE_ILLEGAL', '短信签名不合法', '0008', '短信服务异常，请联系客服。', 'F'),
  ('sms', 'isv.INVALID_PARAMETERS', '参数异常', '0009', '短信服务异常，请联系客服。', 'F'),
  ('sms', 'isv.SYSTEM_ERROR', '系统错误', '0010', '短信服务异常，请联系客服。', 'F'),
  ('sms', 'isv.MOBILE_NUMBER_ILLEGAL', '非法手机号', '0011', '手机号码格式错误。', 'F'),
  ('sms', 'isv.MOBILE_COUNT_OVER_LIMIT', '手机号码数量超过限制', '0012', '短信服务异常，请联系客服。', 'F'),
  ('sms', 'isv.TEMPLATE_MISSING_PARAMETERS', '模板缺少变量', '0013', '短信服务异常，请联系客服。', 'F'),
  ('sms', 'isv.BUSINESS_LIMIT_CONTROL', '业务限流。', '0014', '短信服务异常，请联系客服。', 'F'),
  ('sms', 'isv.INVALID_JSON_PARAM', 'JSON参数不合法，只接受字符串值', '0015', '短信服务异常，请联系客服。', 'F'),
  ('sms', 'isv.BLACK_KEY_CONTROL_LIMIT', '黑名单管控', '0016', '短信服务异常，请联系客服。', 'F'),
  ('sms', 'isv.PARAM_LENGTH_LIMIT', '参数超出长度限制', '0017', '短信服务异常，请联系客服。', 'F'),
  ('sms', 'isv.PARAM_NOT_SUPPORT_URL', '不支持URL', '0018', '短信服务异常，请联系客服。', 'F'),
  ('sms', 'isv.AMOUNT_NOT_ENOUGH', '账户余额不足', '0019', '短信服务异常，请联系客服。', 'F');

-- ----------------------------
--  data for tb_forum
-- ----------------------------
INSERT INTO tb_forum
(forum_id, forum_name, parent_forum_id, admin_user_id, sort)
VALUES
  (1, '通知公告', 0, 0, 0),
  (2, '玩家交流', 0, 0, 1),
  (3, 'BUG反馈', 0, 0, 2),
  (4, '意见建议', 0, 0, 3);

INSERT INTO tb_topic
(forum_id, title, content, is_stick, stick_expire_date, title_highlight, user_id)
VALUES (1, '《疯狂赛车官方论坛规则手册》',
        '<div><h3 style="font-family:&quot;font-weight:400;color:inherit;font-size:22px;">一、金币</h3><ol><li style="font-size:16px;">每个人初始金币为100</li><li style="font-size:16px;">置顶需要50金币，期限为1天</li><li style="font-size:16px;">标题高亮需要30金币，期限为永久</li><li style="font-size:16px;">发帖可获得10个金币</li><li style="font-size:16px;">回复可获得3个金币</li><li style="font-size:16px;">签到最多可获得7个金币，金币数量和连续签到天数有关。</li></ol><h3 style="font-family:&quot;font-weight:400;color:inherit;font-size:22px;">二、经验</h3><ol><li style="font-size:16px;">每个人初始经验为0</li><li style="font-size:16px;">发帖可获得20点经验</li><li style="font-size:16px;">回复可获得10经验</li><li style="font-size:16px;">签到最多可获得35点经验，经验数量和连续签到天数有关</li></ol><h3 style="font-family:&quot;font-weight:400;color:inherit;font-size:22px;">三、等级</h3><ol><li style="font-size:16px;">每个人初始等级为0</li><li style="font-size:16px;">等级是和经验挂钩的，每提升一级都需要之前经验的两倍。</li></ol><h3 style="font-family:&quot;font-weight:400;color:inherit;font-size:22px;">四、防灌水</h3><ol><li style="font-size:16px;">每三分钟可发帖一次</li><li style="font-size:16px;">每一分钟可回复一次</li><li style="font-size:16px;">每30秒可顶/踩一次</li><li style="font-size:16px;">每个IP一个小时内只算一次查看</li></ol></div>',
        1, '2018-08-30 16:53:09', 1, 1);

