#########################################################################
FROM node:14 AS build

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .
#########################################################################
FROM gcr.io/distroless/nodejs18-debian12

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/server.js ./
COPY --from=build /usr/src/app/database.js ./
COPY --from=build /usr/src/app/views ./views

EXPOSE 3000

CMD ["server.js"]