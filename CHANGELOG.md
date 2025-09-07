# Changelog

All notable changes to the OpnForm Coolify Template will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2024-09-05

### Added
- Initial release of OpnForm Coolify Template
- Full Docker Compose configuration with 7 services:
  - OpnForm API (Laravel backend)
  - OpnForm UI (Nuxt.js frontend) 
  - Queue Worker (background job processing)
  - Scheduler (scheduled tasks)
  - PostgreSQL database
  - Redis cache
  - Nginx reverse proxy
- Comprehensive metadata.json with environment variable definitions
- Production-ready nginx configuration with security headers
- Health checks for all critical services
- Volume persistence for database and file storage
- Coolify-specific labels and configurations
- Traefik integration for SSL and domain management
- Support for both local and S3 file storage
- Email configuration with multiple providers
- Optional integrations:
  - OpenAI for AI features
  - hCaptcha/reCaptcha for spam protection
  - Google OAuth authentication
  - Analytics (Google Analytics, Amplitude, Crisp)
- Comprehensive documentation and setup guide
- Environment variables template (.env.example)
- Validation script (validate.sh)
- MIT license for template files

### Features
- **One-click deployment** via Coolify
- **Auto-generated secrets** for security
- **Scalable architecture** with separate worker and scheduler
- **Production hardened** with proper health checks and dependencies
- **Flexible configuration** with extensive environment variable support
- **Documentation** with troubleshooting and maintenance guides

### Technical Details
- Uses official OpnForm Docker images (jhumanj/opnform-api:latest, jhumanj/opnform-client:latest)
- PostgreSQL 16 for database
- Redis 7 for cache and sessions
- Nginx 1.x for reverse proxy
- Coolify v4.0.0+ compatible
- Multi-architecture support (amd64, arm64)

### Security
- All services run with proper health checks
- Database and Redis are password protected
- Nginx configured with security headers
- File uploads are properly secured
- Environment variables are properly scoped
- No sensitive data in image layers
