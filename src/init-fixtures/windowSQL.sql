--script for creating tables
create table customer_courier_chat_messages
(
  Sender_app_type varchar(20),
  Customer_id int,
  From_id int,
  To_id int, 
  Chat_started_by_msg boolean,
  Order_id int, 
  Order_stage varchar(20),
  Courier_id int,
  Msg_sent_time timestamp
);
create table orders
(
  Order_id int,
  City_code int
);

--inserting sample records
insert into customer_courier_chat_messages
(Sender_app_type, Customer_id, From_id, To_id, Chat_started_by_msg, Order_id, Order_stage, Courier_id, Msg_sent_time)
values
('Customer iOS',17071099, 17071099, 16293039, FALSE, 59528555, 'PICKING_UP', 16293039, '2019-08-19 8:01:47'),
('Courier iOS',17071099, 16293039, 17071099, FALSE, 59528555, 'ARRIVING', 16293039, '2019-08-19 8:01:04'),
('Customer iOS',17071099, 17071099, 16293039, FALSE, 59528555, 'PICKING_UP' ,16293039, '2019-08-19 8:00:04'),
('Courier Android',12874122, 18325287, 12874122, TRUE, 59528038, 'ADDRESS_DELIVERY',18325287, '2019-08-19 7:59:33');
insert into orders
(Order_id,City_code)
values
(59528555,1),
(59528038,2);