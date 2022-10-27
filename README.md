
#  Priority Queue Simulation Using SQL

## Introduction

This is an End to End solution to develop some complex query using SQL and window function, Postgres SQL Database and docker container in order to address different problem in BI.


## Requirement

Considering below tables data (customer_courier_chat_messages and orders), the task is about build a query that aggregates individual messages into conversations. customer_courier_chat_messages table stores data about individual messages exchanged between customers and couriers via the in-app chat and
the orders table includes order_id and city_code field.

|sender_app_type|customer_id|from_id|to_id|chat_started_by_msg|order_id|order_stage|courier_id|msg_sent_time|
|:----|:----|:----|:----|:----|:----|:----|:----|:----|
|Customer iOS|17071099|17071099|16293039|false|59528555|PICKING_UP|16293039|2019-08-19T08:01:47.000Z|
|Courier iOS|17071099|16293039|17071099|false|59528555|ARRIVING|16293039|2019-08-19T08:01:04.000Z|
|Customer iOS|17071099|17071099|16293039|false|59528555|PICKING_UP|16293039|2019-08-19T08:00:04.000Z|
|Courier Android|12874122|18325287|12874122|true|59528038|ADDRESS_DELIVERY|18325287|2019-08-19T07:59:33.000Z|


Take into consideration that a conversation is unique per order. The required fields are the following:
* order_id
* city_code
* first_courier_message: Timestamp of the first courier message
* first_customer_message: Timestamp of the first customer message
* num_messages_courier: Number of messages sent by courier
* num_messages_customer: Number of messages sent by customer
* first_message_by: The first message sender (courier or customer)
* conversation_started_at: Timestamp of the first message in the conversation
* first_responsetime_delay_seconds: Time (in secs) elapsed until the first message was responded
* last_message_time: Timestamp of the last message sent
* last_message_order_stage: The stage of the order when the last message was sent




## Getting Started

This section explains how to run this App. I have tried to make it very simple. 

### Prerequisites
The required prerequisites are:

* Docker and docker-compose 3
* Internet connection to download required docker images and libraries.

### Installation

* running all containers
   ```sh
   $ docker-compose up -d
   ```
    ```sh
   $ docker-compose exec complex_sql check windowSQL
   ```

  * After the command prints `Bingo! All columns match`, means that the solution's output and expected output are match with each other.

There are other directories inside `src/` that can be interesting to you:

* `init-fixtures`: contains the scripts that are necessary to initialize the
  database. Every time a solution script is checked, the whole database gets
  dropped and regenerated using these fixtures.

* `solution`: contains solution files.

* `output-obtained`: contains the latest execution results of solutions in
  CSV format.

* `output-expected`: contains the expected results from each query in CSV
  format.


## Stoping Services
Enter the following command to stop the containers:

```bash
$ docker-compose down -v
```

## Author

👤 **Tayebe Mohamadi**

## Version History
* 0.1
    * Initial Release
