# Stage 1: Dependency Installation and Build
FROM oven/bun:latest AS builder

WORKDIR /app

# Copy package.json and bun.lock first
COPY package.json bun.lock ./

# Install dependencies
RUN bun install --frozen-lockfile

# Copy source code
COPY . .

# Stage 2: Final Image
FROM oven/bun:latest

WORKDIR /app

# Copy from builder stage
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/bun.lock ./bun.lock
# Fix: Don't copy the entire /app again, be more specific
COPY --from=builder /app/*.js ./
COPY --from=builder /app/*.ts ./
COPY --from=builder /app/src ./src
# Add other specific files/folders your app needs

EXPOSE 3001

CMD ["bun", "run", "start"]