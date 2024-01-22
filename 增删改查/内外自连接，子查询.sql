-- 连接查询

-- 内连接
-- 1.查询每个员工姓名，及关联的部门名称（隐式内联）
select e.last_name, d.department_name
from employees e,
     departments d
where e.department_id = d.department_id;
-- 起别名后必须用别名
-- 2.查询有员工的部门id，名称
select distinct e.department_id, d.department_name
from employees e,
     departments d
where e.department_id = d.department_id;
-- 3.查询每个员工姓名，及关联的部门名称（显式内联）
select *
from employees e
         inner join departments d on e.department_id = d.department_id;
select *
from employees e
         join departments d on e.department_id = d.department_id;
-- inner可以不加

-- 外连接
-- 1.查询employees表的所有数据和对应部门信息（左外）
-- 可以查出部门为空的员工信息
select e.*, d.department_name
from employees e
         left join departments d on e.department_id = d.department_id;
-- 1.查询departments表的所有数据及员工信息（右外）
select e.*, d.department_name
from employees e
         right join departments d on e.department_id = d.department_id;
-- 左外转右外
select e.*, d.department_name
from departments d
         left join employees e on e.department_id = d.department_id;

-- 自连接
-- 1.查询员工和领导的姓名
select e1.last_name '员工', e2.last_name '领导'
from employees e1
         join employees e2 on e1.manager_id = e2.employee_id;
-- 2.查询员工和领导的姓名，没领导的员工也要查出来
-- 左外连接
select e1.last_name '员工', e2.last_name '领导'
from employees e1
         left join employees e2 on e1.manager_id = e2.employee_id;

-- 联合查询
-- 1.查询薪资低于5000和department_id大于100的员工
select *
from employees
where salary < 5000
union all
-- 加all不去重
select *
from employees
where department_id > 100;

select *
from employees
where salary < 5000
union
-- 不加all去重
select *
from employees
where department_id > 100;
-- 联合查询中查询的字段必须一样

-- 子查询
-- 标量子查询

-- 1.查询部门为IT的员工信息
select *
from employees
where department_id = (select department_id from departments where department_name = 'IT');

-- 2.查询在join chen之后入职的员工信息
select *
from employees
where hire_date > (select hire_date from employees where first_name = 'John' && last_name = 'Chen');

-- 列子查询(in,not in,any,some,all)some与any等价
-- 1.查询IT部和Sales部所有员工信息
select *
from employees
where department_id in
      (select department_id from departments where department_name = 'IT' or department_name = 'Sales');
-- 后一个select会有多个结果，所以第一个select必须是in

-- 2.查询比IT部所有人工资都高的员工信息
select *
from employees
where salary > all (select salary
                    from employees
                    where department_id = (select department_id from departments where department_name = 'IT'));
-- 关键字all
-- 3.查询比Sales部任意一人工资高的员工信息
select *
from employees
where salary > any (select salary
                    from employees
                    where department_id = (select department_id from departments where department_name = 'Sales'));

-- 行子查询
-- 1.查询与John Chen的薪资，直属领导相同的员工信息
select *
from employees
where (salary, manager_id) = (select salary, manager_id from employees where first_name = 'John' && last_name = 'Chen');

-- 表子查询
-- 1.查询与 John Chen，Ki Gee的职位和薪资相同的员工信息
select *
from employees
where (job_id, salary) in (select job_id, salary
                           from employees
                           where (first_name = 'John' && last_name = 'Chen')
                              or (first_name = 'Ki' && last_name = 'Gee'));

-- 2.查询入职日期是"1997-08-20"之后的员工信息，及部门信息
select e.*, d.*
from (select * from employees where hire_date > '1997-08-20') e
         left join departments d on e.department_id = d.department_id;
-- 以子查询为一张新表，加上外连接

-- 查询IT部平均工资
select avg(e.salary)
from employees e,
     departments d
where e.department_id = d.department_id
  and d.department_name = 'IT';
-- 查询工资比平均薪资高的员工信息
select *
from employees
where salary > (select avg(salary) from employees);
-- 查询低于本部门平均工资的员工信息
select *
from employees e1
where e1.salary < (select avg(e2.salary) from employees e2 where e2.department_id = e1.department_id);
-- 查询所有部门信息，并统计部门员工个数
select d.department_id,
       d.department_name,
       (select count(*) from employees e where e.department_id = d.department_id) '人数'
from departments d;