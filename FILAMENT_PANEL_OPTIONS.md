# Opciones de Configuración del Panel de Filament

Este documento contiene todas las opciones disponibles para configurar un panel de Filament, organizadas por categorías y con ejemplos de uso.

## Índice

1. [Configuración Básica](#configuración-básica)
2. [Navegación y Layout](#navegación-y-layout)
3. [Autenticación y Usuarios](#autenticación-y-usuarios)
4. [Recursos, Páginas y Widgets](#recursos-páginas-y-widgets)
5. [Middleware y Seguridad](#middleware-y-seguridad)
6. [Branding y Personalización](#branding-y-personalización)
7. [Rendimiento y Optimización](#rendimiento-y-optimización)
8. [Configuración Avanzada](#configuración-avanzada)

---

## Configuración Básica

### ID y Ruta del Panel

```php
return $panel
    ->id('admin')                    // ID único del panel
    ->path('admin')                  // Ruta base del panel
    ->default()                      // Marcar como panel por defecto
    ->domain('admin.midominio.com'); // Dominio específico (opcional)
```

### Configuración de Ancho de Contenido

```php
use Filament\Support\Enums\MaxWidth;

return $panel
    ->maxContentWidth(MaxWidth::Full)              // Ancho completo
    ->maxContentWidth(MaxWidth::SevenExtraLarge)   // 80rem (1280px)
    ->maxContentWidth(MaxWidth::SixExtraLarge)     // 72rem (1152px)
    ->maxContentWidth(MaxWidth::FiveExtraLarge)    // 64rem (1024px)
    ->maxContentWidth(MaxWidth::FourExtraLarge)    // 56rem (896px)
    ->maxContentWidth(MaxWidth::ThreeExtraLarge)   // 48rem (768px)
    ->maxContentWidth(MaxWidth::TwoExtraLarge)     // 42rem (672px)
    ->maxContentWidth(MaxWidth::ExtraLarge)        // 36rem (576px)
    ->maxContentWidth(MaxWidth::Large)             // 32rem (512px)
    ->maxContentWidth(MaxWidth::Medium)            // 28rem (448px)
    ->maxContentWidth(MaxWidth::Small)             // 24rem (384px)
    ->maxContentWidth(MaxWidth::ExtraSmall);       // 20rem (320px)
```

---

## Navegación y Layout

### Tipos de Navegación

```php
return $panel
    ->topNavigation()                           // Navegación en la parte superior
    ->sidebarCollapsibleOnDesktop()            // Sidebar colapsible en desktop
    ->sidebarFullyCollapsibleOnDesktop()       // Sidebar completamente colapsible
    ->sidebarCollapsibleOnTablet()             // Colapsible en tablet
    ->sidebarCollapsibleOnMobile()             // Colapsible en móvil
    ->sidebarCollapsibleOnDesktopAndTablet()   // Colapsible en desktop y tablet
    ->sidebarCollapsibleOnDesktopAndMobile()   // Colapsible en desktop y móvil
    ->sidebarCollapsibleOnTabletAndMobile();   // Colapsible en tablet y móvil
```

### Configuración del Sidebar

```php
return $panel
    ->sidebarWidth('16rem')                    // Ancho del sidebar
    ->sidebarCollapsedWidth('4rem')            // Ancho cuando está colapsado
    ->sidebarCollapsibleOnDesktop()            // Colapsible en desktop
    ->sidebarCollapsibleOnTablet()             // Colapsible en tablet
    ->sidebarCollapsibleOnMobile();            // Colapsible en móvil
```

### Configuración de la Navegación Superior

```php
return $panel
    ->topNavigation()                          // Habilitar navegación superior
    ->topNavigationSticky()                    // Navegación superior fija
    ->topNavigationStickyOnDesktop()           // Fija solo en desktop
    ->topNavigationStickyOnTablet()            // Fija solo en tablet
    ->topNavigationStickyOnMobile();           // Fija solo en móvil
```

---

## Autenticación y Usuarios

### Configuración de Autenticación

```php
return $panel
    ->login()                                  // Habilitar página de login
    ->registration()                           // Habilitar registro de usuarios
    ->passwordReset()                          // Habilitar reset de contraseña
    ->emailVerification()                      // Habilitar verificación de email
    ->profile()                                // Habilitar página de perfil
    ->rememberMe()                             // Habilitar "Recordarme"
    ->twoFactorAuthentication();               // Habilitar autenticación de dos factores
```

### Configuración de Usuarios

```php
use Filament\Navigation\MenuItem;

return $panel
    ->userMenuItems([
        MenuItem::make()
            ->label('Perfil')
            ->url(fn (): string => \Filament\Pages\Auth\EditProfile::getUrl()),
        MenuItem::make()
            ->label('Configuración')
            ->url(fn (): string => \Filament\Pages\Auth\EditSettings::getUrl()),
    ])
    ->userMenuAvatar()                         // Mostrar avatar en menú de usuario
    ->userMenuAvatarSize('lg')                 // Tamaño del avatar
    ->userMenuAvatarUrl(fn ($user) => $user->avatar_url); // URL del avatar
```

### Configuración de Sesión

```php
return $panel
    ->sessionGuard('web')                      // Guard de sesión
    ->sessionMiddleware([
        \Illuminate\Session\Middleware\StartSession::class,
        \Illuminate\View\Middleware\ShareErrorsFromSession::class,
    ])
    ->sessionTimeout(120);                     // Timeout de sesión en minutos
```

---

## Recursos, Páginas y Widgets

### Descubrimiento Automático

```php
return $panel
    ->discoverResources(in: app_path('Filament/Resources'), for: 'App\\Filament\\Resources')
    ->discoverPages(in: app_path('Filament/Pages'), for: 'App\\Filament\\Pages')
    ->discoverWidgets(in: app_path('Filament/Widgets'), for: 'App\\Filament\\Widgets');
```

### Registro Manual

```php
return $panel
    ->resources([
        \App\Filament\Resources\UserResource::class,
        \App\Filament\Resources\PostResource::class,
    ])
    ->pages([
        \App\Filament\Pages\Dashboard::class,
        \App\Filament\Pages\Settings::class,
    ])
    ->widgets([
        \App\Filament\Widgets\StatsOverview::class,
        \App\Filament\Widgets\LatestPosts::class,
    ]);
```

### Configuración de Páginas

```php
return $panel
    ->homeUrl('/dashboard')                    // URL de inicio personalizada
    ->defaultNavigationSort(1)                 // Orden de navegación por defecto
    ->navigationSort(2)                        // Orden de navegación del panel
    ->navigationGroups([
        'Administración' => 1,
        'Contenido' => 2,
        'Configuración' => 3,
    ]);
```

---

## Middleware y Seguridad

### Middleware General

```php
return $panel
    ->middleware([
        \Illuminate\Cookie\Middleware\EncryptCookies::class,
        \Illuminate\Cookie\Middleware\AddQueuedCookiesToResponse::class,
        \Illuminate\Session\Middleware\StartSession::class,
        \Illuminate\View\Middleware\ShareErrorsFromSession::class,
        \Illuminate\Foundation\Http\Middleware\VerifyCsrfToken::class,
        \Illuminate\Routing\Middleware\SubstituteBindings::class,
        \Filament\Http\Middleware\DisableBladeIconComponents::class,
        \Filament\Http\Middleware\DispatchServingFilamentEvent::class,
    ]);
```

### Middleware de Autenticación

```php
return $panel
    ->authMiddleware([
        \Filament\Http\Middleware\Authenticate::class,
    ])
    ->authGuard('web')                         // Guard de autenticación
    ->authPasswordBroker('users');             // Broker de contraseñas
```

### Configuración de Seguridad

```php
return $panel
    ->csrfTokenCookieName('filament_csrf')     // Nombre de cookie CSRF
    ->sessionCookieName('filament_session')    // Nombre de cookie de sesión
    ->trustedHosts(['*.midominio.com'])        // Hosts confiables
    ->contentSecurityPolicy([
        'default-src' => "'self'",
        'script-src' => "'self' 'unsafe-inline'",
        'style-src' => "'self' 'unsafe-inline'",
    ]);
```

---

## Branding y Personalización

### Configuración de Marca

```php
return $panel
    ->brandName('Mi Aplicación')               // Nombre de la marca
    ->brandLogo(asset('images/logo.png'))      // Logo de la marca
    ->brandLogoHeight('2rem')                  // Altura del logo
    ->brandLogoWidth('auto')                   // Ancho del logo
    ->favicon(asset('images/favicon.ico'))     // Favicon personalizado
    ->darkModeBrandLogo(asset('images/logo-dark.png')); // Logo para modo oscuro
```

### Configuración de Tema

```php
return $panel
    ->theme([
        'colors' => [
            'primary' => [
                50 => '238, 242, 255',
                100 => '224, 231, 255',
                500 => '99, 102, 241',
                600 => '88, 80, 236',
                700 => '67, 56, 202',
                900 => '49, 46, 129',
            ],
        ],
        'fontFamily' => 'Inter',
        'fontSize' => [
            'xs' => '0.75rem',
            'sm' => '0.875rem',
            'base' => '1rem',
            'lg' => '1.125rem',
            'xl' => '1.25rem',
        ],
    ]);
```

### Configuración de Colores

```php
use Filament\Support\Colors\Color;

return $panel
    ->colors([
        'primary' => Color::Amber,
        'danger' => Color::Red,
        'gray' => Color::Slate,
        'info' => Color::Blue,
        'success' => Color::Emerald,
        'warning' => Color::Orange,
    ]);
```

---

## Rendimiento y Optimización

### Configuración de Vite

```php
return $panel
    ->viteTheme('resources/css/filament/admin/theme.css')
    ->vite([
        'resources/css/app.css',
        'resources/js/app.js',
    ]);
```

### Configuración de Base de Datos

```php
return $panel
    ->databaseNotifications()                   // Habilitar notificaciones de BD
    ->databaseNotificationsPolling('30s')      // Polling de notificaciones
    ->databaseNotificationsPollingInterval(30); // Intervalo de polling en segundos
```

### Configuración de Archivos

```php
return $panel
    ->defaultFileUploadDisk('public')          // Disco por defecto para uploads
    ->defaultFileUploadVisibility('public')    // Visibilidad por defecto
    ->fileUploadMaxSize(10240)                 // Tamaño máximo de archivo en KB
    ->fileUploadAllowedExtensions(['jpg', 'png', 'pdf']); // Extensiones permitidas
```

---

## Configuración Avanzada

### Configuración de Plugins

```php
use BezhanSalleh\FilamentShield\FilamentShieldPlugin;

return $panel
    ->plugins([
        FilamentShieldPlugin::make(),
        \App\Filament\Plugins\CustomPlugin::make(),
    ]);
```

### Configuración de Modo SPA

```php
return $panel
    ->spa()                                    // Modo Single Page Application
    ->spaUrl('/admin')                         // URL base para SPA
    ->spaRoutePrefix('admin');                 // Prefijo de rutas SPA
```

### Configuración de Tenants (Multi-tenancy)

```php
return $panel
    ->tenant(\App\Models\Organization::class)
    ->tenantMiddleware([
        \App\Http\Middleware\EnsureUserBelongsToTenant::class,
    ], isPersistent: true)
    ->tenantOwnershipRelationshipName('organization');
```

### Configuración de Global Search

```php
return $panel
    ->globalSearchKeyBindings(['command+k', 'ctrl+k'])
    ->globalSearchDefaultResultLimit(10)
    ->globalSearchDebounce(300);
```

### Configuración de Notificaciones

```php
return $panel
    ->notifications([
        'database' => [
            'polling' => '30s',
        ],
        'broadcast' => [
            'echo' => [
                'broadcaster' => 'pusher',
                'key' => env('VITE_PUSHER_APP_KEY'),
                'cluster' => env('VITE_PUSHER_APP_CLUSTER'),
                'forceTLS' => true,
            ],
        ],
    ]);
```

### Configuración de Breadcrumbs

```php
return $panel
    ->breadcrumbs([
        'Dashboard' => '/admin',
        'Users' => '/admin/users',
    ])
    ->breadcrumbsSeparator('>')
    ->breadcrumbsTrailingSeparator(false);
```

---

## Ejemplo Completo de Configuración

```php
<?php

namespace App\Providers\Filament;

use Filament\Http\Middleware\Authenticate;
use Filament\Http\Middleware\DisableBladeIconComponents;
use Filament\Http\Middleware\DispatchServingFilamentEvent;
use Filament\Pages;
use Filament\Panel;
use Filament\PanelProvider;
use Filament\Support\Colors\Color;
use Filament\Support\Enums\MaxWidth;
use Filament\Widgets;
use Illuminate\Cookie\Middleware\AddQueuedCookiesToResponse;
use Illuminate\Cookie\Middleware\EncryptCookies;
use Illuminate\Foundation\Http\Middleware\VerifyCsrfToken;
use Illuminate\Routing\Middleware\SubstituteBindings;
use Illuminate\Session\Middleware\StartSession;
use Illuminate\View\Middleware\ShareErrorsFromSession;

class AdminPanelProvider extends PanelProvider
{
    public function panel(Panel $panel): Panel
    {
        return $panel
            ->default()
            ->id('admin')
            ->path('admin')
            ->login()
            ->registration()
            ->passwordReset()
            ->emailVerification()
            ->profile()
            ->colors([
                'primary' => Color::Amber,
            ])
            ->discoverResources(in: app_path('Filament/Resources'), for: 'App\\Filament\\Resources')
            ->discoverPages(in: app_path('Filament/Pages'), for: 'App\\Filament\\Pages')
            ->pages([
                Pages\Dashboard::class,
            ])
            ->discoverWidgets(in: app_path('Filament/Widgets'), for: 'App\\Filament\\Widgets')
            ->widgets([
                Widgets\AccountWidget::class,
                Widgets\FilamentInfoWidget::class,
            ])
            ->middleware([
                EncryptCookies::class,
                AddQueuedCookiesToResponse::class,
                StartSession::class,
                ShareErrorsFromSession::class,
                VerifyCsrfToken::class,
                SubstituteBindings::class,
                DisableBladeIconComponents::class,
                DispatchServingFilamentEvent::class,
            ])
            ->authMiddleware([
                Authenticate::class,
            ])
            ->brandName('Mi Aplicación')
            ->brandLogo(asset('images/logo.png'))
            ->favicon(asset('images/favicon.ico'))
            ->maxContentWidth(MaxWidth::SevenExtraLarge)
            ->sidebarCollapsibleOnDesktop()
            ->topNavigation()
            ->databaseNotifications()
            ->globalSearchKeyBindings(['command+k', 'ctrl+k']);
    }
}
```

---

## Notas Importantes

1. **Orden de Configuración**: El orden de las opciones puede afectar el comportamiento del panel.
2. **Compatibilidad**: Algunas opciones pueden no ser compatibles entre sí.
3. **Rendimiento**: Configurar demasiadas opciones puede afectar el rendimiento.
4. **Caché**: Después de cambiar la configuración, limpia la caché de la aplicación.
5. **Documentación**: Consulta siempre la documentación oficial de Filament para las últimas actualizaciones.

---

## Referencias

-   [Documentación Oficial de Filament](https://filamentphp.com/docs)
-   [Configuración de Paneles](https://filamentphp.com/docs/3.x/panels/configuration)
-   [Personalización de Temas](https://filamentphp.com/docs/3.x/support/themes)
-   [Middleware y Seguridad](https://filamentphp.com/docs/3.x/panels/authentication)
