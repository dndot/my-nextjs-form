# Use an official Node.js image
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Install dependencies required for Next.js
RUN apk add --no-cache python3 make g++ 

# Copy package.json and package-lock.json first to leverage Docker layer caching
COPY package.json package-lock.json ./

# Clean npm cache and install dependencies
RUN npm cache clean --force && npm install --omit=dev

# Copy the rest of the application
COPY . .

# Build the Next.js app
RUN npm run build

# Expose port 3000
EXPOSE 3000

# Start the Next.js app
CMD ["npm", "start"]
