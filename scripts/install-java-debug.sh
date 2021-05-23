#!/bin/bash

function install_java_debug() {
  mkdir -p $HOME/.local
  cd $HOME/.local
  git clone https://github.com/microsoft/java-debug
  cd java-debug
  ./mvnw clean install
}

install_java_debug
