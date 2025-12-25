FROM node:18

WORKDIR /app

RUN npm install -g npm@9

COPY package*.json ./
COPY packages ./packages
COPY themes ./themes
COPY extensions ./extensions
COPY public ./public
COPY media ./media
COPY config ./config
COPY translations ./translations

# Install deps (including dev)
RUN npm install --include=dev

# Prevent OOM
ENV NODE_OPTIONS=--max-old-space-size=4096
ENV GENERATE_SOURCEMAP=false

# Build EverShop
RUN npm run build

# Runtime mode
ENV NODE_ENV=production

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["./entrypoint.sh"]
