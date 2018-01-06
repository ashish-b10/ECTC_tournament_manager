#!/bin/sh

# Start Gunicorn processes
#echo Starting Gunicorn.
#exec gunicorn ectc_tm_server.wsgi:application \
#    --bind 0.0.0.0:8000 \
#    --workers 3

# Install PostgreSQL
#brew install postgres
#brew services start postgresql
sudo apt-get install postgresql postgresql-contrib
sudo /etc/init.d/postgresql start

# Create user and database
createuser tmdb -d
createdb tmdb

# Customize Postgres configuration file
cp pg_hba.conf /usr/local/var/postgres/

# Restart to make changes apply
# brew services restart postgresql
/etc/init.d/postgresql restart

# Set up PostgreSQL for Django
python manage.py makemigrations tmdb && python manage.py migrate

echo Starting ECTC_tournament_server
python manage.py runserver
