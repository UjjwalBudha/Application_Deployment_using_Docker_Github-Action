FROM nginx:latest

RUN apt-get update && apt-get install -y net-tools

COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]