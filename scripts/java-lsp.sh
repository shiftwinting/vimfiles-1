#!/usr/bin/env bash

# see https://github.com/mfussenegger/nvim-jdtls

# lombok を認識できるようにする
# https://github.com/mfussenegger/nvim-jdtls/issues/33
# -data オプションで、ワークスペースのディレクトリを指定する必要がある

JAR="$HOME/.local/share/vim-lsp-settings/servers/eclipse-jdt-ls/plugins/org.eclipse.equinox.launcher_*.jar"
GRADLE_HOME=$HOME/gradle /usr/lib/jvm/java-11-openjdk/bin/java \
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.protocol=true \
  -Dlog.level=ALL \
  -Xms1g \
  -Xmx2G \
  -javaagent:$HOME/.local/share/vim-lsp-settings/servers/eclipse-jdt-ls/lombok.jar \
  -Xbootclasspath/a:$HOME/.local/share/vim-lsp-settings/servers/eclipse-jdt-ls/lombok.jar \
  -jar $(echo "$JAR") \
  -configuration "$HOME/.local/share/vim-lsp-settings/servers/eclipse-jdt-ls/config_linux" \
  -data "$1" \
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED \
  --add-opens java.base/java.lang=ALL-UNNAMED
