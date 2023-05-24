# 使用Node.js镜像作为构建阶段的基础镜像
FROM node:14 as build

WORKDIR /app

# 复制package.json和package-lock.json
COPY package*.json ./

# 安装依赖
RUN npm install

# 复制源代码
COPY . .

# 进行生产构建
RUN npm run dev

# 使用nginx镜像作为运行阶段的基础镜像
FROM nginx:stable-alpine as run

# 将构建阶段生成的/dist目录复制到nginx的公共文件夹
COPY --from=build /app/dist /usr/share/nginx/html

# 替换默认的nginx配置文件
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
