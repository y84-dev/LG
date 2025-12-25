FROM node:18-alpine

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

# Install ALL deps (including dev)

RUN npm install --include=dev --verbose
ENV NODE_OPTIONS=--max-old-space-size=4096

# Build step
RUN npm run build --verbose

# Now production mode
ENV NODE_ENV=production

# Entrypoint
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["./entrypoint.sh"]
