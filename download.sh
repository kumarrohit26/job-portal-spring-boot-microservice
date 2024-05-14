#!/bin/bash

# Define repository URLs
SERVICE_REGISTRY_URL="https://github.com/kumarrohit26/service-registry.git"
CONFIG_SERVER_URL="https://github.com/kumarrohit26/config-server.git"
API_GATEWAY_URL="https://github.com/kumarrohit26/api-gateway.git"
JOBS_SERVICE_URL="https://github.com/kumarrohit26/job-microservice.git"
COMPANIES_SERVICE_URL="https://github.com/kumarrohit26/company-microservice.git"
REVIEWS_SERVICE_URL="https://github.com/kumarrohit26/review-microservice.git"
CONFIGURATION_REPO_URL="https://github.com/kumarrohit26/application-config.git"

# Clone repositories
echo "Cloning Service Registry..."
git clone $SERVICE_REGISTRY_URL

echo "Cloning Config Server..."
git clone $CONFIG_SERVER_URL

echo "Cloning API Gateway..."
git clone $API_GATEWAY_URL

echo "Cloning Jobs Service..."
git clone $JOBS_SERVICE_URL

echo "Cloning Companies Service..."
git clone $COMPANIES_SERVICE_URL

echo "Cloning Reviews Service..."
git clone $REVIEWS_SERVICE_URL

echo "Cloning Configuration Repository..."
git clone $CONFIGURATION_REPO_URL

echo "All repositories have been cloned successfully."

# End of script
