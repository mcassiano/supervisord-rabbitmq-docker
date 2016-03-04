### supervisord-rabbitmq-docker



### To build:

    sudo docker build --tag srabbitmq .

### To run:

    sudo docker run -p :5672 -p :15672 srabbitmq
    
### To run as a daemon use -d
    sudo docker run -d -p :5672 -p :15672 srabbitmq
    
### To explicitly bind machine port to the container use the following command
    sudo docker run -d -p 5672:5672 -p 15672:15672 srabbitmq

### Use the following url to access RabbitMQ Admin
    localhost:15672
