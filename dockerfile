FROM node:23-alpine3.19 AS build

WORKDIR /app

COPY package.json yarn.lock ./

RUN npm install -g yarn && yarn install

COPY . .

RUN yarn build

EXPOSE 3000

CMD [ "yarn", "dev"]

# 
FROM nginx:1.27.2-alpine

WORKDIR /usr/share/nginx/html

COPY --from=build build/ /app 