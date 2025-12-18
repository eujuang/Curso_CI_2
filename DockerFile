# =========================
# ETAPA 1 - BUILD
# =========================
FROM golang:1.22-alpine AS builder

WORKDIR /app

# Copia dependências
COPY go.mod go.sum ./
RUN go mod download

# Copia o código
COPY . .

# Compila o app
RUN go build -o app

# =========================
# ETAPA 2 - RUNTIME
# =========================
FROM alpine:latest

WORKDIR /app

# Copia o binário gerado
COPY --from=builder /app/app .

# Variáveis iguais ao docker-compose
ENV HOST=postgres
ENV PORT=5432
ENV USER=root
ENV PASSWORD=root
ENV DBNAME=root

# Porta que o app expõe
EXPOSE 8080

# Comando de start
CMD ["./app"]
