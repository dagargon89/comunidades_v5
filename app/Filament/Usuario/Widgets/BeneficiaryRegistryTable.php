<?php

namespace App\Filament\Usuario\Widgets;

use Filament\Tables;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget as BaseWidget;
use App\Models\BeneficiaryRegistry;
use App\Models\ActivityCalendar;
use App\Models\Activity;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Filters\Filter;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Select;
use Illuminate\Support\Facades\Auth;
use BezhanSalleh\FilamentShield\Traits\HasWidgetShield;
use Filament\Widgets\Concerns\InteractsWithPageFilters;
use Illuminate\Database\Eloquent\Builder;

class BeneficiaryRegistryTable extends BaseWidget
{
    // use HasWidgetShield;
    use InteractsWithPageFilters;

    protected static ?string $heading = 'Registros de Beneficiarios';

    protected static ?int $sort = 6;

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
            ->query(BeneficiaryRegistry::query()
                ->with(['beneficiaries', 'activityCalendar', 'activityCalendar.activity'])
                ->whereIn('activity_calendar_id', $userActivityIds)
            )
            ->columns([
                Tables\Columns\TextColumn::make('beneficiaries.identifier')
                    ->label('Identificador')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('beneficiaries.last_name')
                    ->label('Apellido Paterno')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('beneficiaries.mother_last_name')
                    ->label('Apellido Materno')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('beneficiaries.first_names')
                    ->label('Nombres')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('beneficiaries.birth_year')
                    ->label('Año Nacimiento')
                    ->sortable(),
                Tables\Columns\TextColumn::make('beneficiaries.gender')
                    ->label('Género')
                    ->formatStateUsing(fn ($state) => match ($state) {
                        'M' => 'Masculino',
                        'F' => 'Femenino',
                        default => $state,
                    })
                    ->sortable(),
                Tables\Columns\TextColumn::make('activityCalendar.activity.name')
                    ->label('Actividad')
                    ->searchable()
                    ->sortable()
                    ->limit(30),
                Tables\Columns\TextColumn::make('created_at')
                    ->label('Registrado el')
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
                SelectFilter::make('gender')
                    ->label('Género')
                    ->options([
                        'M' => 'Masculino',
                        'F' => 'Femenino',
                    ])
                    ->query(function ($query, array $data) {
                        if (!empty($data['gender'])) {
                            $query->whereHas('beneficiaries', function ($q) use ($data) {
                                $q->where('gender', $data['gender']);
                            });
                        }
                    }),
                Filter::make('birth_year_range')
                    ->label('Rango de año de nacimiento')
                    ->form([
                        TextInput::make('start_year')
                            ->label('Año de inicio')
                            ->numeric()
                            ->placeholder('Ej: 1980'),
                        TextInput::make('end_year')
                            ->label('Año de fin')
                            ->numeric()
                            ->placeholder('Ej: 2000'),
                    ])
                    ->query(function ($query, array $data) {
                        return $query
                            ->when(
                                $data['start_year'],
                                fn ($query, $year) => $query->whereHas('beneficiaries', function ($q) use ($year) {
                                    $q->where('birth_year', '>=', $year);
                                })
                            )
                            ->when(
                                $data['end_year'],
                                fn ($query, $year) => $query->whereHas('beneficiaries', function ($q) use ($year) {
                                    $q->where('birth_year', '<=', $year);
                                })
                            );
                    }),
                Filter::make('registration_date_range')
                    ->label('Rango de fechas de registro')
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
                                fn ($query, $date) => $query->where('created_at', '>=', $date)
                            )
                            ->when(
                                $data['end_date'],
                                fn ($query, $date) => $query->where('created_at', '<=', $date)
                            );
                    }),
                Filter::make('beneficiary_search')
                    ->label('Buscar beneficiario')
                    ->form([
                        TextInput::make('search_term')
                            ->label('Término de búsqueda')
                            ->placeholder('Nombre, apellido o identificador...'),
                    ])
                    ->query(function ($query, array $data) {
                        if (!empty($data['search_term'])) {
                            $searchTerm = $data['search_term'];
                            $query->whereHas('beneficiaries', function ($q) use ($searchTerm) {
                                $q->where(function ($subQuery) use ($searchTerm) {
                                    $subQuery->where('identifier', 'like', "%{$searchTerm}%")
                                             ->orWhere('first_names', 'like', "%{$searchTerm}%")
                                             ->orWhere('last_name', 'like', "%{$searchTerm}%")
                                             ->orWhere('mother_last_name', 'like', "%{$searchTerm}%");
                                });
                            });
                        }
                    }),
            ])
            ->defaultSort('created_at', 'desc')
            ->paginated([10, 25, 50]);
    }
}
