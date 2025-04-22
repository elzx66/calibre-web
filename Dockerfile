FROM linuxserver/calibre-web:latest

# 设置 DOCKER_MODS 环境变量，指定要安装的 mod
ENV DOCKER_MODS=linuxserver/mods:universal-calibre
