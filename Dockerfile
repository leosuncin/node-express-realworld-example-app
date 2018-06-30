FROM node:8.9.1 AS dependencies
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm set progress=false &&\
  npm config set depth 0 &&\
  npm config set loglevel error &&\
  npm install --production

FROM gcr.io/distroless/nodejs
WORKDIR /srv/app
COPY --from=dependencies /usr/src/app/node_modules ./node_modules
CMD app.js