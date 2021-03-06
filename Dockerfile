FROM node:12.13-alpine As development
WORKDIR /usr/src/pr

COPY package*.json ./

RUN npm install --only=development

COPY . .

RUN npm run build

FROM node:12.13-alpine as production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/pr

COPY package*.json ./

RUN npm install --only=production

COPY . .

COPY --from=development /usr/src/pr/dist ./dist

CMD ["node", "dist/main"]