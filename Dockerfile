#####
# Base docker image for running Evennia-based games in a container.
#
# Install:
#   install `docker` (http://docker.com)
#
# Usage:
#    cd to a folder where you want your game data to be (or where it already is). 
#
#	docker run -it -p 4000:4000 -p 4001:4001 -p 4005:4005 -v $PWD:/usr/src/game evennia/evennia
#    
#    (If your OS does not support $PWD, replace it with the full path to your current 
#    folder).
#
#    You will end up in a shell where the `evennia` command is available. From here you
#    can install and run the game normally. Use Ctrl-D to exit the evennia docker container.
#
# The evennia/evennia base image is found on DockerHub and can also be used
# as a base for creating your own custom containerized Evennia game. For more
# info, see https://github.com/evennia/evennia/wiki/Running%20Evennia%20in%20Docker .
#
FROM alpine

MAINTAINER www.evennia.com

# install compilation environment
RUN apk update && apk add python py-pip python-dev py-setuptools gcc musl-dev jpeg-dev zlib-dev bash py2-openssl

# add the project source
ADD . /usr/src/evennia

# install dependencies
<<<<<<< HEAD
RUN pip install -e /usr/src/evennia
=======
RUN pip install -e /usr/src/evennia --trusted-host pypi.python.org
>>>>>>> df664f0ee6882e10b59379b125a30c55fe28502c

# add the game source when rebuilding a new docker image from inside
# a game dir 
ONBUILD ADD . /usr/src/game

# make the game source hierarchy persistent with a named volume.
# mount on-disk game location here when using the container
# to just get an evennia environment.
VOLUME /usr/src/game

# set the working directory
WORKDIR /usr/src/game

# set bash prompt
ENV PS1 "evennia|docker \w $ "

# startup a shell when we start the container
ENTRYPOINT  ["bash"]

# expose the telnet, webserver and websocket client ports
EXPOSE 4000 4001 4004 4005
