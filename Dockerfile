# -------- Stage 1: Build Flutter Web App --------
FROM cirrusci/flutter:3.13.0 AS builder

# Set environment variables for reliable package fetching
ENV PUB_HOSTED_URL=https://pub.dev
ENV FLUTTER_STORAGE_BASE_URL=https://storage.googleapis.com

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Get dependencies
RUN flutter pub get

# Build the web app in release mode
RUN flutter build web --release --no-tree-shake-icons

# -------- Stage 2: Serve with Nginx --------
FROM nginx:alpine

# Remove default Nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy built Flutter web app from builder stage
COPY --from=builder /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]