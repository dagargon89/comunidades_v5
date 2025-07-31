<?php

namespace App\Filament\Usuario\Widgets;

use Filament\Tables;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget as BaseWidget;
use App\Models\ActivityCalendar;
use App\Models\Project;
use App\Models\User;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Filters\Filter;
use Filament\Forms\Components\DatePicker;
use Illuminate\Support\Facades\Auth;
use BezhanSalleh\FilamentShield\Traits\HasWidgetShield;
class ActivityCalendarTable extends BaseWidget
{
    // use HasWidgetShield;

    protected static ?string $heading = 'Actividades Calendarizadas';

    protected static ?int $sort = 2;

    protected int|string|array $columnSpan = 'full';

    protected static bool $isLazy = false;

    public function table(Table $table): Table
    {
        $userId = Auth::id();

        // Query base
        $query = ActivityCalendar::query()
            ->with(['activity', 'activity.goal'])
            ->where('assigned_person', $userId);

        return $table
            ->query($query)
            ->columns([
                Tables\Columns\TextColumn::make('activity.name')
                    ->label('Actividad')
                    ->searchable()
                    ->sortable()
                    ->limit(50),
                Tables\Columns\TextColumn::make('start_date')
                    ->label('Fecha de inicio')
                    ->date('d/m/Y')
                    ->sortable(),
                Tables\Columns\TextColumn::make('end_date')
                    ->label('Fecha de fin')
                    ->date('d/m/Y')
                    ->sortable(),
                Tables\Columns\TextColumn::make('start_hour')
                    ->label('Hora inicio')
                    ->sortable(),
                Tables\Columns\TextColumn::make('end_hour')
                    ->label('Hora fin')
                    ->sortable(),
                Tables\Columns\TextColumn::make('cancelled')
                    ->label('Estado')
                    ->formatStateUsing(fn($state) => $state ? 'Cancelada' : 'Activa')
                    ->color(fn($state) => $state ? 'danger' : 'success')
                    ->sortable(),
            ])
            ->filters([
                SelectFilter::make('project')
                    ->label('Proyecto')
                    ->relationship('activity.goal.project', 'name')
                    ->searchable()
                    ->preload(),
                SelectFilter::make('cancelled')
                    ->label('Estado')
                    ->options([
                        0 => 'Activa',
                        1 => 'Cancelada',
                    ])
                    ->default(0),
                Filter::make('date_range')
                    ->label('Rango de fechas')
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
                                fn ($query, $date) => $query->where('start_date', '>=', $date)
                            )
                            ->when(
                                $data['end_date'],
                                fn ($query, $date) => $query->where('end_date', '<=', $date)
                            );
                    }),
            ])
            ->defaultSort('start_date', 'asc')
            ->paginated([10, 25, 50]);
    }
}
