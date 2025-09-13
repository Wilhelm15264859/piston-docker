FROM node:18-alpine

RUN apk add --no-cache git python3 make g++ bash

WORKDIR /app

# Клонируем репозиторий и копируем всё содержимое в /app
RUN git clone --depth=1 https://github.com/engineer-man/piston /src \
    && cp -r /src/* /app \
    && rm -rf /src

RUN npm ci --only=production || npm install --only=production

# Конфиг для Railway (sandbox в /tmp)
COPY config.yaml /app/config.yaml

ENV PORT=2000
CMD ["node", "index.js"]
