FROM node:18-alpine

RUN apk add --no-cache git python3 make g++ bash
WORKDIR /app

# Клонируем ТОЛЬКО API
RUN git clone --depth=1 https://github.com/engineer-man/piston-api /app

# Ставим прод-зависимости
RUN npm ci --only=production || npm install --only=production

# Конфиг: sandbox в /tmp (Railway разрешает)
COPY config.yaml /app/config.yaml

ENV PORT=2000
CMD ["node", "index.js"]
