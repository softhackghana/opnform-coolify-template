#!/bin/bash

# OpnForm Coolify Template Validation Script
# This script validates the docker-compose.yml file and checks for common issues

set -e

echo "🔍 Validating OpnForm Coolify Template..."
echo "========================================"

# Check if docker-compose.yml exists
if [ ! -f "docker-compose.yml" ]; then
    echo "❌ Error: docker-compose.yml not found!"
    exit 1
fi

echo "✅ docker-compose.yml found"

# Validate docker-compose syntax
echo "🔧 Validating Docker Compose syntax..."
if command -v docker-compose &> /dev/null; then
    if docker-compose config > /dev/null 2>&1; then
        echo "✅ Docker Compose syntax is valid"
    else
        echo "❌ Docker Compose syntax validation failed"
        docker-compose config
        exit 1
    fi
else
    echo "⚠️  Warning: docker-compose not found, skipping syntax validation"
fi

# Check required files
echo "📁 Checking required files..."

required_files=(
    "nginx.conf"
    "metadata.json"
    "README.md"
    ".env.example"
    "LICENSE"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file found"
    else
        echo "❌ Error: $file not found!"
        exit 1
    fi
done

# Check for required environment variables in docker-compose.yml
echo "🔐 Checking required environment variables..."

required_env_vars=(
    "APP_KEY"
    "JWT_SECRET"
    "DB_PASSWORD"
    "REDIS_PASSWORD"
    "SERVICE_FQDN_OPNFORM_INGRESS"
)

for env_var in "${required_env_vars[@]}"; do
    if grep -q "\${$env_var" docker-compose.yml; then
        echo "✅ $env_var referenced in docker-compose.yml"
    else
        echo "❌ Error: $env_var not found in docker-compose.yml!"
        exit 1
    fi
done

# Check service dependencies
echo "🔗 Checking service dependencies..."

# Check if all services that depend on others are properly configured
if grep -q "depends_on:" docker-compose.yml; then
    echo "✅ Service dependencies are configured"
else
    echo "⚠️  Warning: No service dependencies found"
fi

# Check health checks
echo "🏥 Checking health checks..."

services_with_healthcheck=$(grep -c "healthcheck:" docker-compose.yml || echo "0")
echo "✅ Found $services_with_healthcheck services with health checks"

# Check volume definitions
echo "💾 Checking volume definitions..."

if grep -q "volumes:" docker-compose.yml; then
    echo "✅ Volume definitions found"
    volumes=$(grep -A 10 "^volumes:" docker-compose.yml | grep -E "^  [a-z]" | wc -l)
    echo "✅ Found $volumes named volumes"
else
    echo "❌ Error: No volume definitions found!"
    exit 1
fi

# Check for Coolify-specific labels
echo "🏷️  Checking Coolify labels..."

if grep -q "coolify.managed=true" docker-compose.yml; then
    echo "✅ Coolify management label found"
else
    echo "❌ Error: Coolify management label not found!"
    exit 1
fi

if grep -q "traefik.enable=true" docker-compose.yml; then
    echo "✅ Traefik labels found"
else
    echo "⚠️  Warning: Traefik labels not found - may need manual proxy configuration"
fi

# Validate metadata.json
echo "📋 Validating metadata.json..."

if command -v jq &> /dev/null; then
    if jq empty metadata.json > /dev/null 2>&1; then
        echo "✅ metadata.json is valid JSON"
        
        # Check required metadata fields
        required_metadata=(
            ".name"
            ".description"
            ".services"
            ".environment_variables"
        )
        
        for field in "${required_metadata[@]}"; do
            if jq -e "$field" metadata.json > /dev/null 2>&1; then
                echo "✅ metadata.json has $field"
            else
                echo "❌ Error: metadata.json missing $field!"
                exit 1
            fi
        done
    else
        echo "❌ Error: metadata.json is not valid JSON!"
        exit 1
    fi
else
    echo "⚠️  Warning: jq not found, skipping metadata.json validation"
fi

# Check nginx.conf
echo "🌐 Checking nginx.conf..."

if [ -f "nginx.conf" ]; then
    if command -v nginx &> /dev/null; then
        if nginx -t -c "$(pwd)/nginx.conf" > /dev/null 2>&1; then
            echo "✅ nginx.conf syntax is valid"
        else
            echo "❌ Error: nginx.conf syntax validation failed"
            nginx -t -c "$(pwd)/nginx.conf"
            exit 1
        fi
    else
        echo "⚠️  Warning: nginx not found, skipping nginx.conf validation"
    fi
else
    echo "❌ Error: nginx.conf not found!"
    exit 1
fi

echo ""
echo "🎉 Template validation completed successfully!"
echo "✅ All checks passed - the template is ready for use with Coolify"
echo ""
echo "Next steps:"
echo "1. Push this template to a Git repository"
echo "2. Add the repository URL to your Coolify templates"
echo "3. Deploy OpnForm using the template"
