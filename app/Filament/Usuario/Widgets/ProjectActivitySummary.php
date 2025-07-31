<?php

namespace App\Filament\Usuario\Widgets;

use Filament\Tables;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget as BaseWidget;
use App\Models\ActivityCalendar;
use App\Models\Project;
use Illuminate\Support\Facades\Auth;
use BezhanSalleh\FilamentShield\Traits\HasWidgetShield;
use Filament\Widgets\Concerns\InteractsWithPageFilters;
use Illuminate\Database\Eloquent\Builder;

class ProjectActivitySummary extends BaseWidget
{
    // use HasWidgetShield;
    use InteractsWithPageFilters;

    protected static ?string $heading = 'Resumen por Proyecto';

    protected static ?int $sort = 7;

    protected int|string|array $columnSpan = 'full';

    protected static bool $isLazy = false;

    public function table(Table $table): Table
    {
        $userId = Auth::id();

        // Obtener filtros del dashboard
        $startDate = $this->filters['startDate'] ?? null;
        $endDate = $this->filters['endDate'] ?? null;
        $projectId = $this->filters['project_id'] ?? null;

        // Query base para obtener proyectos con actividades del usuario
        $query = Project::query()
            ->withCount([
                'goals as total_goals',
            ])
            ->whereHas('goals.activities.activityCalendars', function (Builder $query) use ($userId) {
                $query->where('assigned_person', $userId);
            });

        // Aplicar filtros de fecha
        if ($startDate) {
            $query->whereHas('goals.activities.activityCalendars', function (Builder $q) use ($startDate) {
                $q->where('start_date', '>=', $startDate);
            });
        }
        if ($endDate) {
            $query->whereHas('goals.activities.activityCalendars', function (Builder $q) use ($endDate) {
                $q->where('end_date', '<=', $endDate);
            });
        }

        // Aplicar filtro de proyecto específico
        if ($projectId) {
            $query->where('id', $projectId);
        }

        return $table
            ->query($query)
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->label('Proyecto')
                    ->searchable()
                    ->sortable()
                    ->weight('bold'),
                Tables\Columns\TextColumn::make('start_date')
                    ->label('Fecha de inicio')
                    ->date('d/m/Y')
                    ->sortable(),
                Tables\Columns\TextColumn::make('end_date')
                    ->label('Fecha de fin')
                    ->date('d/m/Y')
                    ->sortable(),
                Tables\Columns\TextColumn::make('total_goals_count')
                    ->label('Total Metas')
                    ->sortable()
                    ->color('primary'),
                Tables\Columns\TextColumn::make('activities_summary')
                    ->label('Resumen de Actividades')
                    ->formatStateUsing(function ($record) use ($userId) {
                        $query = \App\Models\ActivityCalendar::whereHas('activity.goal.project', function ($q) use ($record) {
                            $q->where('id', $record->id);
                        })->where('assigned_person', $userId);

                        $totalActivities = $query->count();
                        $activeActivities = (clone $query)->where('cancelled', 0)->count();
                        $cancelledActivities = (clone $query)->where('cancelled', 1)->count();

                        return "Total: {$totalActivities} | Activas: {$activeActivities} | Canceladas: {$cancelledActivities}";
                    })
                    ->color('info'),
                Tables\Columns\TextColumn::make('progress')
                    ->label('Progreso')
                    ->formatStateUsing(function ($record) use ($userId) {
                        $query = \App\Models\ActivityCalendar::whereHas('activity.goal.project', function ($q) use ($record) {
                            $q->where('id', $record->id);
                        })->where('assigned_person', $userId);

                        $totalActivities = $query->count();
                        $activeActivities = (clone $query)->where('cancelled', 0)->count();

                        if ($totalActivities == 0) return '0%';
                        $percentage = round(($activeActivities / $totalActivities) * 100);
                        return $percentage . '%';
                    })
                    ->color(function ($record) use ($userId) {
                        $query = \App\Models\ActivityCalendar::whereHas('activity.goal.project', function ($q) use ($record) {
                            $q->where('id', $record->id);
                        })->where('assigned_person', $userId);

                        $totalActivities = $query->count();
                        $activeActivities = (clone $query)->where('cancelled', 0)->count();

                        if ($totalActivities == 0) return 'gray';
                        $percentage = ($activeActivities / $totalActivities) * 100;
                        if ($percentage >= 80) return 'success';
                        if ($percentage >= 50) return 'warning';
                        return 'danger';
                    }),
            ])
            ->defaultSort('name', 'asc')
            ->paginated([5, 10, 15]);
    }
}
