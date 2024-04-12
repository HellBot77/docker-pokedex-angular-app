FROM alpine/git AS base

ARG TAG=latest
RUN git clone https://github.com/HybridShivam/pokedex-angular-app.git && \
    cd pokedex-angular-app && \
    ([[ "$TAG" = "latest" ]] || git checkout ${TAG}) && \
    rm -rf .git

FROM node:16-alpine AS build

WORKDIR /pokedex-angular-app
COPY --from=base /git/pokedex-angular-app .
RUN npm install --legacy-peer-deps && \
    npm run build

FROM lipanski/docker-static-website

COPY --from=build /pokedex-angular-app/dist/pokedex .
