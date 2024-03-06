FROM node:18.17.0 
# Create and set the working directory for backend
WORKDIR /app

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install backend dependencies
RUN npm install
COPY . .

# Expose port 3001
EXPOSE 3001

# Start the backend application
CMD ["node", "index.js"]
