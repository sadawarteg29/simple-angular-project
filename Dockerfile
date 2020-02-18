FROM node AS builder
ENV ngPATH /usr/src/app
WORKDIR ${ngPATH}
COPY ./package.json ${ngPATH}/
RUN npm install -g @angular/cli
RUN npm install
COPY ./ ${ngPATH}
RUN npm run build

FROM nginx
EXPOSE 80
ENV nPATH /usr/share/nginx/html
WORKDIR ${nPATH}
RUN rm -rf ${nPATH}/*
COPY --from=builder /usr/src/app/dist ${nPATH}
COPY ./nginx/nginx.conf /etc/nginx/conf.d/default.conf
