# dependency stage
FROM node:22.14.0-alpine3.22 AS builder

WORKDIR /server

RUN apk upgrade --no-cache

COPY package*.json ./


RUN npm ci --omit=dev --no-cache --audit --fund=false


# ---------- Runtime stage ----------
FROM node:22.14.0-alpine3.22 AS runner

WORKDIR /server

RUN addgroup -S appgroup \
    && adduser -S appuser -G appgroup \
    && chown -R appuser:appgroup /server

COPY --from=builder --chown=appuser:appgroup /server/node_modules ./node_modules
COPY --chown=appuser:appgroup package*.json ./
COPY --chown=appuser:appgroup server.js ./

USER appuser

ENV PORT=8080

EXPOSE 8080

CMD ["node", "server.js"]

