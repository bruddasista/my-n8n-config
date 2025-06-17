#
# Golden Dockerfile for Custom n8n Nodes on Railway
#

# Principle: Start from the official, pre-built n8n application.
FROM n8nio/n8n:latest

# Principle: Perform all administrative tasks as the 'root' user.
USER root

# Principle: Work directly inside the dedicated folder n8n uses for custom nodes.
# The WORKDIR command also creates this directory if it doesn't exist.
WORKDIR /home/node/.n8n/nodes

# Principle: Install the node LOCALLY, not globally.
# This avoids all system-wide permission issues. 'npm' will create a 'node_modules'
# folder inside our current working directory.
RUN npm install n8n-nodes-evolution-api

# Principle: After 'root' has created the files, hand ownership back to the 'node' user.
# The n8n application runs as 'node' and needs permission to read these files.
# We change ownership of the entire '/home/node/.n8n' directory.
RUN chown -R node:node /home/node/.n8n

# Final Step: Switch to the less-privileged 'node' user to run the application securely.
USER node
