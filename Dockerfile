FROM node:20.14 AS build

WORKDIR /app

COPY package*.json ./
COPY . .

RUN npm install

WORKDIR /app/client
RUN npm install
RUN npm run build

WORKDIR /app/server
RUN npm install

FROM node:20.14-alpine

WORKDIR /app

COPY --from=build /app/server /app/server
COPY --from=build /app/server/static /app/server/static
COPY --from=build /app/node_modules /app/node_modules
COPY --from=build /app/package*.json /app/

EXPOSE 3000 3100

CMD ["npm", "--workspace", "server", "start"]
