<?php

namespace App\Filament\Usuario\Widgets;

use Filament\Tables;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget as BaseWidget;
use App\Models\ActivityFile;
use App\Models\ActivityCalendar;
use App\Models\Activity;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Filters\Filter;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\TextInput;
use Illuminate\Support\Facades\Auth;
use BezhanSalleh\FilamentShield\Traits\HasWidgetShield;
use Filament\Widgets\Concerns\InteractsWithPageFilters;
use Illuminate\Database\Eloquent\Builder;

class ActivityFileTable extends BaseWidget
{
    // use HasWidgetShield;
    use InteractsWithPageFilters;

    protected static ?string $heading = 'Archivos de Actividades';

    protected static ?int $sort = 5;

    protected int|string|array $columnSpan = 'full';

    protected static bool $isLazy = false;

    public function table(Table $table): Table
    {
        $userId = Auth::id();

        // Obtener filtros del dashboard
        $startDate = $this->filters['startDate'] ?? null;
        $endDate = $this->filters['endDate'] ?? null;
        $projectId = $this->filters['project_id'] ?? null;

        // Obtener las actividades calendarizadas del usuario con filtros
        $activityQuery = ActivityCalendar::where('assigned_person', $userId);

        // Aplicar filtros de fecha
        if ($startDate) {
            $activityQuery->where('start_date', '>=', $startDate);
        }
        if ($endDate) {
            $activityQuery->where('end_date', '<=', $endDate);
        }

        // Aplicar filtro de proyecto
        if ($projectId) {
            $activityQuery->whereHas('activity.goal', function (Builder $q) use ($projectId) {
                $q->where('project_id', $projectId);
            });
        }

        $userActivityIds = $activityQuery->pluck('id')->toArray();

        return $table
            ->query(ActivityFile::query()
                ->with(['activityCalendar', 'activityCalendar.activity'])
                ->whereIn('activity_calendar_id', $userActivityIds)
            )
            ->columns([
                Tables\Columns\TextColumn::make('activityCalendar.activity.name')
                    ->label('Actividad')
                    ->searchable()
                    ->sortable()
                    ->limit(50),
                Tables\Columns\TextColumn::make('file_path')
                    ->label('Archivo')
                    ->searchable()
                    ->limit(30),
                Tables\Columns\TextColumn::make('month')
                    ->label('Mes')
                    ->sortable(),
                Tables\Columns\TextColumn::make('type')
                    ->label('Tipo')
                    ->sortable(),
                Tables\Columns\TextColumn::make('upload_date')
                    ->label('Fecha de subida')
                    ->dateTime('d/m/Y H:i')
                    ->sortable(),
                Tables\Columns\TextColumn::make('created_at')
                    ->label('Creado')
                    ->dateTime('d/m/Y H:i')
                    ->sortable(),
            ])
            ->filters([
                SelectFilter::make('activity_id')
                    ->label('Actividad')
                    ->options(function () use ($userId) {
                        $activityIds = ActivityCalendar::where('assigned_person', $userId)
                            ->pluck('activity_id')
                            ->unique();
                        return Activity::whereIn('id', $activityIds)
                            ->pluck('name', 'id')
                            ->toArray();
                    })
                    ->query(function ($query, array $data) {
                        if (!empty($data['activity_id'])) {
                            $query->whereHas('activityCalendar', function ($q) use ($data) {
                                $q->where('activity_id', $data['activity_id']);
                            });
                        }
                    }),
                SelectFilter::make('type')
                    ->label('Tipo de archivo')
                    ->options(function () use ($userActivityIds) {
                        return ActivityFile::whereIn('activity_calendar_id', $userActivityIds)
                            ->whereNotNull('type')
                            ->distinct()
                            ->pluck('type', 'type')
                            ->toArray();
                    }),
                Filter::make('upload_date_range')
                    ->label('Rango de fechas de subida')
                    ->form([
                        DatePicker::make('start_date')
                            ->label('Fecha de inicio'),
                        DatePicker::make('end_date')
                            ->label('Fecha de fin'),
                    ])
                    ->query(function ($query, array $data) {
                        return $query
                            ->when(
                                $data['start_date'],
                                fn ($query, $date) => $query->where('upload_date', '>=', $date)
                            )
                            ->when(
                                $data['end_date'],
                                fn ($query, $date) => $query->where('upload_date', '<=', $date)
                            );
                    }),
                Filter::make('file_search')
                    ->label('Buscar archivo')
                    ->form([
                        TextInput::make('file_name')
                            ->label('Nombre del archivo')
                            ->placeholder('Buscar por nombre...'),
                    ])
                    ->query(function ($query, array $data) {
                        if (!empty($data['file_name'])) {
                            $query->where('file_path', 'like', '%' . $data['file_name'] . '%');
                        }
                    }),
            ])
            ->defaultSort('upload_date', 'desc')
            ->paginated([10, 25, 50]);
    }
}
