FROM node:14-alpine
WORKDIR /mern_app/login-and-register-backend
COPY package*.json ./
COPY build ../login-and-register-backend
RUN npm install
COPY login-and-register-backend .
EXPOSE 3001
# CMD ["node", "index.js"]
CMD ["sh", "-c", "sleep 10 && node index.js"]
