# Lemmy

Lemmy is a self-hosted, federated social link aggregation and discussion forum.

The original documentation is lacking, so here is a guide on how to set it up:

First, clone this repository:

```sh
cd ~/
git clone https://github.com/404invalid-user/server-scripts
```


Move the cloned folder to your desired location. I prefer using /opt/, so I will place it there:

```sh
sudo mv server-scripts/docker-compose/lemmy /opt/
```


Navigate to the Lemmy directory:

```sh
cd /opt/lemmy
```



Open the docker-compose.yml file with a text editor:

```sh
sudo nano docker-compose.yml
```



Use the search function (`Ctrl + W`) to find and replace `<DOMAIN>` with the domain where your Lemmy instance will run.
Find and replace `<DB PASSWORD>` with a secure password for your database.
Save and exit the file using `Ctrl + S` and `Ctrl + X`.

Open the config file:

```sh
sudo nano lemmy.hjson
```



(The full configuration file can be found at https://github.com/LemmyNet/lemmy/blob/main/config/defaults.hjson)
Replace all the details with your own configuration, then save and exit the file using `Ctrl + S` and `Ctrl + X`.


Run Lemmy using Docker Compose:

```sh
sudo docker-compose up -d
```
Verify that Lemmy is running by visiting `http://<server ip>:5234`. Note that it won't work yet, as we need to set up a reverse proxy. 

For this example i am using nginx, and I have provided the configuration file at ./nginx.conf (similar to the example provided in the Lemmy documentation).

Move the Nginx configuration file:

```sh
sudo mv ~/server-scripts/docker-compose/lemmy/nginx.conf /etc/nginx/sites-enabled/lemmy.conf
```



Open the configuration file and replace `<DOMAIN>` with the domain you specified in the Docker Compose and Lemmy configuration files:

```sh
sudo nano /etc/nginx/sites-enabled/lemmy.conf
```



Save and exit the file using `Ctrl + S` and `Ctrl + X`.

Restart Nginx:

```sh
sudo nginx -s reload
```


You should now be good to go! If you want Lemmy to federate with other servers, you will need to set up SSL/HTTPS for your domain. You can follow the [Let's Encrypt Certbot instructions](https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal).

Also, note that federation may take a while to load the groups and posts, so be patient.




