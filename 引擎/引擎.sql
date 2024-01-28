-- 查询建表语句
show create table account;-- 默认为ENGINE=InnoDB

-- 查询当前数据库支持的存储引擎
show engines ;

-- 创建表my_myisam,并指定MyISAM搜索引擎
create table my_myisam(
    id int,
    name varchar(10)
)engine =MyISAM;

-- 创建表my_memory,并指定Memory搜索引擎
create table my_memory(
    id int,
    name varchar(10)
)engine =Memory;

-- 磁盘文件名
show variables like 'innodb_file_per_table';