#
# Final Golden Dockerfile for Custom n8n Nodes on Railway
#

# Start from the official, pre-built n8n application.
FROM n8nio/n8n:latest

# Perform all administrative tasks as the 'root' user.
USER root

# Work directly inside the dedicated folder n8n uses for custom nodes.
# This also creates the directory if it doesn't exist.
WORKDIR /home/node/.n8n/nodes

# --- INSTALL ALL DESIRED NODES ---
# Install the packages LOCALLY (no -g) to avoid permission issues.
# We will install each package you want, one by one.

# Install the English version of the Evolution API node
RUN npm install n8n-nodes-evolution-api-en

# Install the Apify node
RUN npm install n8n-nodes-apify

# Install the Tavily node
RUN npm install @tavily/n8n-nodes-tavily

# After 'root' creates all files, hand ownership back to the 'node' user.
# This is crucial for the n8n application to be able to read the files.
RUN chown -R node:node /home/node/.n8n

# Final Step: Switch to the less-privileged 'node' user to run the application securely.
USER node
