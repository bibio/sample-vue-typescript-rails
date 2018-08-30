FROM amazonlinux:2.0.20180622.1
ENV LANG C.UTF-8

RUN yum -y update
RUN yum -y install yum-utils git gcc gcc-c++ bzip2 openssl-devel readline-devel zlib-devel postfix vim tar make sqlite-devel

RUN curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
RUN curl -sL https://rpm.nodesource.com/setup_8.x | bash -
RUN yum -y install nodejs yarn

RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN /root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/shims:/root/.rbenv/bin:$PATH
RUN echo 'export PATH=$PATH' >> /root/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> /root/.bashrc

RUN rbenv install 2.5.1
RUN rbenv global 2.5.1
RUN rbenv exec gem install bundler

ENV APP_HOME /app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME
VOLUME $APP_HOME
EXPOSE 3000
EXPOSE 1048

ADD Gemfile* $APP_HOME/
RUN gem update --system
RUN bundle install
RUN yarn install
