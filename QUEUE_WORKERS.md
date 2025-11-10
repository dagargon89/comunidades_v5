# 🔄 Configuración de Workers de Cola (Queue Workers)

Este documento explica cómo ejecutar los workers de cola en **desarrollo** y **producción** para procesar jobs asíncronos en Laravel.

---

## 📚 Tabla de Contenidos

1. [¿Qué son los Queue Workers?](#qué-son-los-queue-workers)
2. [Desarrollo (Local)](#desarrollo-local)
3. [Producción (Servidor)](#producción-servidor)
4. [Troubleshooting](#troubleshooting)
5. [Monitoreo](#monitoreo)

---

## 🎯 ¿Qué son los Queue Workers?

Los **Queue Workers** son procesos que ejecutan jobs (trabajos) en segundo plano. En nuestro proyecto, los usamos para:

- ✅ Generar narrativas con IA (puede tardar minutos)
- ✅ Crear informes completos (procesar 50+ eventos)
- ✅ Enviar notificaciones
- ✅ Tareas pesadas que no deben bloquear la interfaz

**Sin workers:** Los jobs se quedan en la tabla `jobs` sin procesar.
**Con workers:** Los jobs se ejecutan automáticamente en segundo plano.

---

## 💻 Desarrollo (Local)

### Opción 1: Comando Simple (Recomendado para desarrollo)

Abre una terminal **adicional** en tu proyecto y ejecuta:

```bash
php artisan queue:work
```

**Características:**
- ✅ Simple y directo
- ✅ Ver logs en tiempo real
- ⚠️ Debes reiniciarlo si cambias código
- ⚠️ Se detiene si cierras la terminal

---

### Opción 2: Con Recarga Automática

Si estás cambiando código frecuentemente:

```bash
php artisan queue:work --tries=3 --timeout=300
```

**Parámetros:**
- `--tries=3` → Reintentar 3 veces si falla
- `--timeout=300` → Timeout de 5 minutos por job

Para recargar cambios de código sin reiniciar:

```bash
php artisan queue:restart
```

---

### Opción 3: Procesar Jobs Una Vez (Testing)

Para procesar solo los jobs pendientes y salir:

```bash
php artisan queue:work --once
```

---

### Opción 4: Modo Daemon (Windows con Laragon)

Si usas **Laragon** en Windows, puedes crear un archivo batch para iniciar el worker automáticamente:

**Crear archivo:** `start-queue-worker.bat`

```batch
@echo off
echo Iniciando Queue Worker...
cd C:\laragon\www\comunidades_v5
php artisan queue:work --sleep=3 --tries=3 --timeout=300
pause
```

Doble click para ejecutar. **Nota:** Reinicia después de cambios en código.

---

### 🔍 Ver Logs en Desarrollo

Los logs se guardan en:
```
storage/logs/laravel.log
```

Para ver en tiempo real (Linux/Mac):
```bash
tail -f storage/logs/laravel.log
```

Para Windows (PowerShell):
```powershell
Get-Content storage/logs/laravel.log -Wait -Tail 50
```

---

## 🚀 Producción (Servidor)

En producción, necesitas que los workers **siempre estén corriendo** incluso si:
- El servidor se reinicia
- El worker falla
- Hay actualizaciones del código

### Configuración con Supervisor (Recomendado)

**Supervisor** es un gestor de procesos que mantiene los workers siempre activos.

---

### Paso 1: Instalar Supervisor (Ubuntu/Debian)

```bash
sudo apt-get update
sudo apt-get install supervisor
```

Para CentOS/RHEL:
```bash
sudo yum install supervisor
```

---

### Paso 2: Crear Archivo de Configuración

Crea el archivo de configuración del worker:

```bash
sudo nano /etc/supervisor/conf.d/comunidades-worker.conf
```

Pega esta configuración:

```ini
[program:comunidades-worker]
process_name=%(program_name)s_%(process_num)02d
command=php /var/www/comunidades_v5/artisan queue:work database --sleep=3 --tries=3 --max-time=3600 --timeout=300
autostart=true
autorestart=true
stopasgroup=true
killasgroup=true
user=www-data
numprocs=2
redirect_stderr=true
stdout_logfile=/var/www/comunidades_v5/storage/logs/worker.log
stopwaitsecs=3600
```

**Explicación de parámetros:**

| Parámetro | Descripción |
|-----------|-------------|
| `process_name` | Nombre del proceso (con número) |
| `command` | Comando completo a ejecutar |
| `queue:work database` | Usar driver de database (configurado en .env) |
| `--sleep=3` | Esperar 3 segundos entre polls |
| `--tries=3` | Reintentar 3 veces si falla |
| `--max-time=3600` | Reiniciar worker cada 1 hora (libera memoria) |
| `--timeout=300` | 5 minutos de timeout por job |
| `autostart=true` | Iniciar al arrancar el servidor |
| `autorestart=true` | Reiniciar automáticamente si falla |
| `user=www-data` | Usuario que ejecuta el proceso (ajustar según tu servidor) |
| `numprocs=2` | Número de workers en paralelo (ajustar según carga) |
| `stdout_logfile` | Archivo de log |

---

### Paso 3: Recargar Supervisor

```bash
# Recargar configuración
sudo supervisorctl reread

# Actualizar cambios
sudo supervisorctl update

# Iniciar el worker
sudo supervisorctl start comunidades-worker:*
```

---

### Paso 4: Verificar Estado

```bash
sudo supervisorctl status
```

Deberías ver:
```
comunidades-worker:comunidades-worker_00   RUNNING   pid 12345, uptime 0:00:10
comunidades-worker:comunidades-worker_01   RUNNING   pid 12346, uptime 0:00:10
```

---

### Comandos Útiles de Supervisor

```bash
# Ver estado de todos los procesos
sudo supervisorctl status

# Iniciar un worker
sudo supervisorctl start comunidades-worker:*

# Detener un worker
sudo supervisorctl stop comunidades-worker:*

# Reiniciar un worker
sudo supervisorctl restart comunidades-worker:*

# Ver logs en tiempo real
sudo supervisorctl tail -f comunidades-worker:comunidades-worker_00

# Recargar toda la configuración de Supervisor
sudo supervisorctl reload
```

---

### Paso 5: Reiniciar Workers Después de Desplegar Código

**Importante:** Después de hacer `git pull` o actualizar código, **debes reiniciar los workers**:

```bash
# Opción 1: Reinicio graceful (termina jobs actuales)
php artisan queue:restart

# Opción 2: Reinicio inmediato via Supervisor
sudo supervisorctl restart comunidades-worker:*
```

**Automatizar en tu script de deployment:**

```bash
#!/bin/bash
# deploy.sh

cd /var/www/comunidades_v5

# Pull código
git pull origin main

# Instalar dependencias
composer install --no-dev --optimize-autoloader

# Migraciones
php artisan migrate --force

# Limpiar caches
php artisan optimize:clear
php artisan optimize

# ⚠️ IMPORTANTE: Reiniciar workers
php artisan queue:restart

echo "Deployment completado!"
```

---

## 🔧 Configuración Avanzada

### Múltiples Colas con Prioridades

Si tienes diferentes tipos de jobs, puedes crear colas separadas:

**En tu Job:**
```php
class GenerarNarrativaJob implements ShouldQueue
{
    public $queue = 'narrativas'; // Cola específica
}
```

**Configuración de Supervisor con prioridades:**

```ini
# Worker para cola de alta prioridad (notificaciones)
[program:comunidades-worker-high]
command=php /var/www/comunidades_v5/artisan queue:work database --queue=high --sleep=1 --tries=3
numprocs=1

# Worker para cola normal (narrativas)
[program:comunidades-worker-default]
command=php /var/www/comunidades_v5/artisan queue:work database --queue=default --sleep=3 --tries=3
numprocs=2

# Worker para cola de baja prioridad (informes)
[program:comunidades-worker-low]
command=php /var/www/comunidades_v5/artisan queue:work database --queue=low --sleep=5 --tries=3
numprocs=1
```

---

### Configuración Según Recursos del Servidor

**Servidor pequeño (1-2 GB RAM):**
```ini
numprocs=1
--max-time=1800  # 30 minutos
```

**Servidor mediano (4-8 GB RAM):**
```ini
numprocs=2
--max-time=3600  # 1 hora
```

**Servidor grande (16+ GB RAM):**
```ini
numprocs=4
--max-time=7200  # 2 horas
```

---

## 🐛 Troubleshooting

### Problema 1: Workers no procesan jobs

**Síntomas:** Jobs se quedan en tabla `jobs` sin procesar.

**Solución:**
```bash
# Verificar que workers estén corriendo
sudo supervisorctl status

# Ver logs
sudo supervisorctl tail -f comunidades-worker:comunidades-worker_00

# Reiniciar workers
sudo supervisorctl restart comunidades-worker:*
```

---

### Problema 2: Jobs fallan constantemente

**Síntomas:** Jobs aparecen en tabla `failed_jobs`.

**Solución:**
```bash
# Ver jobs fallidos
php artisan queue:failed

# Ver detalles de un job fallido
php artisan queue:failed --id=123

# Reintentar todos los jobs fallidos
php artisan queue:retry all

# Reintentar un job específico
php artisan queue:retry 123

# Limpiar jobs fallidos antiguos
php artisan queue:flush
```

---

### Problema 3: Workers consumen mucha memoria

**Síntomas:** Servidor se queda sin memoria.

**Solución:**
```bash
# Reducir max-time para reiniciar más frecuente
--max-time=1800  # 30 minutos

# Reducir número de procesos
numprocs=1

# Agregar límite de memoria
--memory=256  # MB
```

**Actualizar configuración:**
```ini
command=php /var/www/comunidades_v5/artisan queue:work database --sleep=3 --tries=3 --max-time=1800 --memory=256
```

---

### Problema 4: Workers no reinician después de deployment

**Síntomas:** Cambios de código no se reflejan.

**Solución:**
```bash
# Siempre después de deployment
php artisan queue:restart

# O forzar con Supervisor
sudo supervisorctl restart comunidades-worker:*
```

---

### Problema 5: Jobs tardan mucho

**Síntomas:** Jobs se quedan en estado "processing" por horas.

**Solución:**
```bash
# Aumentar timeout
--timeout=600  # 10 minutos

# Verificar que el job no esté en loop infinito
sudo supervisorctl tail -f comunidades-worker:comunidades-worker_00
```

---

## 📊 Monitoreo

### Ver Estado de la Cola

```bash
# Ver jobs pendientes
php artisan queue:monitor

# Ver jobs fallidos
php artisan queue:failed

# Ver jobs en proceso (requiere Laravel Horizon)
php artisan horizon:list
```

---

### Logs Importantes

**Logs del Worker:**
```
/var/www/comunidades_v5/storage/logs/worker.log
```

**Logs de Laravel:**
```
/var/www/comunidades_v5/storage/logs/laravel.log
```

**Logs de Supervisor:**
```
/var/log/supervisor/supervisord.log
```

---

### Monitoreo con Telegraf + InfluxDB + Grafana (Avanzado)

Si quieres monitoreo visual profesional:

1. **Instalar Telegraf** para recolectar métricas
2. **Configurar InfluxDB** para almacenar datos
3. **Crear dashboard en Grafana** para visualizar

**Métricas útiles:**
- Jobs procesados por minuto
- Tiempo promedio de procesamiento
- Jobs fallidos
- Uso de memoria/CPU por worker

---

## 📋 Checklist de Producción

Antes de ir a producción, verifica:

- [ ] Supervisor instalado y configurado
- [ ] Workers configurados con `numprocs` adecuado
- [ ] `--max-time` configurado para liberar memoria
- [ ] `--timeout` suficiente para jobs largos
- [ ] Logs configurados correctamente
- [ ] Script de deployment reinicia workers
- [ ] Monitoreo de jobs fallidos configurado
- [ ] Alertas configuradas para workers caídos
- [ ] Backup de tabla `jobs` y `job_batches`

---

## 🆘 Soporte y Recursos

**Documentación oficial:**
- [Laravel Queues](https://laravel.com/docs/12.x/queues)
- [Supervisor](http://supervisord.org/configuration.html)

**Comandos rápidos:**
```bash
# Desarrollo
php artisan queue:work

# Producción
sudo supervisorctl status
sudo supervisorctl restart comunidades-worker:*

# Troubleshooting
php artisan queue:failed
php artisan queue:retry all
```

---

## 📝 Notas Finales

1. **En desarrollo:** Usa `php artisan queue:work` en terminal separada
2. **En producción:** Usa **Supervisor** siempre
3. **Siempre reinicia workers** después de cambios de código
4. **Monitorea jobs fallidos** regularmente
5. **Configura alertas** para workers caídos

---

**Última actualización:** Noviembre 2025
**Proyecto:** Comunidades V5
**Autor:** Equipo de Desarrollo
