#!/bin/bash


function install_google_java_format() {
  version='1.10.0'

  echo "Install google-java-format.jar ..."
  echo ""
  # https://github.com/google/google-java-format/issues/398
  # java -jar で実行するなら、 *-all-deps を使う必要がある
  curl -LO https://github.com/google/google-java-format/releases/download/v${version}/google-java-format-${version}-all-deps.jar
  chmod u+x google-java-format-${version}-all-deps.jar
  mkdir -p ~/.local/jars
  mv google-java-format-${version}-all-deps.jar ~/.local/jars/google-java-format.jar

  echo ""
  echo "Installed google-java-format.jar!"
}

install_google_java_format
