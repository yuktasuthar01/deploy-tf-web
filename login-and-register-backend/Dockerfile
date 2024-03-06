FROM node:14-alpine

# Create and set the working directory for backend
WORKDIR /mern_app/login-and-register-backend

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install backend dependencies
RUN npm install

# Create and set the working directory for frontend
WORKDIR /mern_app/login-and-register-frontend

# Copy build directory from frontend to backend
COPY --from=builder /mern_app/login-and-register-frontend/build /mern_app/login-and-register-backend/build

# Change the working directory back to backend
WORKDIR /mern_app/login-and-register-backend

# Copy backend code
COPY . .

# Expose port 3001
EXPOSE 3001

# Start the backend application
CMD ["node", "index.js"]
