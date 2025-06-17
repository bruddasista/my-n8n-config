# Start from the official, pre-built n8n application
FROM n8nio/n8n:latest

# Switch to the root user to get permission to do admin tasks
USER root

# --- FIX ---
# Create the directory that npm needs and set the correct permissions
# This prevents the ENOENT error during installation.
RUN mkdir -p /root/.npm && chown -R node:node /root/.npm

# Now, switch to the node user to run the install command
# Running as the user who will own the files is safer.
USER node

# Install the community node as the 'node' user
RUN npm install -g n8n-nodes-evolution-api

# No need to switch users again, as n8n should run as 'node'
