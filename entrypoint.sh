#!/bin/sh

# Wait for DB (optional)
echo "Waiting for DB..."
sleep 5

# Create admin user (only once or if needed)
if [ "$ADMIN_EMAIL" ]; then
  npm run user:create -- --email "$ADMIN_EMAIL" --password "$ADMIN_PASSWORD" --name "$ADMIN_NAME"
fi

# Start the app
npm run start
