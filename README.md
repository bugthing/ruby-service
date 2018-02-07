Container for Simple Service
============================

[ ![Codeship Status for bugthing/ruby-service](https://app.codeship.com/projects/d6985ef0-ee53-0135-b1fa-7a05e9c83fff/status?branch=master)](https://app.codeship.com/projects/270906)

A simple Ruby service connected to RabbitMQ and MongoDB, contained by Docker

All settings are stored here:

    config/setting.tml

Setup
------

* Get the code

    $ git clone <url>

* Install the gems

    $ bundle install

* Connect to mongodb and rabbitmq

    (see Docker section)

* Start the service

    $ foreman start

Development
-----------

Run the tests like so:

    $ bundle exec rspec

We use rubocop, so you run that too:

    $ bundle exec rubocop

To aid a good workflow you can use guard to auto run tests as you update the code.

    $ bundle exec guard

Docker
------

You can use docker for the supporting services MongoDB and RabbitMQ

    $ docker run -d --name mongodb -p 27017:27017 -t mongo

    $ docker run -d --name rabbitmq --hostname rabbitmq -p 8080:15672 -p 5672:5672 -e RABBITMQ_DEFAULT_VHOST=service -t rabbitmq:3-management

You can also build this service as a container

* First you need to build the docker image

    $ docker build -t ruby-service .

* Next you can start the service (here in interactive mode -i)

    $ docker run -i --name=ruby-service --rm --link rabbitmq:rabbitmq --link mongodb:mongodb -t ruby-service

Try it out
----------

You can publish a message (amoung many things) using the RabbitMQ management ui, access it here:

	http://0.0.0.0:8080/
	user/pass: (guest/guest)

You can also use rabbitmq-c tool, amqp-publish

    $ amqp-publish --routing-key=events --body='{"test":"msg"}' --url='amqp://guest:guest@rabbitmq:5672/service'

You can see whats in mongo using a gui, like this container:

	$ docker run -d --name mongo-express --link mongodb:mongo -p 8081:8081 mongo-express

	http://0.0.0.0:8081/

