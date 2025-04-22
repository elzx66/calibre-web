FROM linuxserver/calibre-web:latest

# 设置 DOCKER_MODS 环境变量，指定要安装的 mod
ENV DOCKER_MODS=linuxserver/mods:universal-calibre

# 构建镜像时可能会触发 mod 安装（取决于基础镜像脚本）
RUN /init

ENV DOCKER_MODS=
