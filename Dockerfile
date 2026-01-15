FROM node:18-alpine AS builder

WORKDIR /myapp

COPY package*.json ./
RUN npm install

COPY . . 
RUN npm run build

# ---------- Runtime Stage ----------
FROM nginx:alpine

COPY --from=builder /myapp/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
