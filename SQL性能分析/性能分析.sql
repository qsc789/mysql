-- 查看数据库insert delete select等访问频次
show global status like 'Com_______';

-- 查询慢查询日志是否开启
show variables like 'slow_query_log';

-- 设置慢查询时间为2秒
show variables like 'long_query_time';
set long_query_time =2;

-- 查看是否支持profile操作
select @@have_profiling;
-- 开启
set profiling =1;
select @@profiling;

select * from employees;
select count(*) from employees;

-- profile
-- 查看当前会话SQL语句耗时
show profiles;
-- 查看指定query_id的SQL语句各个阶段耗时情况
show profile for query 332;
-- 查看指定query_id的SQL语句cpu耗费情况
show profile cpu for query 332;

-- explain
-- 查看语句执行计划(适合连接查询）
explain select * from employees;
explain select e.department_id,d.department_name from employees e,departments d where e.department_id=d.department_id;

