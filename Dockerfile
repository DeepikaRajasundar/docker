# Use Node.js Alpine base image
FROM node:alpine

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json first to leverage Docker cache
COPY package.json package-lock.json ./

# Clear npm cache
RUN npm cache clean --force

# Install dependencies
RUN npm install

# Copy the entire project to the working directory
COPY . .

# Expose the port your app runs on
EXPOSE 4000

# Start the application
CMD ["npm", "start"]
