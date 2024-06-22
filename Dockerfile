FROM node:16 AS BUILDER_LAYER

ENV APP_ROOT=/apps/blog
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
COPY public $APP_ROOT/public
COPY src $APP_ROOT/src
COPY .browserslistrc $APP_ROOT
COPY .editorconfig $APP_ROOT
COPY .eslintrc.js $APP_ROOT
COPY .npmrc $APP_ROOT
COPY .prettierrc $APP_ROOT
COPY babel.config.js $APP_ROOT
COPY package.json $APP_ROOT
COPY vue.config.js $APP_ROOT
RUN npm i
RUN npm run build

FROM nginx
COPY --from=BUILDER_LAYER /apps/blog/dist /usr/share/nginx/html