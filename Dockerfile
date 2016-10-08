FROM phusion/baseimage:0.9.16

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y nginx
RUN apt-get install -y php5-fpm

ADD default /etc/nginx/sites-available/default
ADD default-lb /default-lb
ADD test.php /usr/share/nginx/html/test.php
ADD start-server.sh start-server.sh
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini

RUN rm -rf /var/lib/apt/lists/*
VOLUME ["/etc/nginx", "/usr/share/nginx","/etc/php5"]
ENTRYPOINT ["start-server.sh"]

