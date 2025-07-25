# 📁 Archivos de Prueba - Sistema de Gestión de Proyectos

Esta carpeta contiene archivos de prueba utilizados para verificar la funcionalidad del sistema de gestión de proyectos, específicamente el borrado en cascada de `PlannedMetric`.

## 📋 Archivos incluidos:

### 1. `CreateTestProject.php`

**Descripción:** Comando Artisan para crear múltiples proyectos de prueba con datos completos.

**Uso:**

```bash
# Crear un proyecto de prueba
php artisan test:create-project

# Crear múltiples proyectos de prueba
php artisan test:create-project 10
```

**Funcionalidad:**

-   Crea proyectos con datos variados
-   Genera objetivos específicos, KPIs, metas y actividades
-   Crea `PlannedMetric` asociados a cada actividad
-   Incluye logs detallados del proceso

### 2. `TestProjectDelete.php`

**Descripción:** Comando Artisan para probar el borrado de proyectos y verificar la eliminación de `PlannedMetric`.

**Uso:**

```bash
# Probar borrado del último proyecto creado
php artisan test:delete-project

# Probar borrado de un proyecto específico
php artisan test:delete-project 25
```

**Funcionalidad:**

-   Muestra datos antes y después del borrado
-   Verifica que los `PlannedMetric` se eliminen correctamente
-   Detecta registros huérfanos
-   Proporciona reportes detallados

### 3. `TestDelete.php`

**Descripción:** Comando Artisan simplificado para probar el borrado de un proyecto específico.

**Uso:**

```bash
# Probar borrado de un proyecto específico
php artisan test:delete 30
```

**Funcionalidad:**

-   Versión simplificada del comando de borrado
-   Muestra datos detallados antes y después del borrado
-   Verifica la eliminación de `PlannedMetric`
-   Detecta registros huérfanos

### 4. `ProjectObserver.php`

**Descripción:** Observer de Laravel para el modelo `Project` que maneja eventos de borrado.

**Funcionalidad:**

-   Se ejecuta cuando se borra un proyecto
-   Registra logs para debugging
-   Complementa la lógica de borrado en cascada del modelo

## 🧪 Pruebas realizadas:

### ✅ **Prueba exitosa de borrado en cascada:**

-   **Proyectos creados:** 10
-   **Actividades totales:** 30
-   **PlannedMetrics totales:** 30
-   **Resultado:** Todos los `PlannedMetric` se eliminaron correctamente
-   **Registros huérfanos:** 0

### 📊 **Datos de prueba generados:**

-   Proyectos con nombres únicos y datos variados
-   Actividades con valores de población y producto incrementales
-   `PlannedMetric` con valores correspondientes a cada actividad
-   Relaciones completas entre todas las entidades

## 🔧 **Solución implementada:**

### **Orden de borrado en cascada:**

1. **PRIMERO:** Eliminar `PlannedMetric` de todas las actividades
2. **SEGUNDO:** Eliminar actividades
3. **TERCERO:** Eliminar metas
4. **CUARTO:** Eliminar objetivos específicos
5. **QUINTO:** Eliminar KPIs
6. **SEXTO:** Eliminar reportes
7. **SÉPTIMO:** Eliminar desembolsos
8. **OCTAVO:** Eliminar proyectos publicados

### **Archivos principales del sistema:**

-   `app/Models/Project.php` - Lógica de borrado en cascada
-   `app/Providers/AppServiceProvider.php` - Registro del observer
-   `app/Models/PlannedMetric.php` - Modelo de métricas planificadas

## 📝 **Notas importantes:**

-   Los archivos en esta carpeta son **solo para pruebas**
-   No afectan el funcionamiento normal del sistema
-   Se pueden restaurar moviendo los archivos de vuelta a sus ubicaciones originales
-   Los comandos requieren que existan datos básicos (usuarios, componentes, organizaciones)

## 🚀 **Comandos útiles:**

```bash
# Crear 10 proyectos de prueba
php artisan test:create-project 10

# Probar borrado de un proyecto específico
php artisan test:delete 30

# Verificar logs de borrado
tail -n 20 storage/logs/laravel.log
```

**Nota:** Los comandos `test:create-project` y `test:delete-project` están en archivosprueba y no están disponibles directamente. Para usarlos, mueve los archivos de vuelta a `app/Console/Commands/` y `app/Observers/` respectivamente.

---

_Creado el: 25/07/2025_
_Última actualización: 25/07/2025_
