# Use the official Bun image
FROM oven/bun:1 AS base
WORKDIR /usr/src/app

# Install dependencies
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile --production

# Copy the rest of the app
COPY . .

# Environment
ENV NODE_ENV=production

# Expose your app port
EXPOSE 3000

# Run the app directly with Bun (no build step needed)
CMD ["bun", "run", "index.ts"]
