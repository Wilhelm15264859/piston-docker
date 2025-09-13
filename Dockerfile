FROM ghcr.io/engineer-man/piston:latest
# кладём наш конфиг внутрь образа
COPY config.yaml /piston/config.yaml
# (необязательно) явный CMD, в базовом образе уже так
CMD ["./piston"]
