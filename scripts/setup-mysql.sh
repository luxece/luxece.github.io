#!/bin/bash

mkdir -p mysql
cd mysql

read -p "Nhập tên database name: " DB_NAME
DB_NAME=${DB_NAME:-my_db}
read -p "Nhập tên database user: " DB_USER
DB_USER=${DB_USER:-user}
read -p "Đặt password cho database $DB_USER: " DB_PASSWORD
DB_PASSWORD=${DB_PASSWORD:-@#mysql}
read -p "Đặt root password: " MYSQL_ROOT_PASSWORD
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-password@123}

cat <<EOF > docker-compose.yml
version: "3.8"

services:
  mysql:
    image: mysql:5.7
    container_name: mysql
    restart: always
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: "$MYSQL_ROOT_PASSWORD"
      MYSQL_DATABASE: "$DB_NAME"
      MYSQL_USER: "$DB_USER"
      MYSQL_PASSWORD: "$DB_PASSWORD"
    volumes:
      - ./mysql_data:/var/lib/mysql
    networks:
      - wpnet

volumes:
  mysql_data:
    external: true

networks:
  wpnet:
    driver: bridge
    external: true
EOF

docker rm -f mysql 2>/dev/null
docker rmi mysql:5.7 2>/dev/null
mkdir -p mysql_data

docker network create wpnet

docker compose down -v
docker compose up -d
