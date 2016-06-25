Container for Simple Service
============================

A simple Ruby service connected to RabbitMQ and MongoDB, contained by Docker

All settings are stored here:

    config/setting.tml

Development
-----------

To aid a good workflow you can use guard to auto run tests as you update the code.

    $ bundle exec guard

Docker
------

    $ docker build -t ruby-service .

    $ docker run -d --name rabbitmq --hostname rabbitmq -p 8080:15672 -p 5672:5672 -e RABBITMQ_DEFAULT_VHOST=service -t rabbitmq:3-management

    $ docker run -d --name mongodb -p 27017:27017 -t mongo

    $ docker run -i --name=ruby-service --rm --link rabbitmq:rabbitmq --link mongodb:mongodb -t ruby-service

