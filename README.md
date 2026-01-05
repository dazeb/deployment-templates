# PayloadServers Deployment Templates

This repository contains Docker Compose templates for deploying Payload CMS instances via Coolify.

## Available Templates

### 1. Blank Template (`blank/`)
A minimal Payload CMS setup with PostgreSQL and S3 storage.
- **Use case**: Custom projects, API-only deployments
- **Includes**: Payload CMS, PostgreSQL 15, S3 storage
- **Resource profile**: Shared infrastructure (0.5 CPU, 512MB RAM)

### 2. Blog Template (`blog/`) - Coming Soon
Pre-configured blog with posts, categories, and authors.
- **Use case**: Content blogs, news sites
- **Includes**: Blog collections, SEO fields, image optimization

### 3. E-commerce Template (`ecommerce/`) - Coming Soon
Full e-commerce solution with products, orders, and payments.
- **Use case**: Online stores
- **Includes**: Products, cart, Stripe integration

## Template Structure

Each template folder contains:

```
template-name/
├── docker-compose.yml    # Main deployment configuration
├── .env.example          # Environment variable template
└── README.md             # Template-specific documentation
```

## Environment Variables

All templates use these standard environment variables:

### Core Configuration
- `DATABASE_URI` - PostgreSQL connection string
- `DB_PASSWORD` - Database password
- `PAYLOAD_SECRET` - JWT secret key
- `PAYLOAD_PUBLIC_SERVER_URL` - Public URL (set by platform)
- `ADMIN_EMAIL` - Admin user email

### S3 Storage
- `S3_BUCKET` - Shared bucket name
- `S3_REGION` - Region or "auto"
- `S3_ACCESS_KEY_ID` - Access key
- `S3_SECRET_ACCESS_KEY` - Secret key
- `S3_ENDPOINT` - S3 endpoint URL
- `S3_PREFIX` - Tenant isolation prefix (auto-generated)

## How It Works

1. **Customer selects template** via PayloadServers dashboard
2. **Backend generates environment** variables (passwords, secrets, S3 prefix)
3. **Coolify clones** this repository
4. **Deploys** the selected template folder
5. **Sets environment** variables via Coolify API
6. **URL assigned**: `{app-name}-{uuid}.app.payloadservers.com`

## Testing Templates Locally

```bash
# Navigate to template
cd blank/

# Copy environment template
cp .env.example .env

# Edit variables
nano .env

# Run locally
docker-compose up -d

# View logs
docker-compose logs -f payload

# Access
open http://localhost:3000/admin

# Stop
docker-compose down
```

## Creating New Templates

1. **Create folder**: `deployment-templates/your-template/`
2. **Add files**:
   - `docker-compose.yml` - Docker Compose configuration
   - `.env.example` - Environment variable template
   - `README.md` - Template documentation

3. **Follow conventions**:
   - Use standard environment variable names
   - Include health checks
   - Set resource limits
   - Document all features

4. **Test locally** before pushing to Git

## Integration with Backend

The PayloadServers backend references templates via:

```go
// config/config.go
type Config struct {
    DeploymentRepoURL string // https://github.com/your-org/deployment-templates
}

// When deploying
templatePath := fmt.Sprintf("%s/%s", config.DeploymentRepoURL, selectedTemplate)
```

## Resource Profiles

### Shared Infrastructure (Default)
- **CPU**: 0.5 cores
- **RAM**: 512MB
- **Storage**: Persistent volumes
- **Use case**: Development, small sites

### Enterprise Dedicated (Upgrade)
- **CPU**: 4 cores
- **RAM**: 8GB
- **Storage**: SSD persistent volumes
- **Includes**: Redis cache, higher database limits

## Coolify Integration

These templates are designed for Coolify's Docker Compose deployment:

1. Coolify reads `docker-compose.yml`
2. Injects environment variables
3. Auto-generates domain
4. Sets up Traefik routing
5. Manages SSL certificates

## Support

For questions or issues:
- **Email**: support@payloadservers.com
- **Docs**: https://docs.payloadservers.com
- **Discord**: https://discord.gg/payloadservers

## License

These templates are provided as part of PayloadServers platform.
