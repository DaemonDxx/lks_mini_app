FROM node:23-alpine AS build

WORKDIR /app

RUN yarn global add @quasar/cli

COPY . .

RUN yarn install --ignore-engines

RUN quasar build

FROM nginx:1.27.3-alpine AS prod

COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist/spa /usr/share/nginx/html/lks

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
