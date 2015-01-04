FROM sdhibit/rpi-raspbian 

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y python-pip python-dev python-psycopg2 git subversion mercurial python-svn

RUN easy_install reviewboard

RUN pip install -U uwsgi

RUN apt-get install -y memcached
RUN apt-get install -y sqlite3
RUN apt-get install -y patch

ADD run.sh /bin/
ADD uwsgi.ini /uwsgi.ini
ADD shell.sh /shell.sh

VOLUME ["/.ssh", "/media/", "/data"]

EXPOSE 8000

CMD /bin/run.sh
