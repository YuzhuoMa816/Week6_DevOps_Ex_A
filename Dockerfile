FROM node:20-alpine3.21

WORKDIR /server

COPY package*.json ./


RUN npm install

COPY . .

RUN addgroup -S appgroup \
    && adduser -S appuser -G appgroup \
    && chown -R appuser:appgroup /server

USER appuser


ENV PORT=8080

EXPOSE 8080

CMD ["node", "server.js"]

