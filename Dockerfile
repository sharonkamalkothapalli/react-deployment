# Step:1 Build React App
FROM node:alpine3.20 as build
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Step 2: Server with Nginx
FROM Nginx:1.23-alpine3
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/build .
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "deamon off;"]
