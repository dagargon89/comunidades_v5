Documentación de Componentes del Dashboard por Sección - Financiers Dashboard
Estructura General del Dashboard
El dashboard está organizado en 6 secciones principales, cada una con sus propios filtros, visualizaciones y tablas:

1. Financier Dashboard - Panel principal de financiadoras
2. Executive Summary - Resumen ejecutivo con IA
3. Project Performance - Rendimiento de proyectos
4. Activity Tracking - Seguimiento de actividades
5. Event Management - Gestión de eventos y beneficiarios
6. Reports - Reportes y documentos PDF

---

1. Financier Dashboard
   📍 Ubicación en Código
   • Módulo: modules/financier_module.R
   • Vista de Navegación: nav_panel("Financier Dashboard")
   🔍 Filtros
   Filtro Fuente de Datos Consulta SQL
   Select Financier vista_progreso_proyectos.Financiadora_id SELECT DISTINCT Financiadora_id FROM vista_progreso_proyectos
   📊 KPIs/Métricas
   Métrica Fuente de Datos Cálculo
   Total Projects vista_progreso_proyectos.Proyecto_ID n_distinct(Proyecto_ID)
   Total Investment vista_progreso_proyectos.Proyecto_cantidad_financiada sum(Proyecto_cantidad_financiada)
   Total Beneficiaries vista_progreso_proyectos.Beneficiarios_evento sum(Beneficiarios_evento, na.rm = TRUE)
   Unique Products vista_progreso_proyectos.Productos_realizados sum(Productos_realizados, na.rm = TRUE)
   📈 Visualizaciones/Gráficas
   Gráfica Fuente de Datos Columnas Utilizadas
   Cost per Beneficiary by Project vista_progreso_proyectos Proyecto, Proyecto_cantidad_financiada, Beneficiarios_evento
   Cost per Product by Project vista_progreso_proyectos Proyecto, Proyecto_cantidad_financiada, Productos_realizados
   Population Progress by Project vista_progreso_proyectos Proyecto, population_progress_percent
   Product Progress by Project vista_progreso_proyectos Proyecto, product_progress_percent
   🗂️ Tablas
   Tabla Fuente de Datos Columnas Mostradas
   Project Details vista_progreso_proyectos Proyecto, Proyecto_cantidad_financiada, Beneficiarios_evento, population_progress_percent, product_progress_percent

---

2. Executive Summary
   📍 Ubicación en Código
   • Módulo: modules/executive_summary_module.R
   • Vista de Navegación: nav_panel("Executive Summary")
   🔍 Filtros
   Filtro Fuente de Datos Consulta SQL
   Mode Toggle (Financier/Internal) AI_summary_financier / AI_summary_internal Intercambio dinámico entre vistas
   Project Filter (Financier) AI_summary_financier.proyecto SELECT DISTINCT proyecto FROM AI_summary_financier
   Project Filter (Internal) AI_summary_internal.proyecto SELECT DISTINCT proyecto FROM AI_summary_internal
   📊 KPIs/Métricas
   Métrica Fuente de Datos Cálculo
   Financier Mode KPIs AI_summary_financier Métricas agregadas de la vista
   Internal Mode KPIs AI_summary_internal Métricas agregadas de la vista
   🤖 IA/Reportes Especiales
   Componente Fuente de Datos Procesamiento
   AI Executive Summary vista_progreso_proyectos (datos agregados) Google Gemini API
   Statistical Summary vista_progreso_proyectos Resumen estadístico local
   🗂️ Tablas
   Tabla Fuente de Datos Columnas Mostradas
   Project Data Table (Financier) AI_summary_financier Todas las columnas de la vista
   Project Data Table (Internal) AI_summary_internal Todas las columnas de la vista

---

3. Project Performance
   📍 Ubicación en Código
   • Módulo: modules/project_performance_module.R
   • Vista de Navegación: nav_panel("Project Performance")
   🔍 Filtros
   Filtro Fuente de Datos Consulta SQL
   Select Project vista_progreso_proyectos.Proyecto_ID, Proyecto SELECT DISTINCT Proyecto_ID, Proyecto FROM vista_progreso_proyectos ORDER BY Proyecto
   📊 KPIs/Métricas
   Métrica Fuente de Datos Cálculo
   Project Total Investment vista_progreso_proyectos.Proyecto_cantidad_financiada unique(Proyecto_cantidad_financiada)
   Total Activities vista_progreso_proyectos.Actividad n_distinct(Actividad)
   Total Beneficiaries vista_progreso_proyectos.Beneficiarios_evento sum(Beneficiarios_evento, na.rm = TRUE)
   📈 Visualizaciones/Gráficas
   Gráfica Fuente de Datos Columnas Utilizadas
   Event Timeline by Activity vista_progreso_proyectos Evento_Fecha_Inicio, Actividad
   🗂️ Tablas
   Tabla Fuente de Datos Columnas Mostradas
   Activity Performance Details vista_progreso_proyectos Actividad, population_progress_percent, product_progress_percent, Eventos_completados, Eventos_calendarizados

