Docker file :
 
# Use Node.js Alpine image to keep it lightweight

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
 
# Install SonarQube Scanner

RUN curl -sSLo sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip && \

    unzip sonar-scanner.zip -d /opt/sonar-scanner && \

    rm sonar-scanner.zip
 
# Set PATH for sonar-scanner

ENV PATH="/opt/sonar-scanner/sonar-scanner-4.6.2.2472-linux/bin:$PATH"
 
# Default command to run SonarQube scanner

CMD sonar-scanner -Dsonar.projectKey=simple-node-app \

    -Dsonar.host.url=https://4a02-14-195-200-106.ngrok-free.app \

    -Dsonar.login=${SONAR_TOKEN}

 
