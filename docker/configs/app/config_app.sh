#!/bin/bash


cd /var/www/aplicacion-devops;

php composer.phar update -n
chmod -R 777 storage bootstrap/cache
