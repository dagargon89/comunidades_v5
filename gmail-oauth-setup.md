# Configuración OAuth2 para Google Workspace

## Para cuentas administradas (Google Workspace)

### 1. Crear Proyecto en Google Cloud Console

1. Ve a: https://console.cloud.google.com/
2. Crea un nuevo proyecto o selecciona uno existente
3. Habilita la API de Gmail

### 2. Configurar OAuth2

1. Ve a "APIs y servicios" → "Credenciales"
2. Crea credenciales OAuth2
3. Configura las URIs de redirección autorizadas
4. Descarga el archivo JSON de credenciales

### 3. Configuración en Laravel

```env
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=contacto@planjuarez.org
MAIL_PASSWORD=null
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=contacto@planjuarez.org
MAIL_FROM_NAME="Planeación Estratégica"

# OAuth2 Configuration
GOOGLE_CLIENT_ID=tu-client-id
GOOGLE_CLIENT_SECRET=tu-client-secret
GOOGLE_REFRESH_TOKEN=tu-refresh-token
```

### 4. Instalar paquete OAuth2

```bash
composer require google/apiclient
```

## Alternativa: Usar otro proveedor de correo

### Opción A: Mailgun

```env
MAIL_MAILER=mailgun
MAILGUN_DOMAIN=tu-dominio.com
MAILGUN_SECRET=tu-api-key
```

### Opción B: Postmark

```env
MAIL_MAILER=postmark
POSTMARK_TOKEN=tu-token
```

### Opción C: SendGrid

```env
MAIL_MAILER=smtp
MAIL_HOST=smtp.sendgrid.net
MAIL_PORT=587
MAIL_USERNAME=apikey
MAIL_PASSWORD=tu-sendgrid-api-key
MAIL_ENCRYPTION=tls
```
