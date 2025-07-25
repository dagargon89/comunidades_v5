<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Tables\Actions\Action as TableAction;
use App\Models\ActivityCalendar;
use App\Models\Project;
use App\Models\Activity;
use App\Models\User;
use Filament\Tables\Filters\SelectFilter;

class ProjectGanttView extends Page implements Tables\Contracts\HasTable
{
    use Tables\Concerns\InteractsWithTable;

    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static string $view = 'filament.pages.project-gantt-view';

    public function table(Table $table): Table
    {
        return $table
            ->query(ActivityCalendar::query()->with(['activity.goal']))
            ->columns([
                Tables\Columns\TextColumn::make('activity.name')->label('Actividad')->searchable(),
                Tables\Columns\TextColumn::make('assigned_person')
                    ->label('Encargado')
                    ->formatStateUsing(fn($state) => User::find($state)?->name ?? '-')
                    ->searchable(),
                Tables\Columns\TextColumn::make('start_date')->label('Fecha de inicio')->date('d/m/Y'),
                Tables\Columns\TextColumn::make('end_date')->label('Fecha de fin')->date('d/m/Y'),
            ])
            ->filters([
                SelectFilter::make('project_id')
                    ->label('Proyecto')
                    ->options(Project::pluck('name', 'id')->toArray())
                    ->query(function ($query, array $data) {
                        if (!empty($data['project_id'])) {
                            $query->whereHas('activity.goal', function ($q) use ($data) {
                                $q->where('project_id', $data['project_id']);
                            });
                        }
                    }),
            ])
            ->headerActions([
                TableAction::make('programar')
                    ->label('Programar actividad')
                    ->icon('heroicon-o-plus')
                    ->color('primary')
                    ->url(fn() => url('/admin/activity-calendar-view')),
            ]);
    }
}
