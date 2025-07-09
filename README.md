# GraphHopper Routing Server

This repository contains a minimal setup for running GraphHopper 8.0 with several bicycle focused profiles.

## Build the Docker image

```bash
docker build -t graphhopper-server .
```

## Run the container

```bash
docker run -p 8989:8989 graphhopper-server
```

The server listens on `http://localhost:8989`.

## Routing examples

Choose a profile via the `profile` parameter (`bike`, `gravel` or `mountain`).
Elevation data is enabled, so include `elevation=true` when calling `/route`.

### Simple route

```bash
curl "http://localhost:8989/route?point=46.9,-114.0&point=46.95,-114.1&profile=bike&elevation=true"
```

### Round trip

```bash
curl "http://localhost:8989/route?point=46.9,-114.0&profile=gravel&elevation=true&round_trip.distance=10000&round_trip.seed=1"
```

This request calculates a roughly 10 km loop starting near the given point using the `gravel` profile.
