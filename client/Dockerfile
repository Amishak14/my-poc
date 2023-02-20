FROM node:12.18.1
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN chmod -R 777 /app
EXPOSE 3000
CMD ["npm","start"]
       
