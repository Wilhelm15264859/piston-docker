FROM node:18-alpine

# Нужны curl+tar для скачивания архива
RUN apk add --no-cache curl tar

WORKDIR /app

# Тянем piston-api как tar.gz (без git). Пробуем main, затем master.
RUN set -eux; \
  for BR in main master; do \
    if curl -fsSL "https://codeload.github.com/engineer-man/piston-api/tar.gz/refs/heads/$BR" \
      | tar -xz --strip-components=1; then \
      exit 0; \
    fi; \
  done; \
  echo "Failed to fetch piston-api" >&2; exit 1

# Ставим прод-зависимости
RUN npm ci --only=production || npm install --only=production

# Конфиг: sandbox в /tmp (Railway разрешает запись туда)
COPY config.yaml /app/config.yaml

ENV PORT=2000
# У piston-api входная точка — index.js в корне
CMD ["node", "index.js"]
