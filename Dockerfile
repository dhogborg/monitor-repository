FROM stilliard/pure-ftpd

MAINTAINER David Högborg <d@hogborg.se>

RUN apt-get update && apt-get install -y ca-certificates

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -yq install cron 
        
# add our scripts
ADD rotate.sh /rotate.sh
ADD run.sh /run.sh

# make em excutable
RUN chmod 755 /*.sh

# add our crontab file
ADD config/crontab.txt /config/crontab.txt

# use the crontab file
RUN crontab /config/crontab.txt

# go!
CMD /run.sh