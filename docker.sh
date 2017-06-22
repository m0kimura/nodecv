#!/bin/bash
#
  project=${PWD##*/}
##
  if [[ $1 = "build" ]]; then
    docker build -t ${project} --build-arg user=$USER .
    library=$2
    module=$3
  elif [[ $1 = "push" ]]; then
    dex push
    exit
  else
    library=$1
    module=$2
  fi
##
  if [[ $library = "$null" ]]; then
    docker run -it --rm \
      -v $HOME/ドキュメント:/home/$USER/source \
      ${project}
  else
    if [[ ${module} = "$null" ]]; then
      docker run -it --rm \
        -v $HOME/${library}:/home/$USER/source \
        ${project}
    else
      docker run -it --rm \
        -v $HOME/${library}:/home/$USER/source \
        ${project} node ${module}
    fi
  fi
##

