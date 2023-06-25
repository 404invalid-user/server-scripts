# Nextcloud


First, clone this repository:

```sh
cd ~/ ; git clone https://github.com/404invalid-user/server-scripts
```

Move the cloned folder to your desired location. I prefer using /opt/, so I will place it there:

```sh
sudo mv server-scripts/docker-compose/nextcloud /opt
```

Navigate to the Nextcloud directory:

```sh
cd /opt/nextcloud
```

Open the docker-compose.yml file with a text editor:

```sh
sudo nano docker-compose.yml
```

Use the search function (Ctrl + W) to find and replace your_root_password and your_nextcloud_db_password with a secure password for your database. Save and exit the file using Ctrl + S and Ctrl + X.

Run Nextcloud using Docker Compose:

```sh
sudo docker-compose up -d
```

Verify that Nextcloud is running by visiting http://<server ip>:5082. Note that it won't work yet, as we need to set up a reverse proxy.

For this example, I am using Nginx, but it doesn't really matter because I'm not showing you that end of things.

Now we need to edit some things in the config file. So first, let's look for the Nextcloud Docker volume:

```sh
sudo docker volume inspect nextcloud_nextcloud --format '{{.Mountpoint}}'
```

If you put the Docker Compose file in another folder not named "nextcloud", you will want to change nextcloud to that folder name.

Then cd to that directory it gave you:

```sh
cd /var/lib/docker/volumes/nextcloud_nextcloud/_data
```

If yours is different, edit your path accordingly.

Now let's open the config:

```sh
sudo nano config/config.php
```

Add this somewhere at the top:

```php
'overwriteprotocol' => 'https',
```

Then add your domain to the trusted domains array. Now save and exit using Ctrl + S and Ctrl + X.

Now we want to set up the cron job. I prefer the method of having it on the host and running Docker's exec command. First, open your crontab file:

```sh
sudo nano /etc/crontab
```

Go to the bottom and add this line:

```sh
*/5 * * * * root /usr/bin/docker exec -u www-data nextcloud-app-1 php -f /var/www/html/cron.php
```

If you put the Docker Compose file in another folder not named "nextcloud", you will want to change nextcloud to that folder name.

Save and exit the file using Ctrl + S and Ctrl + X.

Set up your reverse proxy. Now go to https://domain.com/settings/admin and switch background jobs to the cron one.

And we are done!
