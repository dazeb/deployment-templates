FROM node:20-alpine AS base

# Install dependencies only when needed
FROM base AS deps
RUN apk add --no-cache libc6-compat
WORKDIR /app

# Install pnpm
RUN corepack enable && corepack prepare pnpm@9.13.2 --activate

# Copy package files
COPY package.json pnpm-lock.yaml* ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Rebuild the source code only when needed
FROM base AS builder
WORKDIR /app

RUN corepack enable && corepack prepare pnpm@9.13.2 --activate

COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Build the application
RUN pnpm run build

# Production image, copy all the files and run next
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 payload

# Create media directory with correct permissions
RUN mkdir -p /app/media && chown payload:nodejs /app/media

# Copy built application
COPY --from=builder --chown=payload:nodejs /app/.next/standalone ./
COPY --from=builder --chown=payload:nodejs /app/.next/static ./.next/static
COPY --from=builder --chown=payload:nodejs /app/public ./public
COPY --from=builder --chown=payload:nodejs /app/package.json ./package.json

USER payload

EXPOSE 3000

ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

CMD ["node", "server.js"]
