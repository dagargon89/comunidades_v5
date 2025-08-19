<?php

namespace App\Providers\Filament;

use Filament\Http\Middleware\Authenticate;
use Filament\Http\Middleware\AuthenticateSession;
use Filament\Http\Middleware\DisableBladeIconComponents;
use Filament\Http\Middleware\DispatchServingFilamentEvent;
use Filament\Pages;
use Filament\Panel;
use Filament\PanelProvider;
use Filament\Support\Colors\Color;
use Filament\Widgets;
use Illuminate\Cookie\Middleware\AddQueuedCookiesToResponse;
use Illuminate\Cookie\Middleware\EncryptCookies;
use Illuminate\Foundation\Http\Middleware\VerifyCsrfToken;
use Illuminate\Routing\Middleware\SubstituteBindings;
use Illuminate\Session\Middleware\StartSession;
use Illuminate\View\Middleware\ShareErrorsFromSession;
use Filament\Support\Enums\MaxWidth;

class FinancieraPanelProvider extends PanelProvider
{
    public function panel(Panel $panel): Panel
    {
        return $panel
            ->id('financiera')
            ->path('financiera')
            ->login()
            ->maxContentWidth(MaxWidth::Full)
            ->topNavigation()
            ->colors([
                'primary' => Color::Blue,
            ])
            ->discoverResources(in: app_path('Filament/Financiera/Resources'), for: 'App\\Filament\\Financiera\\Resources')
            ->discoverPages(in: app_path('Filament/Financiera/Pages'), for: 'App\\Filament\\Financiera\\Pages')
            ->pages([
                \App\Filament\Financiera\Pages\Dashboard::class,
            ])
           // ->discoverWidgets(in: app_path('Filament/Financiera/Widgets'), for: 'App\\Filament\\Financiera\\Widgets')
            ->widgets([
                \App\Filament\Financiera\Widgets\StatsOverview::class,
                \App\Filament\Financiera\Widgets\CostBeneficiaryProject::class,
                \App\Filament\Financiera\Widgets\CostProductProject::class,
                \App\Filament\Financiera\Widgets\PopulationProgressProject::class,
                \App\Filament\Financiera\Widgets\ProductProgressProject::class,
                \App\Filament\Financiera\Widgets\ProjectDetails::class,
            ])
            ->middleware([
                EncryptCookies::class,
                AddQueuedCookiesToResponse::class,
                StartSession::class,
                AuthenticateSession::class,
                ShareErrorsFromSession::class,
                VerifyCsrfToken::class,
                SubstituteBindings::class,
                DisableBladeIconComponents::class,
                DispatchServingFilamentEvent::class,
            ])
            ->authMiddleware([
                Authenticate::class,
            ]);
    }
}
