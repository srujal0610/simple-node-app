FROM node:16-alpine
 
# Set working directory in the container

WORKDIR /app
 
# Copy package.json and package-lock.json for dependencies installation

COPY package*.json ./
 
# Install dependencies

RUN npm install
 
# Copy the rest of the project files

COPY . .
 
# Run the build process (replace with your own build script)

RUN npm run build
 
# Run tests and generate coverage report

RUN npm run test -- --coverage


RUN apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/* 
# Install SonarQube Scanner

RUN curl -sSLo sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-7.0.1.4817-linux-x64.zip?_gl=1*1hr5745*_gcl_au*MTIzNzY5OTg0Ni4xNzM5OTY5MDQz*_ga*MTA5MjU1MjEzLjE3Mzk5Njg3NzE.*_ga_9JZ0GZ5TC6*MTc0MDA1NDk5NS4zLjEuMTc0MDA1NTI5OS42MC4wLjA && \

    unzip sonar-scanner.zip -d /opt/sonar-scanner && \

    rm sonar-scanner.zip
 
# Set PATH for sonar-scanner

ENV PATH="/opt/sonar-scanner/sonar-scanner-4.6.2.2472-linux/bin:$PATH"
 
# Default command to run SonarQube scanner

CMD sonar-scanner -Dsonar.projectKey=simple-node-app \

    -Dsonar.host.url=https://4a02-14-195-200-106.ngrok-free.app \

    -Dsonar.login=${SONAR_TOKEN}

 
