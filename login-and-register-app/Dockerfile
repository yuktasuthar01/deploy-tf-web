FROM node:18.17.0

# Using a common convention for the working directory
WORKDIR /login-and-register-app

# Copy package.json file
COPY package*.json .

# Install dependencies
RUN npm install

# Copy all project files and directories
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the application using npm start
CMD ["npm", "start"]
