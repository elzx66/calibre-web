FROM linuxserver/calibre-web:latest

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive

ARG MOD_VERSION
ARG CLEAN_VERSION
ARG ARCH="x86_64"
# 安装 xz 工具并清理 apt-get 缓存
RUN apt-get update && apt-get install -y xz-utils libnss3 && \
    rm -rf /var/lib/apt/lists/*
RUN \
  echo "installing tool packages" && \
  apt-get update && apt-get install -y xz-utils && \
  rm -rf /var/lib/apt/lists/* && \
  echo "Downloading Calibre latest version based on ARCH" && \
  MOD_VERSION=$(curl -sX GET "https://api.github.com/repos/kovidgoyal/calibre/releases/latest" \
      | jq -r '.tag_name') && \
  CLEAN_VERSION=$(echo "$MOD_VERSION" | cut -c 2-) && \
  if [ "$ARCH" = "x86_64" ]; then \
    curl -o \
        /calibre.txz -L \
        "https://download.calibre-ebook.com/${CLEAN_VERSION}/calibre-${CLEAN_VERSION}-x86_64.txz"; \
  elif [ "$ARCH" = "aarch64" ]; then \
    curl -o \
        /calibre.txz -L \
        "https://download.calibre-ebook.com/${CLEAN_VERSION}/calibre-${CLEAN_VERSION}-arm64.txz"; \
  fi && \
  echo "Installing Calibre" && \ 
  mkdir -p /app/calibre && \
  tar xf /calibre.txz -C /app/calibre && \
  /app/calibre/calibre_postinstall && \
  rm /calibre.txz && \
  echo "**** The 2 warnings above about setting up completion and desktop integration are expected and harmless. You can safely ignore them. ****"
