You can run this api using Docker or simply use MAMP and shell

Important commands:
- export FLASK_APP=api.py
- export FLASK_ENV=development

To dockerize the Api and Model
- cd/Model && docker build -t flask-db:latest . && docker run -d -p 6000:3306 --name flask-db \-e MYSQL_ROOT_PASSWORD=root flask-db
- cd/Api && docker build -t flask-api:latest . && docker run -d -p 5000:5000 --add-host=flask-db:172.17.0.1 --name flask-api flask-api
