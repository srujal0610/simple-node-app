FROM node:16-alpine

# Set working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json for dependencies installation
COPY package*.json ./

# Install dependencies including the SonarQube Scanner
RUN npm install && npm install sonarqube-scanner@3.4.0 --save-dev

# Copy the rest of the project files
COPY . .

# Run the build process (replace with your own build script)
RUN npm run build

# Run tests and generate coverage report
RUN npm run test -- --coverage

# Default command to run SonarQube scanner using Node.js
CMD node -e "
  const scanner = require('sonarqube-scanner');
  scanner(
    {
      serverUrl: 'https://4a02-14-195-200-106.ngrok-free.app',
      token: process.env.SONAR_TOKEN,
      options: {
        'sonar.projectKey': 'simple-node-app',
        'sonar.sources': '.',
        'sonar.inclusions': '**',
      }
    },
    () => process.exit()
  );
"
