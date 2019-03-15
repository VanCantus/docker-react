# builder step
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Now, /app/build contains all needed files!

# run step
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# No default command is needed as the nginx image already runs the correct one