# DOCKER-VERSION 0.4.8

# am facing issue
# https://github.com/dotcloud/docker/issues/1123

FROM ubuntu:12.04

MAINTAINER Deepak Kannan "deepak@codemancers.com"

RUN apt-get -y install python-software-properties
RUN apt-get -y update

# install essentials
RUN apt-get -y install build-essential
RUN apt-get install -y git-core

RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get -y update
RUN apt-get install -y -q nginx

# Install rbenv
RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN echo '# rbenv setup' > /etc/profile.d/rbenv.sh
RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN chmod +x /etc/profile.d/rbenv.sh

# install ruby-build
RUN mkdir /usr/local/rbenv/plugins
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build
RUN cd /usr/local/rbenv/plugins/ruby-build && ./install.sh

#ENV RBENV_ROOT /usr/local/rbenv

#ENV PATH "$RBENV_ROOT/bin:$RBENV_ROOT/shims:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
# does not work. PATH is set to
# $RBENV_ROOT/shims:$RBENV_ROOT/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get install -y zlib1g-dev openssl libssl-dev libreadline-dev curl

# install ruby
RUN /bin/bash -l -c 'rbenv install 2.0.0-p247 && rbenv global 2.0.0-p247 && rbenv rehash'
RUN /bin/bash -l -c 'gem install bundler'

# Application dependencies
RUN apt-get -y install libxml2-dev libxml2 libxslt1-dev libxslt1.1 libmysqlclient-dev libpq-dev libsqlite3-dev

# Get our code into the container
ADD tmp/deploy /application

# Add our little shim
ADD shim.sh /usr/bin/app-shim
