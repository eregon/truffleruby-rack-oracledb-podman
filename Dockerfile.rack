FROM ghcr.io/graalvm/truffleruby:ol8-22.3

# Install OracleDB headers
RUN dnf install -y oracle-release-el8
RUN dnf install -y oraclelinux-developer-release-el8
RUN dnf install -y oracle-instantclient-release-el8
RUN dnf install -y oracle-instantclient-devel

# Install nginx
RUN \
    # Explicitly disable PHP to suppress conflicting requests error
    dnf -y module disable php \
    && \
    dnf -y module enable nginx:1.20 && \
    dnf -y install nginx && \
    rm -rf /var/cache/dnf \
    && \
    # forward request and error logs to container engine log collector
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log
COPY default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80/tcp
EXPOSE 443/tcp
# STOPSIGNAL SIGQUIT

RUN echo 'export LANG=en_US.UTF-8' >> ~/.bashrc

WORKDIR /root/app

COPY puma.rb config/puma.rb
COPY startup.sh /root/startup.sh

COPY rackapp/Gemfile .
RUN bundle install

COPY rackapp/config.ru .

CMD ["/root/startup.sh"]
