use storefront;
create table productCategory(pc_id int primary key,p_id int,cat_id int,foreign key(p_id) references product(p_id),foreign key(cat_id) references category(cat_id));
select * from product;
select * from category;
insert into productCategory(pc_id,p_id,cat_id) values(1,1,1),(2,2,2),(3,3,3),(4,4,4);
select pc.p_id,p.p_name,count(pc.cat_id) from productcategory pc join product p on pc.p_id=p.p_id group by pc.p_id having count(pc.cat_id)>1;




select count(*) from product,category c where c.price between 0 and 100;
select count(*) from product,category c where c.price between 101 and 5000;
select count(*) from product,category c where c.price>500;










select c.cat_name,count(pc.pc_id) from productcategory pc join category c on pc.cat_id=c.cat_id group by pc.cat_id;








select * from orders o where datediff(now(),o.time)<=30 order by amt desc limit 2;


select u.name,count(o_id) from orders o join users u on o.u_id=u.u_id where datediff(now(),o.time)<=30 group by o.u_id;




select count(o.o_id),u.name from orders o join users u on o.u_id=u.u_id group by o.u_id;



update product set product.active=0 where product.p_id not in(select * from(select u.u_id from users u join orders o where u.u_id=o.u_id and datediff(now(),o.time)<=30) as T);




select c.cat_id,p.p_name,c.price from product p join category c join productcategory pc where p.p_id=pc.p_id and c.cat_id=pc.cat_id and p.p_name='shirt';












create table state (id int primary key auto_increment, name varchar(50));
create table city (id int primary key, name varchar(50), stateId int,
foreign key (stateId) references state(id));
create table zipcode (id int primary key, code varchar(10), cityId int,
foreign key (cityId) references city(id));
insert into state (name) values ('Rajasthan'), ('Himachal Pradesh'), ('Goa');
insert into city (id,name, stateId) values (1,'Jodhpur', 1), (2,'Jaipur', 1), (3,'Udaipur', 1),
(4,'Shimla', 2), (5,'Manali', 2), (6,'Panaji', 3);
insert into zipcode (id,code, cityId) values (1,342001, 1), (2,342003, 1), (3,342004, 1), (4,312001, 2),
(5,234001, 3);
select z.code, c.name, s.name from zipcode z join city c join state s where z.cityId = c.id and
c.stateId = s.id order by s.name, c.name;


create view OrderInfo as select o.o_id,p.p_id,p.p_name as title,c.price,u.name,o.time,o.status from product p join orders o join users u join category c where o.u_id=u.u_id and datediff(now(),o.time)<=60 order by o.time desc;
select * from orderInfo;
select o_id from orderInfo where status='shipped';

select o_id,count(o_id) from orderInfo group by o_id order by count(o_id) desc limit 5;
