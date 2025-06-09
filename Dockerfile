# Step 1: Build the React app
FROM node:18 AS build

# Create app directory
WORKDIR /app

# Copy and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app and build it
COPY . .
RUN npm run build

# Step 2: Serve the build with Nginx
FROM nginx:alpine

# Copy build output to Nginx default public folder
COPY --from=build /app/build /usr/share/nginx/html

# Optional: Copy custom Nginx config (uncomment if you have one)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
