# Name the node stage "builder"
FROM node AS builder

# Set working directory
WORKDIR /app
# Copy all files from current directory to working dir in image
COPY . .
# install node modules and build assets
#RUN yarn install && yarn build

# nginx state for serving content
FROM nginx

# Set working directory to nginx asset directory
WORKDIR /usr/share/nginx/html

USER root

# Remove default nginx static assets
RUN rm -rf ./*

COPY --from=builder /app/build .
# Containers run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]