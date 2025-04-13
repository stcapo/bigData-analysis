-- 创建数据库
CREATE DATABASE IF NOT EXISTS traffic_monitoring DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE traffic_monitoring;

-- 区域表
CREATE TABLE area (
    area_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '区域ID',
    area_name VARCHAR(50) NOT NULL COMMENT '区域名称',
    city VARCHAR(50) DEFAULT '北京市' COMMENT '所属城市'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='区域信息';

-- 道路表
CREATE TABLE road (
    road_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '道路ID',
    road_name VARCHAR(100) NOT NULL COMMENT '道路名称',
    road_type VARCHAR(20) COMMENT '道路类型',
    area_id INT COMMENT '所属区域ID',
    KEY idx_area_id (area_id) COMMENT '区域索引',
    CONSTRAINT fk_road_area FOREIGN KEY (area_id) REFERENCES area (area_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='道路信息';

-- 天气表
CREATE TABLE weather (
    weather_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '天气ID',
    date DATE NOT NULL COMMENT '日期',
    area VARCHAR(50) DEFAULT '北京市' COMMENT '区域',
    temperature INT COMMENT '温度',
    weather_condition VARCHAR(50) COMMENT '天气状况',
    wind VARCHAR(50) COMMENT '风力风向',
    update_time DATETIME COMMENT '更新时间',
    KEY idx_date (date) COMMENT '日期索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='天气信息';

-- 区域拥堵表
CREATE TABLE area_congestion (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '记录ID',
    area_id INT NOT NULL COMMENT '区域ID',
    congestion_value DECIMAL(5,2) NOT NULL COMMENT '拥堵指数',
    congestion_level VARCHAR(20) COMMENT '拥堵等级',
    average_speed DECIMAL(5,2) COMMENT '平均速度',
    record_time DATETIME NOT NULL COMMENT '记录时间',
    KEY idx_area_id (area_id) COMMENT '区域索引',
    KEY idx_record_time (record_time) COMMENT '记录时间索引',
    CONSTRAINT fk_area_congestion_area FOREIGN KEY (area_id) REFERENCES area (area_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='区域拥堵信息';

-- 道路拥堵表
CREATE TABLE road_congestion (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '记录ID',
    road_id INT NOT NULL COMMENT '道路ID',
    congestion_value DECIMAL(5,2) NOT NULL COMMENT '拥堵指数',
    congestion_level VARCHAR(20) COMMENT '拥堵等级',
    average_speed DECIMAL(5,2) COMMENT '平均速度',
    delay_time INT COMMENT '延迟时间(分钟)',
    record_time DATETIME NOT NULL COMMENT '记录时间',
    KEY idx_road_id (road_id) COMMENT '道路索引',
    KEY idx_record_time (record_time) COMMENT '记录时间索引',
    CONSTRAINT fk_road_congestion_road FOREIGN KEY (road_id) REFERENCES road (road_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='道路拥堵信息';

-- 拥堵原因表
CREATE TABLE congestion_cause (
    cause_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '原因ID',
    cause_name VARCHAR(50) NOT NULL COMMENT '原因名称',
    cause_value INT COMMENT '原因比例值',
    cause_color VARCHAR(20) COMMENT '图表显示颜色',
    record_date DATE COMMENT '记录日期',
    KEY idx_record_date (record_date) COMMENT '记录日期索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='拥堵原因';

-- 交通通知表
CREATE TABLE traffic_notice (
    notice_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '通知ID',
    title VARCHAR(100) NOT NULL COMMENT '通知标题',
    content TEXT NOT NULL COMMENT '通知内容',
    notice_date DATE NOT NULL COMMENT '通知日期',
    notice_type VARCHAR(50) COMMENT '通知类型',
    publish_time DATETIME COMMENT '发布时间',
    KEY idx_notice_date (notice_date) COMMENT '通知日期索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交通通知';

-- 交通趋势表
CREATE TABLE traffic_trend (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '记录ID',
    time_point VARCHAR(20) NOT NULL COMMENT '时间点',
    congestion_value DECIMAL(5,2) NOT NULL COMMENT '拥堵指数',
    record_date DATE NOT NULL COMMENT '记录日期',
    is_workday TINYINT(1) DEFAULT 1 COMMENT '是否工作日',
    KEY idx_record_date (record_date) COMMENT '记录日期索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交通趋势';

-- 交通预测表
CREATE TABLE traffic_prediction (
    id INT PRIMARY KEY AUTO_INCREMENT COMMENT '记录ID',
    date_label VARCHAR(50) NOT NULL COMMENT '日期标签',
    congestion_value DECIMAL(5,2) COMMENT '拥堵指数',
    is_prediction TINYINT(1) DEFAULT 0 COMMENT '是否预测值',
    record_date DATE NOT NULL COMMENT '记录日期',
    KEY idx_record_date (record_date) COMMENT '记录日期索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='交通预测';

-- 插入区域数据
INSERT INTO area (area_name) VALUES 
('朝阳区'), ('海淀区'), ('西城区'), ('东城区'), ('丰台区'),
('石景山区'), ('通州区'), ('昌平区'), ('门头沟区'), ('房山区'),
('顺义区'), ('大兴区'), ('怀柔区'), ('平谷区'), ('密云区'), ('延庆区');

-- 插入道路数据
INSERT INTO road (road_name, road_type) VALUES 
('五环路', '环路'), ('三环路', '环路'), ('长安街', '主干道'), ('建国门内大街', '主干道'),
('北三环', '环路'), ('二环路', '环路'), ('四环路', '环路'), ('北四环', '环路'),
('京藏高速', '高速公路'), ('京港澳高速', '高速公路'), ('京开高速', '高速公路'),
('建国门桥区域', '桥区'), ('西直门桥区域', '桥区'), ('四惠桥区域', '桥区'),
('光华桥区域', '桥区'), ('三元桥区域', '桥区'), ('白石桥区域', '桥区');

-- 插入天气数据
INSERT INTO weather (date, area, temperature, weather_condition, wind, update_time) VALUES 
('2025-03-22', '北京市', 21, '晴朗', '东北风 2级', '2025-03-22 10:30:45');

-- 插入区域拥堵数据
INSERT INTO area_congestion (area_id, congestion_value, congestion_level, average_speed, record_time) VALUES 
(1, 8.7, '严重拥堵', 15.5, '2025-03-22 10:30:45'),
(2, 8.2, '严重拥堵', 16.8, '2025-03-22 10:30:45'),
(3, 7.4, '中度拥堵', 18.6, '2025-03-22 10:30:45'),
(4, 7.1, '中度拥堵', 19.2, '2025-03-22 10:30:45'),
(5, 6.5, '中度拥堵', 21.5, '2025-03-22 10:30:45'),
(6, 5.8, '轻度拥堵', 24.7, '2025-03-22 10:30:45'),
(7, 5.2, '轻度拥堵', 26.4, '2025-03-22 10:30:45'),
(8, 4.8, '轻度拥堵', 28.3, '2025-03-22 10:30:45');

-- 插入道路拥堵数据
INSERT INTO road_congestion (road_id, congestion_value, congestion_level, average_speed, delay_time, record_time) VALUES 
(1, 9.2, '严重拥堵', 12.3, 35, '2025-03-22 10:30:45'),
(2, 8.7, '严重拥堵', 15.8, 28, '2025-03-22 10:30:45'),
(3, 8.5, '严重拥堵', 16.2, 26, '2025-03-22 10:30:45'),
(4, 7.8, '中度拥堵', 18.4, 22, '2025-03-22 10:30:45'),
(5, 7.6, '中度拥堵', 19.1, 20, '2025-03-22 10:30:45'),
(6, 6.9, '中度拥堵', 21.5, 18, '2025-03-22 10:30:45'),
(7, 6.2, '中度拥堵', 23.8, 15, '2025-03-22 10:30:45'),
(8, 5.5, '轻度拥堵', 26.7, 12, '2025-03-22 10:30:45');

-- 插入拥堵原因数据
INSERT INTO congestion_cause (cause_name, cause_value, cause_color, record_date) VALUES 
('车流量过大', 32, '#00a8ff', '2025-03-23'),
('交通事故', 25, '#ff5a5a', '2025-03-23'),
('道路施工', 18, '#ffbc40', '2025-03-23'),
('信号灯故障', 10, '#9b5bfd', '2025-03-23'),
('天气影响', 8, '#00e3c9', '2025-03-23'),
('大型活动', 7, '#68d460', '2025-03-23');

-- 插入交通通知数据
INSERT INTO traffic_notice (title, content, notice_date, notice_type, publish_time) VALUES 
('交通预警通知', '预计明天早高峰7:30-9:00，东三环至西二环段拥堵加剧，建议提前出行或选择地铁出行。', '2025-03-23', '预警', '2025-03-23 08:00:00'),
('道路施工通知', '北五环至机场高速连接路今日22:00-次日6:00进行道路维修，请过往车辆注意绕行。', '2025-03-23', '施工', '2025-03-23 09:15:00'),
('大型活动通知', '国家体育馆周边将于明日14:00-18:00举办大型赛事，周边道路将实施临时交通管制。', '2025-03-23', '活动', '2025-03-23 10:30:00'),
('天气预警', '气象部门预测，明日有大雨，可能导致部分路段积水，请注意减速慢行，选择安全路线。', '2025-03-23', '天气', '2025-03-23 11:45:00'),
('交通管制通知', '因环保需要，明日实施机动车尾号限行，限行尾号为1和6，请提前安排出行计划。', '2025-03-23', '管制', '2025-03-23 14:20:00');

-- 插入交通趋势数据
INSERT INTO traffic_trend (time_point, congestion_value, record_date, is_workday) VALUES 
('00:00', 2.1, '2025-03-22', 1),
('03:00', 1.8, '2025-03-22', 1),
('06:00', 2.2, '2025-03-22', 1),
('09:00', 8.9, '2025-03-22', 1),
('12:00', 5.2, '2025-03-22', 1),
('15:00', 4.8, '2025-03-22', 1),
('18:00', 9.1, '2025-03-22', 1),
('21:00', 6.2, '2025-03-22', 1),
('24:00', 3.5, '2025-03-22', 1),
('0:00', 1.2, '2025-03-23', 1),
('2:00', 0.8, '2025-03-23', 1),
('4:00', 0.5, '2025-03-23', 1),
('6:00', 1.5, '2025-03-23', 1),
('8:00', 8.2, '2025-03-23', 1),
('10:00', 6.5, '2025-03-23', 1),
('12:00', 4.8, '2025-03-23', 1),
('14:00', 5.2, '2025-03-23', 1),
('16:00', 7.8, '2025-03-23', 1),
('18:00', 8.5, '2025-03-23', 1),
('20:00', 4.2, '2025-03-23', 1),
('22:00', 2.5, '2025-03-23', 1);

-- 插入交通预测数据
INSERT INTO traffic_prediction (date_label, congestion_value, is_prediction, record_date) VALUES 
('上周一', 7.2, 0, '2025-03-17'),
('上周二', 6.8, 0, '2025-03-18'),
('上周三', 7.3, 0, '2025-03-19'),
('上周四', 7.1, 0, '2025-03-20'),
('上周五', 8.2, 0, '2025-03-21'),
('上周六', 6.2, 0, '2025-03-22'),
('上周日', 5.8, 0, '2025-03-23'),
('本周一', 7.5, 0, '2025-03-24'),
('本周二', 7.2, 0, '2025-03-25'),
('本周三', 6.9, 0, '2025-03-26'),
('本周四', 7.5, 0, '2025-03-27'),
('明天', 7.8, 1, '2025-03-28'),
('后天', 8.2, 1, '2025-03-29'),
('大后天', 7.6, 1, '2025-03-30');