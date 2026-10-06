FROM node:18-slim

WORKDIR /app

COPY package*.json ./

RUN npm pkg delete script.prepare || true \
    && npm ci --omit=dev

COPY . .

USER node

EXPOSE 5000

CMD ["node", "src/app.js"]