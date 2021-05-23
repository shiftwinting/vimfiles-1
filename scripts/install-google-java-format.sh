#!/bin/bash

function install_google_java_format() {
  echo "Install google-java-format.jar ..."
  echo ""
  curl -LO https://github.com/google/google-java-format/releases/download/v1.10.0/google-java-format-1.10.0.jar
  chmod u+x google-java-format-1.10.0.jar
  mkdir -p ~/.local/jars
  mv google-java-format-1.10.0.jar ~/.local/jars/google-java-format.jar

  echo ""
  echo "Installed google-java-format.jar!"
}

install_google_java_format
