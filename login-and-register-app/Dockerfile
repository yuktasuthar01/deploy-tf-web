# Use node image as base
FROM node:18.17.0 as builder


RUN mkdir -p /app
WORKDIR /app


COPY package*.json ./

RUN npm install
COPY . ./
RUN npm run build
EXPOSE 3000
CMD ["npm", "start"]
