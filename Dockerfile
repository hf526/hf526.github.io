FROM node:18-alpine

# 安装基础工具
RUN apk add --no-cache git nginx

# 设置工作目录
WORKDIR /app

# 复制Hexo源码
COPY . .

# 安装依赖
RUN npm install -g hexo-cli && npm install

# 暴露端口
EXPOSE 80 4000

# 启动脚本
CMD sh -c 'nginx && hexo server -d -p 4000'