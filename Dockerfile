FROM node:20-alpine

WORKDIR /evolution

# Instalar dependencias del sistema
RUN apk add --no-cache git bash

# Clonar Evolution API (última versión estable)
RUN git clone -b 2.3.7 https://github.com/EvolutionAPI/evolution-api.git .

# Instalar dependencias de Node
RUN npm ci --omit=dev --ignore-scripts

EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080 || exit 1

CMD ["node", "./dist/src/main.js"]