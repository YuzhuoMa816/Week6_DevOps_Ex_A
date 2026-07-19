# ---------- Dependencies stage ----------
FROM node:22-alpine3.22 AS builder

WORKDIR /server

RUN apk upgrade --no-cache

COPY package*.json ./

RUN npm ci --omit=dev --ignore-scripts \
    && npm cache clean --force


# ---------- Runtime stage ----------
FROM node:22-alpine3.22 AS runner

WORKDIR /server

ENV NODE_ENV=production
ENV PORT=8080

RUN apk upgrade --no-cache \
    && addgroup -S appgroup \
    && adduser -S appuser -G appgroup \
    && chown -R appuser:appgroup /server

COPY --from=builder --chown=appuser:appgroup /server/node_modules ./node_modules
COPY --chown=appuser:appgroup server.js ./

USER appuser

EXPOSE 8080

CMD ["node", "server.js"]