---

4. Activity Tracking
   📍 Ubicación en Código
   • Módulo: modules/activity_tracking_module.R
   • Vista de Navegación: nav_panel("Activity Tracking")
   🔍 Filtros
   Filtro Fuente de Datos Consulta SQL
   Select Project vista_progreso_proyectos.Proyecto_ID, Proyecto SELECT DISTINCT Proyecto_ID, Proyecto FROM vista_progreso_proyectos ORDER BY Proyecto
   Select Activity vista_progreso_proyectos.Actividad Filtrado dinámico por proyecto seleccionado
   📊 KPIs/Métricas
   Métrica Fuente de Datos Cálculo
   Activity Progress vista_progreso_proyectos.population_progress_percent Promedio de progreso por actividad
   Total Beneficiaries vista_progreso_proyectos.Beneficiarios_evento sum(Beneficiarios_evento, na.rm = TRUE)
   Completed Events vista_progreso_proyectos.Eventos_completados sum(Eventos_completados, na.rm = TRUE)
   Scheduled Events vista_progreso_proyectos.Eventos_calendarizados sum(Eventos_calendarizados, na.rm = TRUE)
   🗂️ Tablas
   Tabla Fuente de Datos Columnas Mostradas
   Activity Details vista_progreso_proyectos Actividad, population_progress_percent, product_progress_percent, Eventos_completados, Beneficiarios_evento

---

5. Event Management
   📍 Ubicación en Código
   • Módulo: modules/event_dashboard_module.R
   • Vista de Navegación: nav_panel("Event Management")
   🔍 Filtros
   Filtro Fuente de Datos Consulta SQL
   Select Project padron_beneficiarios.nombre_proyecto Filtrado dinámico de proyectos únicos
   Select Activity padron_beneficiarios.nombre_actividad Filtrado por proyecto seleccionado
   Select Event padron_beneficiarios.Evento_Fecha_Inicio Filtrado por actividad seleccionada
   📊 KPIs/Métricas
   Métrica Fuente de Datos Cálculo
   Total Beneficiaries padron_beneficiarios nrow() de registros filtrados
   🗂️ Tablas
   Tabla Fuente de Datos Columnas Mostradas
   Beneficiaries Table padron_beneficiarios Todas las columnas de la vista

---

6. Reports
   📍 Ubicación en Código
   • Módulo: modules/reports_module.R
   • Vista de Navegación: nav_panel("Reports")
   🔍 Filtros
   Filtro Fuente de Datos Consulta SQL
   Select Project vista_progreso_proyectos.Proyecto_ID, Proyecto SELECT DISTINCT Proyecto_ID, Proyecto FROM vista_progreso_proyectos ORDER BY Proyecto
   Select Year vista_progreso_proyectos.Evento_Fecha_Inicio SELECT DISTINCT YEAR(Evento_Fecha_Inicio) FROM vista_progreso_proyectos WHERE Evento_Fecha_Inicio IS NOT NULL ORDER BY event_year DESC
   Select Month Estático (1-12) Lista estática de meses
   📊 Vista Previa de Datos
   Componente Fuente de Datos Consulta SQL
   Data Preview vista_progreso_proyectos SELECT Proyecto_ID, Proyecto, Actividad, Evento_Fecha_Inicio, Beneficiarios_evento FROM vista_progreso_proyectos WHERE Proyecto_ID = ? AND YEAR(Evento_Fecha_Inicio) = ? AND MONTH(Evento_Fecha_Inicio) = ?
   📄 Generación de Reportes PDF
   Reporte Fuente de Datos Columnas Utilizadas
   Monthly Activity Report vista_progreso_proyectos Proyecto_ID, Proyecto, Actividad, Evento_Fecha_Inicio, Beneficiarios_evento
   🗂️ Tablas
   Tabla Fuente de Datos Columnas Mostradas
   Preview Data Table vista_progreso_proyectos Actividad, Fecha (Evento_Fecha_Inicio), Beneficiarios (Beneficiarios_evento)
