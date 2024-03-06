# Use node image as base
FROM node:18.17.0

# Set the working directory for frontend
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./


# Install dependencies
RUN npm install
COPY . ./
RUN npm run build

# Copy the built frontend files to the backend folder


# Expose port 3000 for serving the frontend
EXPOSE 3000

# Command to start the frontend server
CMD ["npm", "start"]
