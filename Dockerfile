# Stage 1: Build React App
FROM node:18 as build

WORKDIR /app
COPY client/package*.json ./
RUN npm install

COPY client/ ./
RUN npm run build

# Stage 2: Nginx Server
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

# Custom Nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]