# Stage 1: Build the frontend
FROM node:18.17.0 AS frontend-build
WORKDIR /app
COPY login-and-register-app/package.json .
RUN npm install
COPY login-and-register-app .
RUN npm run build

# Stage 2: Build the backend
FROM node:18.17.0 AS backend-build
WORKDIR /app
COPY login-and-register-backend/package.json .
RUN npm install
COPY login-and-register-backend .
COPY --from=frontend-build /app/build /app/login-and-register-backend/build
RUN npm run build

# Final stage: Production-ready image
FROM node:18.17.0
WORKDIR /app
COPY --from=backend-build /app/login-and-register-backend .
EXPOSE 3000
CMD ["npm", "start"]
