#1
create DATABASE if not exists test01_library;
#2
create table books(
id INT,
name varchar(50),
authors varchar(100),
price float,
pubdate year,
note varchar(100),
num INT
);

#3
insert into books values
(1,'Tal of AAA','Dickes',23,1995,'novel',11);

insert into books (id,name,authors,price,pubdate,note,num)
 values
 (2,'EmmaT','jane lura',35,1993,'joke',22);

insert into books (id,name,authors,price,pubdate,note,num)
 values
 (3,'Story of jane','jane Tim',40,2001,'novel',0),
 (4,'Lovey Day','George Byron',20,2005,'novel',30),
 (5,'Old Land','Honore Blade',30,2010,'law',0),
 (6,'The Battle','Upton Sara',30,1999,'medicine',40),
 (7,'Rose Hood','Richard haggard',28,2008,'cartoon',28);
 #4
 update books
 set price=price+5
 where books.note = 'novel';
 #5
 update books
 set price=40,note='drama'
 where books.name = 'EmmaT';
 #6
 delete from books
 where num=0;
 #7
 insert into books (id,name,authors,price,pubdate,note,num)
 values
  (3,'story of jane','jane Tim',40,2001,'novel',0),
	(5,'Old Land','Honore Blade',30,2010,'law',0);
	alter table books
	order by id;
 select count(name)
 from books
 where name like '%a%';
 #8
 select count(name),sum(num)
 from books
 where name like '%a%';
 #9
 select name,price
 from books
 where note='novel'
 order by price desc;
 #10
 select *
 from books
 order by num desc,note asc;
 #11
 select count(name),note
 from books
 group by note;
 #12
 select note,sum(num)
 from books
 group by note
 having sum(num)>30;
 #13
 
	select name 
	from books
	limit 5,5;
	#14
	select note,sum(num)
	from books
	group by note
	order by sum(num) DESC
	limit 0,1;
	#15
	
	select name
	from books
	where char_length(replace(name,' ',''))>=10;
	
	
	#16
	select name,note,
	case note 
	when 'novel' then '小说'
	when 'law' then '法律'
	when 'medicine' then '医药'
	when 'cartoon' then '卡通'
	when 'joke' then '笑话'
	END '种类'
	from books;
	#17
	select name,num,
	case 
	when num>30 then '滞销'
	when num>0 && num<10 then '畅销'
	when num=0 then '无货'
	else '一般'
	end '状态'
	from books;
	#18(合计?)
	select IFNULL(note,'合计库存总量')"note",sum(num)
	from books
	group by note with rollup;
	#19
	select IFNULL(note,'合计总量')"note" ,count(name)
	from books
	group by note with rollup;
	
	#20
	select name,num
	from books
	order by num DESC
	limit 0,3;
	#21
	select name,pubdate
	from books
	order by pubdate ASC
	limit 0,1;
	#22
	select name,price
	from books
	where note ='novel'
	order by price DESC
	limit 0,1;
	#23
	
	select name
	from books
	order by CHAR_LENGTH(replace(name,' ','')) desc
	limit 0,1;
	
	
	
	
	
	
 
 
 
