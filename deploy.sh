#!/bin/bash

# Enable strict mode for better error handling
set -e

# Define variables
TOMCAT_HOME="/opt/homebrew/Cellar/tomcat@9/9.0.98/libexec"
TOMCAT_WEBAPPS="$TOMCAT_HOME/webapps"
PROJECT_DIR="/Users/sumuditha/Desktop/APIIT/SYOS-MultiTier"
CLIENT_WAR="$PROJECT_DIR/SYOS-Client/target/SYOS-Client.war"
SERVER_WAR="$PROJECT_DIR/SYOS-Server/target/SYOS-Server.war"

echo "🚀 Starting deployment process..."

# Step 1: Navigate to project directory & Build WAR files
echo "🔨 Building project with Maven..."
cd "$PROJECT_DIR"
mvn clean package -DskipTests || { echo "❌ Build failed! Fix errors before deploying."; exit 1; }

# Step 2: Check if Tomcat is running and stop it
echo "🛑 Stopping Tomcat server..."
if pgrep -f 'org.apache.catalina.startup.Bootstrap' > /dev/null; then
    $TOMCAT_HOME/bin/shutdown.sh
    sleep 5
    if pgrep -f 'org.apache.catalina.startup.Bootstrap' > /dev/null; then
        echo "❌ Tomcat is still running. Force stopping..."
        pkill -f 'org.apache.catalina.startup.Bootstrap'
        sleep 5
    fi
else
    echo "✅ Tomcat is not running, skipping shutdown."
fi

# Step 3: Verify WAR files exist before deployment
if [[ ! -f "$CLIENT_WAR" || ! -f "$SERVER_WAR" ]]; then
    echo "❌ WAR files not found! Ensure the build was successful."
    exit 1
fi

# Step 4: Remove old deployments and copy new WAR files
echo "📂 Cleaning old deployments..."
rm -rf "$TOMCAT_WEBAPPS/SYOS-Client"
rm -rf "$TOMCAT_WEBAPPS/SYOS-Server"
rm -f "$TOMCAT_WEBAPPS/SYOS-Client.war"
rm -f "$TOMCAT_WEBAPPS/SYOS-Server.war"

echo "📦 Deploying new WAR files..."
cp "$CLIENT_WAR" "$TOMCAT_WEBAPPS/"
cp "$SERVER_WAR" "$TOMCAT_WEBAPPS/"

# Step 5: Restart Tomcat
echo "🚀 Restarting Tomcat..."
$TOMCAT_HOME/bin/startup.sh
sleep 5

# Step 6: Check if Tomcat is running
if ! pgrep -f 'org.apache.catalina.startup.Bootstrap' > /dev/null; then
    echo "❌ Tomcat failed to start! Check logs for errors."
    exit 1
fi

echo "✅ Deployment completed successfully!"
echo "🌍 Visit:"
echo "➡ Server: http://localhost:8080/SYOS-Server/api/hello"
echo "➡ Client: http://localhost:8080/SYOS-Client/index.jsp"

# Step 7: Check what is running on port 8080
echo "🔎 Checking running services on port 8080..."
if command -v lsof &> /dev/null; then
    lsof -i :8080
elif command -v netstat &> /dev/null; then
    netstat -an | grep 8080
else
    echo "⚠️ Could not find lsof or netstat commands to check port usage."
fi
