FROM linuxserver/calibre-web:latest

# # 设置 DOCKER_MODS 环境变量，指定要安装的 mod
# ENV DOCKER_MODS=linuxserver/mods:universal-calibre

# # 构建镜像时可能会触发 mod 安装（取决于基础镜像脚本）
# RUN /init

# ENV DOCKER_MODS=

# 更新软件包列表
RUN apt-get update

# 安装必要的工具
RUN apt-get install -y --no-install-recommends curl tar

# 清理 apt-get 缓存以减小镜像大小
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# 定义 mod 的下载和安装目录
ENV MOD_DIR="/mods"
RUN mkdir -p $MOD_DIR

# 下载并安装 universal-calibre mod
RUN curl -L -o $MOD_DIR/universal-calibre.tar.gz \
    https://github.com/linuxserver/docker-mods/raw/universal-calibre/root.tar.gz && \
    tar -xzf $MOD_DIR/universal-calibre.tar.gz -C / && \
    rm $MOD_DIR/universal-calibre.tar.gz

# 可选：可以添加其他自定义操作，例如再次更新软件包列表
RUN apt-get update && apt-get clean && rm -rf /var/lib/apt/lists/*
