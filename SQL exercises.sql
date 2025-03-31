use test;

set FOREIGN_KEY_CHECKS=0;

-//-- Exercise #1: creating tables ----------------------------------------------------------------------------------

create table users (user_id int(2) Primary Key auto_increment,
					user_name varchar(100),
                    email varchar(100) UNIQUE,
                    registration_date date,
                    user_role ENUM('admin','user','editor')); 

create table categories (category_id int(3) primary key auto_increment,
						 category_name varchar(100));

create table products(product_id int(2) primary key auto_increment,
					  product_name varchar(100),
                      price decimal(10,2),
                      stock int(3),
                      category_id int(3) ,
                      foreign key (category_id) references categories(category_id));

create table orders(order_id int(3) primary key auto_increment,
					user_id int(2),
					foreign key (user_id) references users(user_id),
                    order_date date,
                    total decimal(10,2));

create table orderDetails(details_id INT(3)  Primary Key AUTO_INCREMENT,
						  order_id INT(3),
                          foreign key (order_id) references orders(order_id),
                          product_id int(2),
                          foreign key (product_id) references products(product_id),
                          quantity  INT(3),
						  unit_price DECIMAL(10,2));

-//-- Exercise #1: creating tables ------------------------------------------------------------------------------------
   
   select * from users;
   select * from products;
   select * from categories;   
   select * from orders;
   select * from orderDetails;
                      
 -//-- Exercise #2: adding 10 values or more to each table -------------------------------------------------------------                     
insert into users
		values (1,"Juan Perez","juan@example.com","2024-01-01", 'user'),
        	   (2,"Maria Lopez","maria@example.com","2024-02-13",'editor'),
               (3,"Carlos Gomez","carlos@example.com","2023-12-18",'admin'),
               (4,"Ana Ramirez","ana@example.com","2024-01-20",'user'),
			   (5,"Pedro Sanchez","pedro@example.com","2023-11-05",'user');

insert into users
		values (6,"Rodrigo Herrera","rodrigo@example.com","2024-01-06", 'user'),
        	   (7,"Facundo Marasi","facundo@example.com","2024-02-14",'user'),
               (8,"Tamara Velez","tamara@example.com","2023-12-18",'admin'),
               (9,"Daniela Peyrano","daniela@example.com","2024-01-21",'editor'),
			   (10,"Ruben Funes","ruben@example.com","2023-11-06",'user');

insert into categories
	    values (1, "Computers"),
			   (2,"Periferics"),
               (3, "Monitors"),
               (4,"Office Furniture");

insert into categories
	    values (5, "Decoratives"),
			   (6,"Desktops"),
               (7, "Utils"),
               (8,"Connectors"),
			   (9,"Sound"),
			   (10,"Video");
                  
insert into products
	   values (1,"Dell Laptop",1200.00,10,1),
			  (2,"Mechanic keyboard",80.00,25,2),
			  (3,"Wireless Mouse",40.00,50,2),
			  (4,"24 Monitor",300.00,15,3),
			  (5,"Ergonomic chair",200.00,5,4);

insert into products
	   values (6,"Anti-move table",1200.00,10,1),
			  (7,"Headphones",80.00,25,2),
			  (8,"Wireless Headpones",40.00,50,2),
			  (9,"adapt connectors",300.00,15,3),
			  (10,"cable holders",200.00,5,4);

insert into orders
		values (1, 1, "2024-02-01", 1280.00),
			   (2, 2, "2024-02-05", 200.00),
			   (3, 3, "2024-01-20", 300.00),
			   (4, 4, "2024-01-25", 80.00),
			   (5, 5, "2024-02-10", 40.00);

insert into orders
		values (6, 6, "2024-02-02", 1280.00),
			   (7, 7, "2024-02-03", 200.00),
			   (8, 8, "2024-01-23", 300.00),
			   (9, 9, "2024-01-24", 80.00),
			   (10, 10, "2024-02-15", 40.00);
               
insert into orderDetails
		values (1, 1, 1, 1, 1200.00),
			   (2, 1, 2, 1, 80.00),
			   (3, 2, 5, 1, 200.00),
			   (4, 3, 4, 1, 300.00),
			   (5, 4, 2, 1, 80.00),
			   (6, 5, 3, 1, 40.00);
               
insert into orderDetails
		values (7, 1, 1, 1, 1200.00),
			   (8, 1, 2, 1, 80.00),
			   (9, 2, 5, 1, 200.00),
			   (10, 3, 4, 1, 300.00),
			   (11, 4, 2, 1, 80.00),
			   (12, 5, 3, 1, 40.00);

-//-- Exercise #2: adding 10 values or more to each table -------------------------------------------------------------
-//-- Exercise #3: select all the users registered on the last month ------------------------------------------------
select * from users where registration_date between '2024-02-01' and '2024-02-28';
-//-- Exercise #3: select all the users registered on the last month ------------------------------------------------
-//-- Exercise #4: get total products stock  ------------------------------------------------------------------------
select sum(stock) from products;
-//-- Exercise #4: get total products stock  ------------------------------------------------------------------------
-//-- Exercise #5: get all the orders from an particular user -------------------------------------------------------
select * from orders where user_id=2;
-//-- Exercise #5: get all the orders from an particular user -------------------------------------------------------
-//-- Exercise #6: get sales total by product category   -------------------------------------------------------
SELECT c.category_name, SUM(od.quantity * od.unit_price) AS total_sales
FROM orderdetails od
JOIN products p ON od.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name;

-//-- Exercise #7: get all users which has not made any orders -------------------------------------------------------
select * from users
where user_id not in (select distinct user_id from orders);
-//-- Exercise #7: get all users which has not made any orders -------------------------------------------------------

