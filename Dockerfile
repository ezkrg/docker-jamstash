FROM node:lts-alpine AS builder

ARG VERSION

RUN apk add --update --no-cache build-base git \
 && cd /tmp \
 && git clone -n https://github.com/tsquillario/Jamstash.git \
 && cd Jamstash \
 && git checkout ${VERSION} \
 && npm install \
 && npx bower --allow-root install \
 && npx grunt build

 # ---

FROM nginx:stable-alpine AS jamstash

COPY --from=builder /tmp/Jamstash/dist/ /usr/share/nginx/html/ 