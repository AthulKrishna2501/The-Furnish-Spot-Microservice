#!/bin/sh

set -e  # Stop script on error

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"  # Get script directory

start_service() {
    echo "Starting service: $1"
    cd "$SCRIPT_DIR/$1/cmd" || { echo "Error: Cannot find $SCRIPT_DIR/$1/cmd"; exit 1; }
    make server &  # Run in the background
}

# Start all services
start_service go-grpc-api-gateway
start_service go-grpc-auth-svc
start_service go-grpc-order-svc
start_service go-grpc-product-svc

wait  # Wait for all background processes to finish

echo "All services started successfully!"
