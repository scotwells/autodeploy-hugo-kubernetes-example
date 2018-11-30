# start with an image that has the hugo binary installed
FROM scotwells/hugo:0.52 as site
# set the working directory so we have a consistent place
# the site will be built
WORKDIR /app
# copy the binary from
COPY . /app
# running this command will build the site
RUN hugo-extended

FROM nginx:alpine

# copy our nginx configuration over
COPY ./docker/nginx.conf /etc/nginx/conf.d/default.conf
# copy the built site to the site directory
COPY --from=site /app/public /usr/share/nginx/html
