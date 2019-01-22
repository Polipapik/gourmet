FROM alpine:latest

RUN apk add --no-cache \
        libc6-compat

RUN mkdir -p /app
WORKDIR /app

ADD svc-receiver /app
EXPOSE 9092
CMD ["./svc-receiver"]