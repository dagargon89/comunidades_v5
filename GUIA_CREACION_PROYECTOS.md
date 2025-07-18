# 📋 Documento de Funcionamiento - Guía de Creación de Proyectos

## 🎯 **Descripción General**

La página de **Guía de Creación de Proyectos** es una aplicación web desarrollada con **Laravel Filament** que permite a los usuarios crear proyectos de manera guiada y estructurada. La aplicación utiliza componentes nativos de Filament y almacena datos temporalmente en sesión antes de persistirlos en la base de datos.

---

## 🏗️ **Arquitectura Técnica**

### **Tecnologías Utilizadas:**

-   **Backend:** Laravel 12.20.0
-   **Frontend:** Filament (TALL Stack)
-   **Base de Datos:** MySQL
-   **Framework UI:** Filament Components

### **Estructura de Archivos:**

```
app/Filament/Pages/ProjectCreationGuide.php     # Controlador principal
resources/views/filament/pages/project-creation-guide.blade.php  # Vista
database/comunidades_v5 (2).sql                 # Esquema de BD
```

---

## 📊 **Estructura de Base de Datos**

### **Tablas Principales:**

#### **1. `projects`**

```sql
- id (bigint, primary key)
- name (varchar(500), required)
- background (text)
- justification (text)
- general_objective (text)
- financiers_id (bigint, required)
- start_date (date)
- end_date (date)
- total_cost (double)
- funded_amount (double)
- cofunding_amount (double)
- monthly_disbursement (double)
- followup_officer (text)
- agreement_file (text)
- project_base_file (text)
- co_financier_id (bigint)
- created_by (bigint, required)
```

#### **2. `specific_objectives`**

```sql
- id (bigint, primary key)
- description (text)
- projects_id (bigint, required)
```

#### **3. `kpis`**

```sql
- id (bigint, primary key)
- name (varchar(50))
- description (text)
- initial_value (decimal(10,2))
- final_value (decimal(10,2))
- projects_id (bigint, required)
- is_percentage (tinyint(1))
- org_area (varchar(100))
```

#### **4. `locations`**

```sql
- id (bigint, primary key)
- name (varchar(150), required)
- category (varchar(50))
- street (text)
- neighborhood (varchar(100))
- ext_number (int)
- int_number (int)
- google_place_id (varchar(500))
- polygons_id (bigint, required)
- created_by (bigint, required)
```

#### **5. `activities`**

```sql
- id (bigint, primary key)
- name (varchar(255), required)
- specific_objective_id (bigint, required)
- description (text)
- goals_id (bigint, required)
- created_by (bigint, required)
```

---

## 🔄 **Flujo de Funcionamiento**

### **1. Inicialización**

```php
public function mount()
{
    $this->loadTemporaryData();
}
```

-   Carga datos temporales desde la sesión
-   Inicializa propiedades del componente Livewire

### **2. Almacenamiento Temporal**

```php
public function saveTemporaryData()
{
    Session::put('project_creation_guide.project', $this->projectData);
    Session::put('project_creation_guide.objectives', $this->objectivesData);
    // ... más datos
}
```

-   Guarda datos en sesión de Laravel
-   Permite navegación sin pérdida de información

### **3. Cálculo de Progreso**

```php
public function getProgressProperty()
{
    $completed = $this->completedSteps;
    $total = $this->totalSteps;
    return $total > 0 ? round(($completed / $total) * 100) : 0;
}
```

-   Calcula porcentaje de completitud
-   Basado en secciones completadas vs total

---

## 📝 **Secciones del Formulario**

### **1. Información Básica del Proyecto**

-   **Campos:** `name`, `background`
-   **Validación:** Nombre requerido
-   **Acción:** Guardar datos del proyecto

### **2. Objetivos Específicos**

-   **Campos:** `description`
-   **Componente:** Repeater
-   **Validación:** Descripción requerida
-   **Acción:** Guardar objetivos

### **3. Indicadores de Rendimiento (KPIs)**

-   **Campos:** `name`, `description`, `initial_value`, `final_value`, `is_percentage`, `org_area`
-   **Componente:** Repeater con Toggle
-   **Validación:** Nombre, valores inicial y final requeridos
-   **Acción:** Guardar KPIs

### **4. Cofinanciadores**

-   **Campos:** `financier_id`, `amount`
-   **Componente:** Repeater con Select
-   **Validación:** Financiador y monto requeridos
-   **Acción:** Guardar cofinanciadores

### **5. Ubicaciones**

-   **Campos:** `name`, `category`, `street`, `neighborhood`, `ext_number`, `int_number`, `polygons_id`
-   **Componente:** Repeater
-   **Validación:** Nombre y polígono requeridos
-   **Acción:** Guardar ubicaciones

