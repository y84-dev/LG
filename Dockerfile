FROM node:18-alpine
#RUN apt update && apt install -y \
#    build-essential \
#    libvips-dev \
#    && rm -rf /var/lib/apt/lists/*
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
RUN npm install --verbose
RUN npm run build --verbose
EXPOSE 80
##CMD ["npm", "run", "start"]
##CMD ["tail", "-f", "/dev/null"]
COPY entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
