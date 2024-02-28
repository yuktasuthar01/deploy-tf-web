FROM node:18.17.0

# Using a common convention for the working directory
WORKDIR /app

# Copy package.json file
COPY . .
RUN pwd && ls
# Install dependencies
RUN npm install

# Copy all project files and directories
#COPY . .

# Expose port 3000
EXPOSE 3000

# Start the application using npm start
CMD ["npm", "start"]
