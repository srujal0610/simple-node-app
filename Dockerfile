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

# Install required tools: curl, unzip, and openjdk (for SonarQube Scanner)
RUN apk add --no-cache curl unzip openjdk17

# Install SonarQube Scanner (without bundled JRE)
RUN curl -sSLo sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-7.0.1.4817-linux.zip && \
    unzip sonar-scanner.zip -d /opt/sonar-scanner && \
    rm sonar-scanner.zip

# Set PATH for sonar-scanner
ENV PATH="/opt/sonar-scanner/sonar-scanner-7.0.1.4817-linux/bin:$PATH"

# Ensure SonarQube Scanner uses the system Java
ENV SONAR_SCANNER_OPTS="-Djava.home=/usr/lib/jvm/java-17-openjdk"

# Default command to run SonarQube scanner
CMD sonar-scanner -Dsonar.projectKey=simple-node-app \
    -Dsonar.host.url=https://4a02-14-195-200-106.ngrok-free.app \
    -Dsonar.login=${SONAR_TOKEN}
