# Use official Node.js image as a base
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Build the Next.js application
RUN npm run build

# Use a minimal Node.js image for production
FROM node:18-alpine AS runner
WORKDIR /app

# Copy built application from builder stage
COPY --from=builder /app ./

# Expose port
EXPOSE 3000

# Start the application
CMD ["npm", "run", "start"]
