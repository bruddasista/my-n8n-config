# Start from the official, pre-built n8n application
FROM n8nio/n8n:latest

# Switch to the root user to get permission to install things
USER root

# This is the line that installs the Evolution API node
RUN npm install -g n8n-nodes-evolution-api

# Switch back to the standard 'node' user for security
USER node
