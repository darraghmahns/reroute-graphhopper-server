FROM openjdk:11-jre-slim

# Install curl and other dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Download GraphHopper
RUN wget https://github.com/graphhopper/graphhopper/releases/download/8.0/graphhopper-web-8.0.jar
RUN wget https://download.geofabrik.de/north-america/us/montana-latest.osm.pbf

# Create config directory
RUN mkdir -p /app/config

# Create elevation cache directory
RUN mkdir -p /app/elevation-cache

# Copy configuration files
COPY config.yml /app/config/
COPY bike.json /app/
COPY gravel.json /app/
COPY mountain.json /app/

# Expose port
EXPOSE 8989

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:8989/health || exit 1

# Start GraphHopper
CMD ["java", "-Xmx1536m", "-jar", "graphhopper-web-8.0.jar", "server", "config/config.yml"]
