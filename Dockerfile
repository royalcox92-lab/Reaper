FROM node:latest

WORKDIR /app

# Install dependencies first (better caching)
COPY package.json pnpm-lock.yaml ./

RUN npm install -g pnpm
RUN pnpm install

# Copy rest of app
COPY . .

# Build app
RUN pnpm run build

EXPOSE 8080

CMD ["pnpm", "start"]
