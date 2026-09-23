FROM node:latest

WORKDIR /app

COPY . /app

RUN npm install express mysql2 dotenv

CMD ["node" , "server.js"]

EXPOSE 3000
