#!/bin/sh

# Parse secrets into temp env vars 
export EWEKA_URI=$(cat /run/secrets/eweka_uri)
export EWEKA_USER=$(cat /run/secrets/eweka_user)
export EWEKA_PASS=$(cat /run/secrets/eweka_user_password)

# Escape special characters in password 
ESCAPED_PASS=$(printf '%s\n' "$EWEKA_PASS" | sed -e 's/[\/&]/\\&/g')

# Generate SABnzbd config from template
sed -e "s|__EWEKA_URI__|$EWEKA_URI|g" \
    -e "s|__EWEKA_USERNAME__|$EWEKA_USER|g" \
    -e "s|__EWEKA_PASSWORD__|$ESCAPED_PASS|g" \
    ./templates/sabnzbd.ini > ./config/sabnzbd.ini

# Remove env vars
unset EWEKA_URI
unset EWEKA_USER
unset EWEKA_PASS

# Start the original entrypoint script
exec /init

