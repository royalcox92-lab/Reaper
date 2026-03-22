FROM node:latest

WORKDIR /app

RUN apt-get update && apt-get install -y python3 make g++

COPY package.json pnpm-lock.yaml ./

RUN npm install -g pnpm
RUN pnpm install --frozen-lockfile

COPY . .

RUN pnpm run build

EXPOSE 8080

CMD ["pnpm", "start"]
