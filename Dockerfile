FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# the stuff will go into /app/build, which will contain the contents of the build foder here.
# Now we want to copy these over to the production image. Nothing else is copied because
# nothing else is needed for the production build

FROM nginx
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html