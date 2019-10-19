# Multi-stage
# Allows us to build more complex containers that have
# multiple base images; here we build the simple app
# (prod build) and use a nginx server to serve the
# static content

# Build stage
# Build the production version of simple application
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Run stage
# Run nginx server to serve static content
FROM nginx as runner
COPY --from=builder /app/build /usr/share/nginx/html

# To run:
# docker build .
# docker run -p 8080:80 <container id>
# Note: nginx image default port is 80