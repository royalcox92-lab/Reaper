FROM node:latest

WORKDIR /app

RUN apt-get update && apt-get install -y python3 make g++

COPY package.json pnpm-lock.yaml ./

RUN npm install -g pnpm

# Install deps
RUN pnpm install --frozen-lockfile

# ✅ THIS is the missing piece
RUN pnpm approve-builds

COPY . .

RUN pnpm run build

EXPOSE 8080

CMD ["pnpm", "start"]]
