FROM oven/bun:latest

WORKDIR /app

# Copy package files
COPY package.json bun.lock ./

# Install dependencies
RUN bun install --frozen-lockfile

# Copy all source code
COPY . .

# Expose port
EXPOSE 3001

# Start the application
CMD ["bun", "run", "start"]