FROM alpine:latest



# 最低限必要なパッケージ
RUN apk update && \
    apk upgrade  &&\
    apk add curl tar git ripgrep git neovim
RUN apk -U add --repository http://dl-cdn.alpinelinux.org/alpine/edge/community deno~=1.42.1-r0

#RUN apt-get update && \
#    apt-get update && \
#    apt-get -y install curl unzip git 

RUN mkdir -p /root/apps

# dotfiles を配置
RUN cd /root/apps && \
    git clone https://github.com/raryo/dot_files.git && \
    mv dot_files/nvim ./nvim_config && \
    rm -rf dot_files
RUN mkdir -p /root/.config/ && \
    mv /root/apps/nvim_config /root/.config/nvim

#RUN cd /root/apps && \
#    curl -LO https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage && \
#    chmod u+x nvim.appimage

# SKKの辞書を配置
RUN cd /root/apps && \
    mkdir  skk && \
    cd skk/ && \
    curl -LO https://skk-dev.github.io/dict/SKK-JISYO.L.gz && \
    gunzip SKK-JISYO.L.gz 


# ビルドしたバイナリをコピー

#ENTRYPOINT ["./deno"]
CMD ["nvim"]