### **6. Actividades**

-   **Campos:** `name`, `specific_objective_id`, `description`, `goals_id`
-   **Componente:** Repeater con Select
-   **Validación:** Nombre, objetivo específico y meta requeridos
-   **Acción:** Guardar actividades

### **7. Programación de Actividades**

-   **Campos:** `activity_id`, `start_date`, `end_date`
-   **Componente:** Repeater con DatePicker
-   **Validación:** Actividad y fechas requeridas
-   **Acción:** Guardar programación

---

## 🎨 **Componentes Filament Utilizados**

### **Formularios:**

-   `TextInput`: Campos de texto
-   `Textarea`: Campos de texto largo
-   `Select`: Campos de selección
-   `DatePicker`: Campos de fecha
-   `Toggle`: Campos booleanos
-   `Repeater`: Listas dinámicas

### **Layout:**

-   `Section`: Agrupación de campos
-   `Grid`: Layout responsivo
-   `Actions`: Botones de acción
-   `Placeholder`: Contenido estático

### **Modales:**

-   `Modal`: Ventana emergente para resumen
-   `Card`: Contenedores de información

---

## 💾 **Persistencia de Datos**

### **Almacenamiento Temporal:**

```php
// En sesión de Laravel
Session::put('project_creation_guide.project', $projectData);
Session::put('project_creation_guide.objectives', $objectivesData);
// ... más datos
```

### **Persistencia Final:**

```php
public function saveProject()
{
    DB::beginTransaction();
    try {
        // Crear proyecto
        $project = Project::create($this->projectData);

        // Crear objetivos específicos
        foreach ($this->objectivesData as $objective) {
            SpecificObjective::create([
                'description' => $objective['description'],
                'projects_id' => $project->id
            ]);
        }

        // ... más entidades

        DB::commit();
        Notification::make()->success()->send();
    } catch (\Exception $e) {
        DB::rollBack();
        throw $e;
    }
}
```

---

## 🔧 **Funcionalidades Especiales**

### **1. Progreso Dinámico**

-   Calcula automáticamente el porcentaje de completitud
-   Muestra indicador visual de progreso
-   Habilita botón de resumen al 100%

### **2. Validación en Tiempo Real**

-   Validación nativa de Filament
-   Mensajes de error contextuales
-   Prevención de envío con datos inválidos

### **3. Modal de Resumen**

-   Muestra todos los datos ingresados
-   Permite revisión antes de guardar
-   Opciones: Confirmar, Editar, Cancelar

### **4. Notificaciones**

-   Notificaciones de éxito al guardar secciones
-   Notificaciones de error en caso de fallo
-   Feedback visual inmediato

---

## 🚀 **Instrucciones de Uso**

### **Para Desarrolladores:**

1. **Acceso:** `/admin/project-creation-guide`
2. **Navegación:** Secuencial por secciones
3. **Guardado:** Cada sección se guarda independientemente
4. **Resumen:** Aparece al completar todas las secciones
5. **Persistencia:** Datos se guardan en BD al confirmar

### **Para Usuarios:**

1. **Completar** cada sección del formulario
2. **Guardar** cada sección antes de continuar
3. **Revisar** el resumen antes de confirmar
4. **Confirmar** para persistir en base de datos

---

## 🔍 **Solución de Problemas**

### **Errores Comunes:**

1. **"Undefined variable $progress"**

    - **Solución:** Usar `$this->progress` en Blade

2. **"Column not found"**

    - **Solución:** Verificar campos en esquema de BD

3. **"Undefined array key"**
    - **Solución:** Usar operador `??` para campos opcionales

### **Debugging:**

-   Revisar logs en `storage/logs/laravel.log`
-   Verificar sesión con `Session::all()`
-   Comprobar BD con `php artisan tinker`

---

## 📈 **Mejoras Futuras**

### **Funcionalidades Pendientes:**

-   [ ] Validación cruzada entre secciones
-   [ ] Exportación de resumen a PDF
-   [ ] Plantillas de proyectos
-   [ ] Historial de versiones
-   [ ] Colaboración en tiempo real

### **Optimizaciones:**

-   [ ] Caché de datos frecuentes
-   [ ] Lazy loading de componentes
-   [ ] Compresión de assets
-   [ ] Optimización de consultas BD

---

## 📞 **Contacto y Soporte**

-   **Documentación:** Filament Docs
-   **Issues:** GitHub Repository
-   **Comunidad:** Laravel Forums

---

_Documento actualizado: Enero 2025_  
_Versión: 1.0_  
_Autor: Sistema de IA_
