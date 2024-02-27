-- 索引提示
show indexes in employees;

-- 1.指定使用的索引
explain select email from employees use index(emp_email_uk);
-- 忽略指定索引
explain select employee_id from employees ignore index(emp_emp_id_pk);
explain select employee_id from employees ignore index(emp_dept_fk);

-- 2.覆盖索引
explain select * from employees where salary=17000 and manager_id=100 and department_id=90;
explain select salary,manager_id,department_id from employees where salary=17000 and manager_id=100 and department_id=90;
   -- using index condition需要回表查询数据，效率低
   -- using index效率高
   -- 看用到的索引是否包含查询的所有字段，从而决定是否需要回表
   -- 索引没有必要包含主键，因为辅助索引叶子节点下面挂着主键

-- 前缀索引
   -- 将字符串一部分前缀拿出来建立索引
select count(distinct email) from employees;
select count(distinct email)/count(email) from employees;-- 选择性为1，去重后总数/总数

select count(distinct substring(email,1,9))/count(email) from employees;-- 截取前9位
select count(distinct substring(email,4,9))/count(email) from employees;

create index idx_email_five on employees(email(5));

explain select * from employees where email='NGREENBE';
