# Start from the official, pre-built n8n application
FROM n8nio/n8n:latest

# Set an environment variable for clarity and reuse
ENV N8N_USER_FOLDER /home/node/.n8n

# Switch to the root user for admin tasks
USER root

# Step 1: Create the target nodes directory and set permissions for the 'node' user.
# The -p flag ensures parent directories are created if they don't exist.
RUN mkdir -p ${N8N_USER_FOLDER}/nodes && chown -R node:node ${N8N_USER_FOLDER}

# Step 2: Install the package globally. This creates the source file for our link.
RUN npm install -g n8n-nodes-evolution-api

# Step 3: Now that both source and destination exist, create the symbolic link.
# We explicitly link the package we just installed.
RUN ln -s /usr/local/lib/node_modules/n8n-nodes-evolution-api ${N8N_USER_FOLDER}/nodes/

# Switch back to the standard 'node' user for security before running the app
USER node
