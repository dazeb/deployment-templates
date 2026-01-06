# Payload CMS Blank Template

This template deploys a blank Payload CMS instance with PostgreSQL database and S3 storage.

## Services

- **Payload CMS** (payloadcms/payload:latest) - Main application
- **PostgreSQL 15** (Alpine) - Database

## Features

- ✅ S3-compatible storage (MinIO, R2, Backblaze B2)
- ✅ Automatic health checks
- ✅ Persistent database storage
- ✅ Production-ready configuration
- ✅ Resource limits for shared infrastructure

## Environment Variables

### Required
- `DATABASE_URI` - PostgreSQL connection string
- `DB_PASSWORD` - Database password
- `PAYLOAD_SECRET` - Secret key for JWT tokens
- `PAYLOAD_PUBLIC_SERVER_URL` - Public URL of the instance
- `ADMIN_EMAIL` - Admin user email

### S3 Storage
- `S3_BUCKET` - Bucket name
- `S3_REGION` - Region or "auto"
- `S3_ACCESS_KEY_ID` - Access key
- `S3_SECRET_ACCESS_KEY` - Secret key
- `S3_ENDPOINT` - S3 endpoint URL
- `S3_PREFIX` - Tenant-specific prefix (e.g., `tenant-name/`)

## Deployment

This template is automatically deployed via PayloadServers platform using Coolify.

### Manual Deployment (Testing)

```bash
# Copy environment template
cp .env.example .env

# Edit .env with your values
nano .env

# Deploy
docker-compose up -d

# View logs
docker-compose logs -f

# Stop
docker-compose down
```

## URLs

After deployment, your Payload CMS admin panel will be available at:
- Admin: `https://your-app.app.payloadservers.com/admin`
- API: `https://your-app.app.payloadservers.com/api`

## Default Credentials

The first user must be created via the admin panel after deployment.

## Support

For issues or questions, contact support@payloadservers.com
