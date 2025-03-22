# Use Node.js Alpine base image
FROM node:alpine

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json before copying other files
COPY package.json package-lock.json /app/

# Set DNS to prevent npm EAI_AGAIN errors
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf && \
    echo "nameserver 1.1.1.1" >> /etc/resolv.conf

# Run npm install with retry logic
RUN npm cache clean --force && \
    for i in 1 2 3 4 5; do npm install && break || sleep 5; done

# Copy the full project files
COPY . /app/

# Expose port 4000
EXPOSE 4000

# Start the application
CMD ["npm", "start"]
