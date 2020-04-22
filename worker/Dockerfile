FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
# start instead of dev in the development version
CMD ["npm", "run", "start"]