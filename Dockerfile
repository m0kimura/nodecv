FROM m0kimura/opencv

ARG user
RUN apt-get update \
&&  apt-get install -y sudo software-properties-common nano nodejs npm \
      libopencv-dev \
&&  npm cache clean \
&&  npm install n -g \
&&  n 5.7 \
&&  ln -sf /usr/local/bin/node /usr/bin/node \
&&  ln /dev/null /dev/raw1394 \
&&  apt-get purge -y nodejs npm libopencv-dev \

&&  export uid=1000 gid=1000 \
&&  mkdir -p /home/${user} \
&&  echo "${user}:x:${uid}:${gid}:${user},,,:/home/${user}:/bin/bash" >> /etc/passwd \
&&  echo "${user}:x:${uid}:" >> /etc/group \
&&  echo "${user} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${user} \
&&  chmod 0440 /etc/sudoers.d/${user} \
&&  chown ${uid}:${gid} -R /home/${user} \

&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*

USER ${user}
WORkDIR /home/${user}
ENV USER=${user} HOME=/home/${user}
RUN npm install opencv
COPY starter.sh /home/${user}/starter.sh
VOLUME /home/${user}/source
WORKDIR /home/${user}/source

CMD $HOME/starter.sh

