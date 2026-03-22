FROM node:latest

WORKDIR /app

RUN apt-get update && apt-get install -y python3 make g++

COPY package.json pnpm-lock.yaml ./

RUN npm install -g pnpm

# allow scripts BEFORE install (important)
RUN pnpm config set ignore-scripts false

RUN pnpm install --frozen-lockfile

# ✅ force approve (non-interactive)
RUN pnpm approve-builds --all

COPY . .

RUN pnpm run build

EXPOSE 8080

CMD ["pnpm", "start"]
