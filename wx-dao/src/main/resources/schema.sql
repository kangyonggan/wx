DROP DATABASE IF EXISTS wx;

CREATE DATABASE wx
  DEFAULT CHARACTER SET utf8
  COLLATE utf8_general_ci;

USE wx;

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
--  Table structure for tb_novel
-- ----------------------------
DROP TABLE
IF EXISTS tb_novel;

CREATE TABLE tb_novel
(
  id            BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  name          VARCHAR(32)                           NOT NULL
  COMMENT '书名',
  author        VARCHAR(32)                           NOT NULL
  COMMENT '作者',
  category_code VARCHAR(32)                           NOT NULL
  COMMENT '栏目代码',
  pic_url       VARCHAR(256)                          NOT NULL                    DEFAULT ''
  COMMENT '封面图片地址',
  code          VARCHAR(11)                           NOT NULL
  COMMENT '书籍代码',
  descp         VARCHAR(2048)                         NOT NULL
  COMMENT '描述',
  status        TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '状态:{0:可用, 1:禁用}',
  created_time  TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time  TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '书籍表';
CREATE UNIQUE INDEX code_UNIQUE
  ON tb_novel (code);
CREATE INDEX ix_category_code
  ON tb_novel (category_code);

-- ----------------------------
--  Table structure for tb_section
-- ----------------------------
DROP TABLE
IF EXISTS tb_section;

CREATE TABLE tb_section
(
  id           BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  code         VARCHAR(11)                           NOT NULL
  COMMENT '章节代码',
  title        VARCHAR(64)                           NOT NULL
  COMMENT '标题',
  content      LONGTEXT                              NOT NULL
  COMMENT '内容',
  novel_code   VARCHAR(11)                           NOT NULL
  COMMENT '小说代码',
  status       TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '状态:{0:可用, 1:禁用}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '章节表';
CREATE UNIQUE INDEX novel_code_code_UNIQUE
  ON tb_section (novel_code, code);
CREATE INDEX ix_novel_code
  ON tb_section (novel_code);

INSERT INTO tb_dict (dict_type, dict_code, value, sort)
VALUES
  ('NOVEL', 'xuanhuan', '玄幻', 0),
  ('NOVEL', 'dushi', '都市', 1),
  ('NOVEL', 'xiuzhen', '修真', 2),
  ('NOVEL', 'lishi', '历史', 3),
  ('NOVEL', 'yanqing', '言情', 4),
  ('NOVEL', 'wangyou', '网游', 5),
  ('NOVEL', 'kehuan', '科幻', 6),
  ('NOVEL', 'qita', '其他', 7);

-- ----------------------------
--  Table structure for tb_record
-- ----------------------------
DROP TABLE
IF EXISTS tb_record;

CREATE TABLE tb_record
(
  id           BIGINT(20) PRIMARY KEY AUTO_INCREMENT NOT NULL
  COMMENT '主键, 自增',
  content      LONGTEXT                              NOT NULL
  COMMENT '内容',
  file_names   VARCHAR(2048)                         NOT NULL                    DEFAULT ''
  COMMENT '作者',
  openid       VARCHAR(128)                          NOT NULL
  COMMENT 'openid',
  status       TINYINT                               NOT NULL                    DEFAULT 0
  COMMENT '状态:{0:可用, 1:禁用}',
  created_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  updated_time TIMESTAMP                             NOT NULL                    DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间'
)
  COMMENT '书籍表';
CREATE INDEX ix_openid
  ON tb_record (openid);
