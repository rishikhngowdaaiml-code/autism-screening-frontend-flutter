# Use Flutter base image
FROM cirrusci/flutter:latest

# Set working directory
WORKDIR /app

# Copy all files
COPY . .

# Get dependencies
RUN flutter pub get

# Build the web app
RUN flutter build web

# Serve using Nginx
FROM nginx:alpine
COPY --from=0 /app/build/web /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]