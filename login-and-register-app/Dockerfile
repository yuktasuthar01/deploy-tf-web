FROM node:18.17.0 as Builder
WORKDIR /mern_app/login-and-register-app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
EXPOSE 3000
CMD ["npm", "start"]