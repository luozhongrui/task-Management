# 第一阶段：构建前端
FROM node:16-alpine AS frontend-builder
WORKDIR /app/client
# 安装依赖并构建生产版本（假设使用 npm）
RUN npm install && npm run build

# 第二阶段：构建 Go 后端
FROM golang:1.18-alpine AS backend-builder
WORKDIR /app
# 复制 Go 模块文件
COPY go.mod go.sum ./
# 修改 go.mod 中的 Go 版本，将 "go 1.23.5" 替换为 "go 1.23"
RUN sed -i 's/go 1\.23\.5/go 1.23/' go.mod
# 下载依赖
RUN go mod download
# 复制项目源代码（包括 client 文件夹，以便后端可以服务静态文件）
COPY . .
# 编译后端可执行文件（假设生成的二进制文件名为 main）
RUN go build -o main .

# 第三阶段：构建最终镜像
FROM alpine:latest
WORKDIR /app
# 从后端构建阶段复制可执行文件
COPY --from=backend-builder /app/main .
# 从前端构建阶段复制构建好的静态文件到后端指定目录（这里假设后端会提供静态文件服务）
COPY --from=frontend-builder /app/client/dist ./client/dist
# 设置必要的环境变量，例如端口
ENV PORT=3000
EXPOSE 3000
CMD ["./main"]
