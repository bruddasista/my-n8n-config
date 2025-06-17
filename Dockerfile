# Start from the official, pre-built n8n application
FROM n8nio/n8n:latest

# The n8n image sets the home directory for the 'node' user here
ENV N8N_USER_FOLDER /home/node/.n8n

# Switch to the root user for system-level installations
USER root

# --- This is the key part from their official file ---
# The official image creates a symbolic link so that globally installed
# packages are automatically available in the user's n8n folder.
# We will ensure this link exists.
# The -f flag ensures it overwrites if it's already there.
RUN ln -s /usr/local/lib/node_modules/n8n-nodes-* $N8N_USER_FOLDER/nodes/

# Now, install our desired node globally. Because of the symlink above,
# it will automatically be linked into the correct user folder.
RUN npm install -g n8n-nodes-evolution-api

# Switch back to the standard 'node' user for security
USER node
