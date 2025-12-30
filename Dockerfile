FROM node:20-alpine

WORKDIR /evolution

# Instalar dependencias
RUN apk add --no-cache git bash

# Clonar Evolution API v2 (última versión estable)
RUN git clone -b v2.1.0 https://github.com/EvolutionAPI/evolution-api.git .

# Instalar paquetes
RUN npm ci --omit=dev --ignore-scripts

EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080 || exit 1

CMD ["node", "./dist/src/main.js"]