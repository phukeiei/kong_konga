# Dockerfile
FROM node:14.15.1

# create destination directory
RUN mkdir -p /usr/src/nuxt-app
WORKDIR /usr/src/nuxt-app


# copy the app, note .dockerignore
COPY . /usr/src/nuxt-app/
RUN npm install

EXPOSE 3000

ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000

CMD ["npm", "run", "dev"]