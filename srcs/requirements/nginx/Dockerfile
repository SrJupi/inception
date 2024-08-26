FROM debian:bullseye

RUN apt update -y && apt install nginx openssl netcat -y  && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*
RUN mkdir -p /etc/ssl/private
RUN mkdir -p /etc/ssl/certs
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/inception.key \
	-out /etc/ssl/certs/inception.cert \
	-subj "/CN=lsulzbac.42.fr"

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
