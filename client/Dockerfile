FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# This is a second nginx - the other nginx server is used spefically for routing
# This one runs the react frontend
FROM nginx
# post exposed in nginx container which is picked up by Elastic Beanstalk
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html