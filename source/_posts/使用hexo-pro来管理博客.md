---
title: 使用hexo-pro来管理博客
author: John Doe
date: 2025-08-19 17:25:53
tags:
---
#### **Hexo Pro**（现代化推荐）

hexo-pro是hexo得后台管理平台，这样就不用去编辑md文件了，他有很多功能，如文章/页面管理、图床集成、可视化配置编辑、全局搜索、多用户权限。

一、安装步骤

1.如果安装了hexo-admin，执行下面的命令 npm remove hexo-admin
2.安装hexo-pro执行下面的命令
npm install --save hexo-pro
hexo server -d

二、访问后台管理

http://localhost:4000/pro/

三、部署到远程服务器

1. 目录结构

/your/blog/path/
├── docker-compose.yml
└── hexo-data/          # 挂载的Hexo项目目录
├── _config.yml
├── source/
├── themes/
└── package.json

2. 创建 `docker-compose.yml`

version: '3'
services:
hexo-blog:
image: node:18-alpine
container_name: hexo-blog
ports:

- "4000:4000"    # Hexo Pro管理后台
- "80:80"        # 博客访问端口
  volumes:
- ./hexo-data:/app  # 挂载整个Hexo项目
  working_dir: /app
  command: >
  sh -c "npm install -g hexo-cli &&
  npm install &&
  npm install hexo-pro --save &&
  nginx -g 'daemon off;' &  # 启动Nginx服务静态文件
  hexo server -d -p 4000"   # 启动Hexo Pro
  restart: unless-stopped

3.配置 Hexo 自动部署

部署配置（根据你的需求选择一种）

deploy:

方案1: 部署到同一容器的Nginx

type: exec
command: cp -r public/* /usr/share/nginx/html/

方案2: 部署到GitHub Pages

type: git

repo: https://github.com/yourname/yourname.github.io.git

branch: main

方案3: 部署到云存储

type: oss

bucket: your-bucket-name

4.迁移方案

备份

tar -czf blog-backup.tar.gz hexo-data/

在新服务器恢复

tar -xzf blog-backup.tar.gz
docker-compose up -d
