-- 最左前缀法则
-- 新建一个索引
create index idx_salary_manager_id_department_id on employees(salary,manager_id,department_id);
-- 看不同情况下是否用到索引

-- 用到全部索引，长度为19
explain select * from employees where salary=6000 and manager_id=103 and department_id=60;
-- 用到部分索引，长度为9
explain select * from employees where salary=6000 and department_id=60;
-- 用到部分索引，长度为14
explain select * from employees where salary=6000 and manager_id=103;
-- 未用到联合索引（必须包含联合索引的最左字段）
explain select * from employees where manager_id=103 and department_id=60;
-- 用到全部索引，长度为19(最左字段包含即可）
explain select * from employees where  manager_id=103 and department_id=60 and salary=6000;

-- 索引失效
-- 1.范围查询
-- 用到部分索引，长度为14,范围查询（用<,>)右侧索引失效
explain select * from employees where salary=6000 and manager_id>103 and department_id=60;
-- 用到全部索引，长度为19(>=,<=不算范围查询）
explain select * from employees where salary=6000 and manager_id>=103 and department_id=60;


-- 2.函数运算使索引失效
show  index from employees;
create index idx_phone_number on employees(phone_number);

explain select * from employees where substring(phone_number,1,2)='10';


-- 3.字符串不加引号使索引失效
explain select * from employees where phone_number=5151234567;
explain select * from employees where phone_number='5151234567';

-- 4.头部模糊匹配使索引失效
-- 联合索引失效
explain select * from employees where salary like '6%' and manager_id=103 and department_id=60;
-- 尾部模糊匹配，索引未失效
explain select * from employees where salary =6000 and manager_id=103 and department_id like '6%';

-- 5.or连接的条件使索引失效
-- 两侧都有索引不失效
explain select * from employees where phone_number='5151234567'or phone_number='5151234567';
-- 前边有后边没有，索引失效
explain select * from employees where phone_number='5151234567'or hire_date='1987-06-17';

-- 6.数据分布影响
-- 查出来数据占所有大部分，全表扫描较快，mysql就会放弃使用索引
explain select * from employees where salary>2000;
-- 数据较少，索引较快
explain select * from employees where salary>10000;
