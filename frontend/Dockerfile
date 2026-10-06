# Builder
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm pkg delete scripts.prepare || true \
    && npm ci --legacy-peer-deps

COPY . .

RUN npm run build

# Nginx
FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
