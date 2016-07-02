#!/bin/bash
set -e

uwsgi --ini /etc/uwsgi/init/uwsgi.ini 

nginx -g 'daemon off;'
#python manage.py runserver 0.0.0.0:8000
