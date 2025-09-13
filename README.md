# OpnForm Coolify Template

This is a Coolify service template for [OpnForm](https://opnform.com), a beautiful open source form builder with AI-powered features.

## Overview

OpnForm is a self-hosted alternative to Typeform and Google Forms that allows you to create stunning forms with advanced features like:

- 🎨 Beautiful, customizable form designs
- 🤖 AI-powered form generation
- 📊 Advanced analytics and insights
- 🔗 Powerful integrations (Slack, Discord, Webhooks, etc.)
- 📱 Mobile-responsive forms
- 🔒 Built-in spam protection
- 💾 Multiple storage options (local, S3)
- 📧 Email notifications

## Architecture

This template deploys OpnForm with the following services:

- **API Init**: Initializes shared Laravel application files
- **API**: Laravel-based backend API
- **Worker**: Queue worker for background tasks
- **Scheduler**: Laravel scheduler for cron jobs
- **UI**: Nuxt.js frontend application
- **Database**: PostgreSQL 16
- **Redis**: For caching and queues
- **Ingress**: Nginx reverse proxy

## Required Environment Variables

⚠️ **CRITICAL**: All of these variables MUST be set for the deployment to work properly.

### Core Settings
- `APP_URL`: Full URL where OpnForm will be accessible (e.g., https://forms.yourdomain.com)
- `FRONT_URL`: Frontend URL (usually same as APP_URL)
- `APP_KEY`: Laravel application key (base64 encoded) - **MUST BE SET**
- `JWT_SECRET`: JWT secret for authentication (64 character random string) - **MUST BE SET**
- `FRONT_API_SECRET`: Frontend API secret for secure communication (64 character random string) - **MUST BE SET**
- `DB_PASSWORD`: PostgreSQL database password - **MUST BE SET**
- `MAIL_FROM_ADDRESS`: Valid email address for outgoing emails - **MUST BE SET**

> **Note**: Missing any of these required variables will cause the deployment to timeout as containers will fail health checks.

### Generate Required Keys

To generate the required keys, you can use:

**APP_KEY**: Generate a Laravel-compatible base64 key using:
```bash
php -r "echo 'base64:'.base64_encode(random_bytes(32)).PHP_EOL;"
```
Or using OpenSSL:
```bash
echo "base64:$(openssl rand -base64 32)"
```

**JWT_SECRET**: Generate a 64-character random string using:
```bash
openssl rand -hex 32
```

**FRONT_API_SECRET**: Generate a 64-character random string using:
```bash
openssl rand -hex 32
```

## Optional Configuration

### Email Settings
- `MAIL_MAILER`: Mail driver (smtp, sendmail, etc.)
- `MAIL_HOST`: SMTP server hostname
- `MAIL_PORT`: SMTP server port (default: 587)
- `MAIL_USERNAME`: SMTP username
- `MAIL_PASSWORD`: SMTP password
- `MAIL_ENCRYPTION`: Encryption method (tls/ssl)

### File Storage
- `FILESYSTEM_DRIVER`: Storage driver (local or s3)
- `AWS_ACCESS_KEY_ID`: AWS access key (for S3)
- `AWS_SECRET_ACCESS_KEY`: AWS secret key (for S3)
- `AWS_BUCKET`: S3 bucket name (for S3)

### AI Features
- `OPEN_AI_API_KEY`: OpenAI API key for AI form generation

### Captcha Protection
- `H_CAPTCHA_SITE_KEY`: hCaptcha site key
- `H_CAPTCHA_SECRET_KEY`: hCaptcha secret key

### Analytics (Optional)
- `AMPLITUDE_CODE`: Amplitude tracking code
- `CRISP_WEBSITE_ID`: Crisp chat widget ID
- `GOOGLE_ANALYTICS_CODE`: Google Analytics tracking code

## Troubleshooting

### Deployment Timeout Issues
If your deployment times out after ~1 hour:

1. **Check required environment variables**: Ensure ALL required variables are set (see above)
2. **Verify database credentials**: `DB_PASSWORD` must match between database and API services
3. **Check Redis configuration**: If using `REDIS_PASSWORD`, ensure it's set correctly
4. **Review container logs**: Look for "Waiting for DB to be ready" or "No application encryption key" errors

### Common Error Messages
- **"No application encryption key"**: Set a valid `APP_KEY`
- **"Waiting for DB to be ready" (infinite loop)**: Check database credentials
- **503 Service Unavailable**: API container likely failed to start - check logs

## Post-Deployment Setup

1. **Access your OpnForm**: Navigate to your configured `APP_URL`
2. **Create admin account**: Register the first user account
3. **Configure email**: Set up SMTP settings for form notifications
4. **Setup storage**: Configure file storage (S3 recommended for production)
5. **Enable features**: Add API keys for AI features and captcha protection

## Default Access

- **Port**: 3000 (configurable via `PORT` variable)
- **Database**: PostgreSQL with persistent storage
- **Redis**: Used for caching and background job queues

## Health Checks

All services include health checks:
- API services check Laravel application status
- UI service checks frontend availability on 0.0.0.0:3000
- Database checks PostgreSQL connectivity
- Redis checks service availability

**Note**: The UI container is configured to bind to 0.0.0.0:3000 to ensure proper accessibility from the ingress proxy and health check functionality.

## Volumes

- `postgres-data`: PostgreSQL data persistence
- `opnform_storage`: Application file storage
- `opnform_app`: Shared Laravel application files
- `redis-data`: Redis data persistence

## Resources

- **Official Website**: [https://opnform.com](https://opnform.com)
- **Documentation**: [https://docs.opnform.com](https://docs.opnform.com)
- **GitHub**: [https://github.com/JhumanJ/opnform](https://github.com/JhumanJ/opnform)
- **Docker Documentation**: [https://docs.opnform.com/deployment/docker](https://docs.opnform.com/deployment/docker)

## Support

For issues with this Coolify template, please check:
1. OpnForm official documentation
2. GitHub repository issues
3. Coolify documentation for deployment issues

## License

OpnForm is open source software licensed under the AGPL-3.0 license.