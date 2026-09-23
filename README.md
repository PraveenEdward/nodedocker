## CRUD-enabled Node.js app using Express and MySQL to manage a name list.
### Features:

✅ Add a name  
✅ Get all names  
✅ Get a name by ID  
✅ Update a name  
✅ Delete a name  

## Clone the Repo in your Machine
```
git clone https://github.com/PraveenEdward/nodedocker.git
```


## Option 1 : Run the application without docker compose, run seperate containers using docker network & volumes [ mysql, application, nginx ]

Step1: create docker network

```
docker network create <docker-network-name>
```

Step2: run mysql container

```
docker run -d --name <mysql-container-name> --network <docker-network-name> -e MYSQL_ROOT_PASSWORD=toor -e MYSQL_DATABASE=node -p 3306:3306 mysql:latest
```

Step3: Install mysql-client on server

```
sudo apt install mysql-client -y
```

step4: verify the DB container status by connecting using mysql client

```
sudo mysql -h 127.0.0.1 -u root -p
```

step5: configure the db credentials on database.env file

```
sudo nano database.env
```
```env
DB_HOST=<mysql-container-name>
DB_USER=root
DB_PASS=toor
DB_NAME=node
```

Save and exit:

- `Ctrl + O` → Save
- `Enter` → Confirm
- `Ctrl + X` → Exit

step6: build docker image 

```
docker build -t <image-name>:<tag-name> .
```

step7: run node application container.

```
docker run -d --name <node-container-name> --network <docker-container-network> -p 3000:3000 <image-name>:<tag-name>
```


step8: Edit the default.conf file for nginx reversy proxy to node container
```
sudo nano nginx/default.conf

```

add :
```
server {
    listen 80;

    location / {
        proxy_pass http://<node-container-name>:3000;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```
ctrl + o = save
ctrl + x = exit

step9: run nginx container with docker volume to inject reverse proxy config file
```
docker run -d --name <nginx-container-name> --network <docker-network-name> -v /<path>/nginx/default.conf:/etc/nginx/conf.d/default.conf -p 80:80 nginx:latest
```



### Option 2 run the docker compose file to build and run all container simultaneously

```
docker compose up -d --build
```


## Access the application on browser

http://<server-ip>



## Thank you !
