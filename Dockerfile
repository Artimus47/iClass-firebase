# Stage 1: Build Vue.js app
FROM node:20-alpine AS build-stage
WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY . .
RUN npm run build

# Stage 2: Serve Vue.js app with Nginx
FROM nginx:1.27-alpine
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Optional: remove default nginx config and add your own
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
