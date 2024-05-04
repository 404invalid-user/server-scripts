# Redis Docker Compose

get the redis config from here https://redis.io/docs/latest/operate/oss_and_stack/management/config-file/ and place it in a `redis.conf` file in the same directory as your docker-compose.yml file

eg:

mkdir /opt/redis

cd /opt/redis

curl -o https://raw.githubusercontent.com/404invalid-user/server-scripts/main/docker-compose/redis/docker-compose.yml ./docker-compose.yml

nano redis.conf
