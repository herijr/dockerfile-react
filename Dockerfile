FROM node:16 as build
ENV NODE_OPTIONS "--max-old-space-size=8192"
WORKDIR /usr/src/app

COPY package*.json ./
COPY yarn.lock ./

RUN yarn install

# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source

COPY . .

RUN yarn build

FROM nginx:latest

# Copy the build output to replace the default nginx contents.
COPY --from=build /usr/src/app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80
