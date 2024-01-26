-- 事务
-- 数据准备
create table account(
    id int auto_increment primary key comment '主键ID',
    name varchar(10) comment '姓名',
    money int comment '金额'

) comment '账户表';
insert into account (id, name, money)
values (null,'张三',2000),(null,'李四',2000);

-- 恢复数据
update account set money=2000 where name='张三'or name='李四';


-- 方式一

-- 查询事务提交方式
select @@autocommit;
-- 将提交方式改为手动
set @@autocommit=0;

-- 转账操作（张三给李四转1000）
-- 1.查张三账户余额
select money from account where name='张三';
-- 2.张三账户余额-1000
update account set money=money-1000 where name='张三';
-- 报错...
-- 3.李四账户余额+1000
update account set money=money+1000 where name='李四';

-- 提交
commit;

-- 如果出错则进行回滚事务
rollback ;


-- 方式二

-- 开始事务
start transaction ;

-- 转账操作（张三给李四转1000）
-- 1.查张三账户余额
select money from account where name='张三';
-- 2.张三账户余额-1000
update account set money=money-1000 where name='张三';
-- 报错...
-- 3.李四账户余额+1000
update account set money=money+1000 where name='李四';

-- 将提交方式改为自动
set @@autocommit=1;

-- 提交事务
commit ;

-- 出错则回滚
rollback ;

-- 查看事务隔离级别
select @@transaction_isolation;

-- 修改事务隔离级别
   -- session仅修改当前会话
set session transaction isolation level read uncommitted ;
set session transaction isolation level repeatable read ;