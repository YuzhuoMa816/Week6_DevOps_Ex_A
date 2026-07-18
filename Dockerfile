# dependency stage
FROM node:20-alpine3.21 AS builder

WORKDIR /server

COPY package*.json ./


RUN npm ci --omit=dev --no-cache


# ---------- Runtime stage ----------
FROM node:20-alpine3.21 AS runner

WORKDIR /server

RUN addgroup -S appgroup \
    && adduser -S appuser -G appgroup \
    && chown -R appuser:appgroup /server

COPY --from=builder --chown=appuser:appgroup /server/node_modules ./node_modules
COPY --chown=appuser:appgroup package*.json ./
COPY --chown=appuser:appgroup server.js ./

USER appuser

ENV NODE_ENV=production

ENV PORT=8080

EXPOSE 8080

CMD ["node", "server.js"]

