FROM ghcr.io/puppeteer/puppeteer:19.7.0

# Switch to root to set up permissions
USER root

WORKDIR /usr/src/app

# Expose the port the app runs on
EXPOSE 3000

# Create and set ownership of npm cache directory
RUN mkdir -p /home/pptruser/.npm && \
    chown -R pptruser:pptruser /home/pptruser/.npm

# Switch to pptruser
USER pptruser

# Copy package files with correct ownership
COPY --chown=pptruser:pptruser package*.json ./

# Install dependencies
RUN npm install

# Copy rest of the application with correct ownership
COPY --chown=pptruser:pptruser . .

# Start the bot
CMD [ "node", "bot.js" ]
