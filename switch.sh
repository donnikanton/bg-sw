#!/bin/bash

app=$(ls /etc/nginx/sites-enabled | grep app)


if [ $app == app1 ]
then
        cd /opt/config2
        docker-compose down -v
        docker-compose pull
        docker-compose up -d
        docker-compose scale "node=count"
        rm /etc/nginx/sites-enabled/app1
        ln -s /etc/nginx/sites-available/app2 /etc/nginx/sites-enabled/
        exec nginx -s reload


else
        cd /opt/config1
        docker-compose down -v
        docker-compose pull
        docker-compose up -d
        docker-compose scale "node=count"
        rm /etc/nginx/sites-enabled/app2
        ln -s /etc/nginx/sites-available/app1 /etc/nginx/sites-enabled/
        exec nginx -s reload
fi
