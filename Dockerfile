# Stage 1: Dependency Installation and Build (if applicable)
FROM oven/bun:latest AS builder

WORKDIR /app

# Copy package.json and bun.lock first to leverage Docker cache
COPY package.json bun.lock ./

# Install dependencies with --frozen-lockfile for reproducible builds
RUN bun install --frozen-lockfile

# Copy your application source code
COPY . .

# If your application requires a build step (e.g., for production builds)
# RUN bun run build

# Stage 2: Final Image (smaller, production-ready)
FROM oven/bun:latest

WORKDIR /app

# Copy only necessary files from the builder stage
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/bun.lock ./bun.lock
COPY --from=builder /app .

# Expose the port your Bun server listens on
EXPOSE 3000

# Command to start your Bun server
ENTRYPOINT ["bun", "run", "start"]
