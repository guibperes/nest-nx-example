FROM node:18-alpine as BUILDER

WORKDIR /build
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:18-alpine as PRODUCTION_DEPENDENCIES

WORKDIR /build
COPY package*.json ./
RUN npm ci --omit=dev

FROM node:18-alpine

ARG APPLICATION_NAME
WORKDIR /app
COPY --from=PRODUCTION_DEPENDENCIES /build/node_modules /app/node_modules
COPY --from=BUILDER /build/dist/apps/${APPLICATION_NAME} /app/dist

CMD ["node", "dist/main.js"]


