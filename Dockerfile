# Сборка piston-api из исходников, без GHCR
FROM node:18-alpine

# Нужные утилиты
RUN apk add --no-cache git python3 make g++ bash

# Папка приложения
WORKDIR /app

# Клонируем исходники Piston и копируем только piston-api
RUN git clone --depth=1 https://github.com/engineer-man/piston /src \
 && cp -r /src/piston-api/* /app \
 && rm -rf /src

# Прод зависимости
RUN npm ci --only=production || npm install --only=production

# Конфиг (создадим ниже)
COPY config.yaml /app/config.yaml

# Порт API
ENV PORT=2000

# Старт
CMD ["node", "index.js"]
