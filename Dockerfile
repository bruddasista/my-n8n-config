# Start from the official, pre-built n8n application
FROM n8nio/n8n:latest

# Switch to the root user to have permissions for system-wide changes
USER root

# Install the community node globally. This is done as root.
RUN npm install -g n8n-nodes-evolution-api

# --- IMPORTANT ---
# The n8n base image has a special directory for user-installed nodes.
# We need to ensure the 'node' user owns everything inside it.
# The `|| true` prevents an error if the directory doesn't exist yet.
RUN chown -R node:node /home/node/.n8n/nodes || true

# Switch back to the standard 'node' user for security before running the app
USER node
