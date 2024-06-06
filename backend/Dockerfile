FROM node:14

WORKDIR /usr/src/app

COPY package*.json ./
RUN apt-get update && apt-get install -y net-tools
RUN npm install

COPY . .

EXPOSE 3000
CMD [ "node", "server.js" ]