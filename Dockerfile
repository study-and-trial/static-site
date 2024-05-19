# Stage 1: Build
FROM node:16-alpine as build
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve with nginx
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY my-static-app.conf /etc/nginx/conf.d/
EXPOSE 5000
CMD ["nginx", "-g", "daemon off;"]
