# Build stage
FROM node:20-alpine AS client-builder
WORKDIR /app/client
COPY client/package*.json ./
RUN npm install
COPY client .
RUN npm run build

FROM golang:1.23-alpine AS server-builder
WORKDIR /app
COPY go.* ./
RUN go mod download
COPY . .
COPY --from=client-builder /app/client/dist ./client/dist

# Install Air
RUN go install github.com/air-verse/air@latest


FROM golang:1.23-alpine
WORKDIR /app

# Copy Air config
COPY air.toml .

# Copy necessary files from builders
COPY --from=server-builder /go/bin/air /bin/air
COPY --from=server-builder /app/client/dist ./client/dist
COPY --from=server-builder /app/go.mod /app/go.sum ./
COPY --from=server-builder /app/*.go ./

# Install necessary dependencies
RUN apk add --no-cache libc6-compat

EXPOSE 5000

CMD ["air", "-c", "air.toml"]
