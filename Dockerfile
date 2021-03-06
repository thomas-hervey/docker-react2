# *******************
# Phase 1: Build code
# *******************

FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build


# ******************
# Phase 2: Run Nginx
# ******************
FROM nginx

# needed for AWS elasticbeanstalk for port mapping
EXPOSE 80

# copy built code into nginx folder
COPY --from=builder /app/build /usr/share/nginx/html

