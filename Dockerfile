FROM ghcr.io/puppeteer/puppeteer:19.7.0

# Switch to root for setup
USER root

WORKDIR /usr/src/app

# Create app directory and set permissions
RUN mkdir -p /usr/src/app && \
    chown -R pptruser:pptruser /usr/src/app && \
    chmod 755 /usr/src/app

# Set up npm directory and permissions
RUN mkdir -p /home/pptruser/.npm && \
    chown -R pptruser:pptruser /home/pptruser/.npm && \
    chmod 755 /home/pptruser/.npm

# Expose the port the app runs on
EXPOSE 3000

# Copy package files
COPY --chown=pptruser:pptruser package*.json ./

# Switch to pptruser for npm operations
USER pptruser

# Install dependencies with legacy peer deps to avoid permission issues
RUN npm install --legacy-peer-deps

# Copy rest of the application
COPY --chown=pptruser:pptruser . .

# Start the bot
CMD [ "node", "bot.js" ]
