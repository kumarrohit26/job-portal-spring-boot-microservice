# Job Portal using Spring Boot

## Overview

This project is a basic implementation of a job portal using a microservices architecture. The system consists of several microservices, each handling different aspects of the job portal, including job postings, companies, and company reviews. This README provides an overview of the entire system and links to the individual microservices repositories for more detailed information.

## Microservices

The job portal is composed of the following microservices and repositories:

| Service            | Description                                                                                       | Repository URL |
|--------------------|---------------------------------------------------------------------------------------------------|----------------|
| Jobs Service       | Manages job postings, including creating, updating, deleting, and retrieving job listings.        | [Jobs Service Repo](https://github.com/kumarrohit26/job-microservice.git)  |
| Companies Service  | Manages company information, including creating, updating, deleting, and retrieving company data. | [Companies Service Repo](https://github.com/kumarrohit26/company-microservice.git)  |
| Reviews Service    | Manages reviews for companies, including creating, updating, deleting, and retrieving reviews.    | [Reviews Service Repo](https://github.com/kumarrohit26/review-microservice.git)  |
| Service Registry   | Implements service discovery using Spring Cloud Eureka for dynamic service registration.          | [Service Registry Repo](https://github.com/kumarrohit26/service-registry.git)  |
| API Gateway        | Uses Spring Cloud Gateway to route requests to the appropriate microservice.                      | [API Gateway Repo](https://github.com/kumarrohit26/api-gateway.git)  |
| Config Server      | Centralized configuration management for all microservices using Spring Cloud Config.             | [Config Server Repo](https://github.com/kumarrohit26/config-server.git)  |
| Application Configuration Repo | Stores configuration properties for different environments.                                       | [Configuration Repo](https://github.com/kumarrohit26/application-config.git)  |

## Architecture

<img src="images/job-architechture.png" alt="Description" width="600"/>

The system follows a microservices architecture, where each microservice is responsible for a specific domain of the job portal. Here is a brief description of each service:

### Jobs Service
The Jobs Service handles all operations related to job postings. It provides RESTful APIs to create, update, delete, and retrieve job listings.

### Companies Service
The Companies Service manages company-related information. It provides APIs to manage company profiles and details.

### Reviews Service
The Reviews Service is responsible for managing company reviews. It includes functionalities to add, update, delete, and fetch reviews for companies.

### Service Registry
The Service Registry uses Spring Cloud Eureka for service discovery. It allows microservices to register themselves at runtime and to discover other registered services.

### API Gateway
The API Gateway uses Spring Cloud Gateway to route requests to the appropriate microservice. It acts as a single entry point for all client requests.

### Config Server
The Config Server provides centralized configuration management for all microservices. It retrieves configuration properties from the [Configuration Repository](https://github.com/kumarrohit26/application-config.git).

### Configuration Repository
This repository contains the configuration properties for different environments. The Config Server fetches these properties to configure the microservices accordingly.

## Tools and Technologies

This project utilizes several tools and technologies to enhance the functionality and reliability of the system:

- **PostgreSQL:** Used as the database for all microservices.
- **Docker:** Used to run PostgreSQL, pgAdmin, and Zipkin in containers.
- **Distributed Tracing:** Using Zipkin and Micrometer for tracing and monitoring requests across microservices.
- **OpenFeign:** For declarative REST client to simplify HTTP communication between microservices.
- **Fault Tolerance and Circuit Breaker:** Implemented using Resilience4j to handle failures gracefully and ensure system resilience.
- **Kubernetes:** Used for container orchestration and deployment.

## Running the Application

There are three ways to run the Job Portal application:

### I. Start Services on Docker and Microservices from IntelliJ (Development Purpose)

For development purposes, you can start the PostgreSQL, RabbitMQ, and Zipkin server on Docker containers, and run other microservices from IntelliJ:

To get the codebase:

1. Download all the microservices using the `download.sh` file.
2. Open each project in IntelliJ as a Maven project.
3. Ensure Docker is installed and running on your machine.
4. Navigate to the directory containing the `docker-compose.yaml` file.
5. Bring up the Docker instances for PostgreSQL, pgAdmin, and Zipkin.

```sh
docker compose up -d postgres rabbitmq zipkin
```

The following Docker containers are used in this project:

| Service   | Container Name     | Image                | Host Port | Container Port |
|-----------|---------------------|----------------------|-----------|----------------|
| Postgres  | postgres  | postgres             | 5000      | 5432           |
| pgAdmin   | pgadmin   | dpage/pgadmin4       | 5050      | 80             |
| Zipkin    | zipkin    | openzipkin/zipkin    | 9411      | 9411           |

Run the applications in the following order in IntelliJ:

|Order |Service Name	|Port	|Gateway URL|
|---|---------------|-------|-----------|
|1.|Service Registry|	8761|	http://localhost:8085/eureka/main|
|2.|Config Server	|8080	|N/A|
|3.|API Gateway	|8085	|N/A|
|4.|Job Microservice	|8082	|http://localhost:8085/jobs|
|5.|Company Microservice	|8083	|http://localhost:8085/companies|
|6.|Review Microservice	|8084	|http://localhost:8085/reviews|

- **Service Registry:** Accessible on localhost:8761 or via the API Gateway.
- **Config Server:** Accessible on localhost:8080.
- **API Gateway:** Accessible on localhost:8085.
- **Job Microservice:** Accessible on localhost:8082 or via the API Gateway at /jobs.
- **Company Microservice:** Accessible on localhost:8083 or via the API Gateway at /companies.
- **Review Microservice:** Accessible on localhost:8084 or via the API Gateway at /reviews.

### II. Using Docker for All Services

You can run all the services using Docker. This involves using Spring Boot's automatic Docker image creation and pushing the images to your server.

1. Ensure Docker is installed and running on your machine.

2. Create Docker image for each microservice
```
./mvnw spring-boot:build-image "-Dspring-boot.build-image.imageName=<username>/<service-name>"
```

3. Push the image to docker hub
```
docker push <username>/<service-name>
```
Run the above command for all the services. Please use below service names or if you are using different names please update it in `docker-compose.yaml` file.

- servicereg
- config-server-ms
- gateway-ms
- jobms
- companyms
- reviewms

4. Navigate to the directory containing the docker-compose.yaml file.
5. Start all the services:
```
docker compose up -d
```
### III. Using Kubernetes

You can also deploy the application using Kubernetes. For this, you need to install Minikube and use the Kubernetes configuration files to start all services.

1. Install minikube from [here](https://minikube.sigs.k8s.io/docs/start/)
2. Start Minikube
```
minikube start --driver=docker
```
3. Open minikube dashboard to see the details
```
minikube dashboard
```
4. Apply the kubernetes configuration files to start each services.
```
kubectl apply -f service/postgres
kubectl apply -f service/rabbitmq
kubectl apply -f service/zipkin

kubectl apply -f bootstrap/job
kubectl apply -f bootstrap/company
kubectl apply -f bootstrap/review
```
5. Run the command to get url for each service to start using
```
minikube service <service-name> --url

For example

minikube service job --url
```

