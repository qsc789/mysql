-- 显示表中索引
show index from employees;
-- 为first_name添加索引
create index idx_employees_first_name on employees(first_name);
-- 为phone_number添加unique索引
create unique index idx_employees_phone_number on employees(phone_number);
-- 为first_name和last_name建立联合索引
create index idx_employees_first_last on employees(first_name,last_name);
-- 为email建立索引
create index idx_employees_email on employees(email);

-- 删除索引
drop index idx_employees_email on employees;