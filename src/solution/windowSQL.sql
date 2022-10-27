--using with cluase to calculate base analytical functions
with cte as(
select cccm.sender_app_type,ord.order_id,
 dense_rank()
over (partition by ord.order_id order by cccm.msg_sent_time) as first_message_by,FIRST_VALUE(cccm.Msg_sent_time)
over (partition by ord.order_id order by cccm.msg_sent_time) as first_message_time,
cccm.msg_sent_time ,
  LAST_VALUE(cccm.Msg_sent_time)
over (partition by ord.order_id order by cccm.msg_sent_time) as last_message_time,
  dense_rank()
over (partition by ord.order_id order by cccm.msg_sent_time desc) as last_message_by
from customer_courier_chat_messages as cccm,orders as ord
where cccm.order_id=ord.order_id)

--Main query for calculating target columns
select ord.order_id,ord.city_code,min(case when substring(cccm.sender_app_type,1,2)='Co' then cccm.msg_sent_time end) as first_courier_message,
min(case when substring(cccm.sender_app_type,1,2)='Cu' then cccm.msg_sent_time end) as first_customer_message,
count( case when substring(cccm.sender_app_type,1,2)='Co' then cccm.sender_app_type end) as num_messages_courier,
count( case when substring(cccm.sender_app_type,1,2)='Cu' then cccm.sender_app_type end) as num_messages_customer,
min(case when cte.first_message_by=1 then split_part( cte.sender_app_type, ' ' , 1 ) end) as first_message_by,
min(cte.first_message_time) as conversation_started_at,
coalesce(EXTRACT(EPOCH FROM (min(case when cte.first_message_by=2 then cte.msg_sent_time end) -
min(case when cte.first_message_by=1 then cte.msg_sent_time end))),0)
as first_responsetime_delay_seconds,
max(cte.last_message_time) as last_message_time,
max(case when cte.last_message_by=1 then cccm.order_stage end) as last_message_order_stage
from customer_courier_chat_messages as cccm ,orders as ord,cte
where cccm.order_id=ord.order_id and ord.order_id=cte.order_id and cccm.msg_sent_time=cte.msg_sent_time
group by ord.order_id,ord.city_code ;
