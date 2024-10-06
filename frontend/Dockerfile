# Use the official Node.js image as the base image for building the app
FROM node:16 as build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json for dependency installation
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build the React app; this generates the static files in the build directory
RUN npm run build

# Use a lightweight Nginx web server to serve the static files
FROM nginx:alpine

# Copy the static files from the build directory to Nginx's serving directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to allow external access to the web server
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
