# OpnForm Coolify Template

A Beautiful Open-Source Form Builder - A self-hosted alternative to Typeform, Google Forms, and other form builders.

## Overview

OpnForm is a powerful, self-hosted form builder that allows you to create beautiful forms, surveys, and collect responses with ease. This Coolify template makes it easy to deploy OpnForm on your own infrastructure with just a few clicks.

## Features

- ✨ **Beautiful Form Builder**: Drag-and-drop interface for creating stunning forms
- 📊 **Advanced Analytics**: Track form performance and response analytics  
- 🔒 **Self-Hosted**: Complete control over your data and privacy
- 📧 **Email Notifications**: Automated email responses and notifications
- 🎨 **Customizable Themes**: Brand your forms with custom styling
- 📱 **Mobile Responsive**: Forms work perfectly on all devices
- 🔗 **Integrations**: Connect with popular services via webhooks
- 🤖 **AI Features**: Generate forms with OpenAI integration (optional)
- 🛡️ **Spam Protection**: Built-in reCAPTCHA and hCAPTCHA support

## Architecture

This template deploys the following services:

- **OpnForm API**: Backend Laravel application handling form logic
- **OpnForm UI**: Frontend Nuxt.js application for the user interface  
- **Queue Worker**: Background job processing for emails and tasks
- **Scheduler**: Handles scheduled tasks and maintenance
- **PostgreSQL**: Primary database for storing forms and responses
- **Redis**: Cache and session storage for performance
- **Nginx**: Reverse proxy and static file serving

## Quick Deploy

1. **Add Template to Coolify**:
   - Go to your Coolify dashboard
   - Navigate to Templates → Add Template
   - Use this repository URL: `https://github.com/softhackghana/opnform-coolify-template`

2. **Deploy Application**:
   - Click "Deploy" on the OpnForm template
   - Configure the required environment variables (see below)
   - Wait for deployment to complete

3. **Initial Setup**:
   - Access your OpnForm instance via the provided URL
   - Complete the initial setup wizard
   - Create your admin account

## Required Environment Variables

The following environment variables are **required** and will be auto-generated if not provided:

### Core Configuration
- `APP_KEY`: Laravel application encryption key (auto-generated)
- `JWT_SECRET`: JWT token signing secret (auto-generated) 
- `DB_PASSWORD`: PostgreSQL database password (auto-generated)
- `REDIS_PASSWORD`: Redis authentication password (auto-generated)

## Optional Environment Variables

### Database Settings
- `DB_DATABASE`: Database name (default: `opnform`)
- `DB_USERNAME`: Database username (default: `opnform`)
- `DB_CONNECTION`: Database type (default: `pgsql`)

### Email Configuration
- `MAIL_MAILER`: Email service (`smtp`, `mailgun`, `ses`, `postmark`, `log`)
- `MAIL_HOST`: SMTP server hostname
- `MAIL_PORT`: SMTP server port (default: `587`)
- `MAIL_USERNAME`: SMTP username
- `MAIL_PASSWORD`: SMTP password
- `MAIL_ENCRYPTION`: Encryption method (`tls`, `ssl`, `none`)
- `MAIL_FROM_ADDRESS`: Default sender email
- `MAIL_FROM_NAME`: Default sender name

### File Storage
- `FILESYSTEM_DRIVER`: Storage driver (`local` or `s3`)
- `AWS_ACCESS_KEY_ID`: AWS access key (for S3 storage)
- `AWS_SECRET_ACCESS_KEY`: AWS secret key (for S3 storage)
- `AWS_DEFAULT_REGION`: AWS region (default: `us-east-1`)
- `AWS_BUCKET`: S3 bucket name

### Integrations
- `OPEN_AI_API_KEY`: OpenAI API key for AI features
- `H_CAPTCHA_SITE_KEY`: hCaptcha site key
- `H_CAPTCHA_SECRET_KEY`: hCaptcha secret key
- `RE_CAPTCHA_SITE_KEY`: reCaptcha site key  
- `RE_CAPTCHA_SECRET_KEY`: reCaptcha secret key
- `GOOGLE_CLIENT_ID`: Google OAuth client ID
- `GOOGLE_CLIENT_SECRET`: Google OAuth client secret

### Analytics (Optional)
- `NUXT_PUBLIC_AMPLITUDE_CODE`: Amplitude analytics code
- `NUXT_PUBLIC_CRISP_WEBSITE_ID`: Crisp chat widget ID
- `NUXT_PUBLIC_GOOGLE_ANALYTICS_CODE`: Google Analytics tracking code

## Post-Installation Setup

### 1. Access OpnForm
Navigate to your domain and complete the setup wizard:
- Create admin account
- Configure basic settings
- Set up email notifications

### 2. Configure Email (Recommended)
For form notifications and responses:
1. Set up an SMTP provider (Gmail, SendGrid, etc.)
2. Configure the `MAIL_*` environment variables
3. Test email delivery in OpnForm settings

### 3. Set Up File Storage (Optional)
For file uploads in forms:
- **Local Storage**: No additional setup needed
- **S3 Storage**: Configure AWS credentials and bucket

### 4. Enable AI Features (Optional)
To use AI form generation:
1. Get an OpenAI API key
2. Set the `OPEN_AI_API_KEY` environment variable
3. Restart the application

## Backup and Maintenance

### Database Backup
The PostgreSQL database is stored in the `postgres-data` volume. Coolify automatically handles volume backups if configured.

### File Uploads Backup  
User-uploaded files are stored in the `opnform_storage` volume. This should also be included in your backup strategy.

### Updates
To update OpnForm:
1. Check for new releases on the [OpnForm GitHub](https://github.com/JhumanJ/OpnForm)
2. Update the image tags in your Coolify deployment
3. Restart the services

## Troubleshooting

### Application Not Loading
1. Check service logs in Coolify dashboard
2. Verify all required environment variables are set
3. Ensure database connection is successful

### Email Not Working
1. Verify SMTP credentials are correct
2. Check firewall rules for SMTP ports
3. Test with `MAIL_MAILER=log` to debug

### File Uploads Failing
1. Check storage configuration
2. Verify volume mounts are working
3. Check nginx file size limits

### Performance Issues
1. Monitor Redis cache performance
2. Check database query performance
3. Consider scaling worker processes

## Support

- **Official Documentation**: [OpnForm Docs](https://github.com/JhumanJ/OpnForm)
- **GitHub Issues**: [OpnForm Issues](https://github.com/JhumanJ/OpnForm/issues)  
- **Coolify Support**: [Coolify Discord](https://discord.gg/coolify)

## License

OpnForm is open-source software licensed under the [AGPL-3.0 license](https://github.com/JhumanJ/OpnForm/blob/main/LICENSE).

This Coolify template is provided under the MIT license.
