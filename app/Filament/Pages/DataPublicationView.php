<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use App\Models\DataPublication;
use App\Models\User;
use App\Services\DataPublicationService;
use Filament\Forms;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Select;
use Filament\Tables;
use Filament\Tables\Contracts\HasTable;
use Filament\Tables\Concerns\InteractsWithTable;
use Filament\Tables\Actions;
use BezhanSalleh\FilamentShield\Traits\HasPageShield;
use Illuminate\Support\Facades\Auth;
use Filament\Notifications\Notification;

class DataPublicationView extends Page implements HasTable
{
    use InteractsWithTable, HasPageShield;

    protected static ?string $navigationIcon = 'heroicon-o-document-arrow-up';

    protected static string $view = 'filament.pages.data-publication-view';

    protected static ?string $title = 'Publicaciones de Datos';
    protected static ?string $navigationLabel = 'Publicaciones de Datos';
    protected static ?string $modelLabel = 'Publicación de Datos';
    protected static ?string $pluralModelLabel = 'Publicaciones de Datos';
    protected static ?string $slug = 'publicaciones-datos';

    public ?string $notes = null;
    public ?string $period_from = null;
    public ?string $period_to = null;
    public ?int $selected_user_id = null;

    protected $dataPublicationService;

    public function mount(): void
    {
        // Verificar si el usuario actual tiene permisos de publicación
        $currentUser = Auth::user();
        if (!$currentUser || !$currentUser->can_publish_data) {
            Notification::make()
                ->title('Acceso denegado')
                ->body('No tienes permisos para realizar publicaciones de datos.')
                ->danger()
                ->send();

            // Redirigir a la página principal
            $this->redirect('/admin');
        }

        $this->selected_user_id = $currentUser->id;
    }

    public function form(\Filament\Forms\Form $form): \Filament\Forms\Form
    {
        return $form->schema([
            Section::make('Configuración de Publicación')
                ->description('Configura los parámetros para la nueva publicación')
                ->icon('heroicon-o-cog-6-tooth')
                ->schema([
                    Textarea::make('notes')
                        ->label('Notas de la Publicación')
                        ->placeholder('Descripción opcional de la publicación...')
                        ->rows(3)
                        ->maxLength(1000)
                        ->helperText('Describe el propósito o contexto de esta publicación'),

                    DatePicker::make('period_from')
                        ->label('Período Desde (Opcional)')
                        ->helperText('Si se especifica, solo se publicarán métricas desde esta fecha'),

                    DatePicker::make('period_to')
                        ->label('Período Hasta (Opcional)')
                        ->helperText('Si se especifica, solo se publicarán métricas hasta esta fecha')
                        ->after('period_from'),

                    Select::make('selected_user_id')
                        ->label('Usuario que Publica')
                        ->options(function () {
                            return User::where('can_publish_data', 1)
                                ->pluck('name', 'id')
                                ->toArray();
                        })
                        ->default(Auth::id())
                        ->required()
                        ->helperText('Solo usuarios con permisos de publicación'),
                ])
                ->columns(2),
        ]);
    }

    protected function getTableQuery()
    {
        return DataPublication::query()
            ->with('publishedBy')
            ->orderBy('publication_date', 'desc');
    }

    protected function getTableColumns(): array
    {
        return [
            Tables\Columns\TextColumn::make('publication_date')
                ->label('Fecha de Publicación')
                ->dateTime('d/m/Y H:i')
                ->sortable()
                ->searchable(),

            Tables\Columns\TextColumn::make('publishedBy.name')
                ->label('Publicado Por')
                ->sortable()
                ->searchable(),

            Tables\Columns\TextColumn::make('publication_notes')
                ->label('Notas')
                ->limit(50)
                ->searchable(),

            Tables\Columns\TextColumn::make('period_from')
                ->label('Período Desde')
                ->date('d/m/Y')
                ->sortable(),

            Tables\Columns\TextColumn::make('period_to')
                ->label('Período Hasta')
                ->date('d/m/Y')
                ->sortable(),

            Tables\Columns\TextColumn::make('projects_count')
                ->label('Proyectos')
                ->sortable()
                ->badge()
                ->color('success'),

            Tables\Columns\TextColumn::make('activities_count')
                ->label('Actividades')
                ->sortable()
                ->badge()
                ->color('info'),

            Tables\Columns\TextColumn::make('metrics_count')
                ->label('Métricas')
                ->sortable()
                ->badge()
                ->color('warning'),
        ];
    }

    protected function getTableHeaderActions(): array
    {
        return [
            Actions\Action::make('publishData')
                ->label('Nueva Publicación')
                ->icon('heroicon-o-document-arrow-up')
                ->color('success')
                ->form([
                    Section::make('Nueva Publicación de Datos')
                        ->description('Ejecuta una nueva publicación de datos del sistema')
                        ->icon('heroicon-o-document-arrow-up')
                        ->schema([
                            Textarea::make('notes')
                                ->label('Notas de la Publicación')
                                ->placeholder('Descripción opcional de la publicación...')
                                ->rows(3)
                                ->maxLength(1000)
                                ->helperText('Describe el propósito o contexto de esta publicación'),

                            DatePicker::make('period_from')
                                ->label('Período Desde (Opcional)')
                                ->helperText('Si se especifica, solo se publicarán métricas desde esta fecha'),

                            DatePicker::make('period_to')
                                ->label('Período Hasta (Opcional)')
                                ->helperText('Si se especifica, solo se publicarán métricas hasta esta fecha')
                                ->after('period_from'),

                            Select::make('selected_user_id')
                                ->label('Usuario que Publica')
                                ->options(function () {
                                    return User::where('can_publish_data', 1)
                                        ->pluck('name', 'id')
                                        ->toArray();
                                })
                                ->default(Auth::id())
                                ->required()
                                ->helperText('Solo usuarios con permisos de publicación'),
                        ])
                        ->columns(2),
                ])
                ->action(function (array $data) {
                    try {
                        $this->dataPublicationService = app(DataPublicationService::class);

                        $result = $this->dataPublicationService->publishDataSnapshot(
                            $data['selected_user_id'],
                            $data['notes'],
                            $data['period_from'],
                            $data['period_to']
                        );

                        Notification::make()
                            ->title('Publicación completada')
                            ->body("Se publicaron {$result['activities_published']} actividades, {$result['projects_published']} proyectos y {$result['metrics_published']} métricas.")
                            ->success()
                            ->send();

                        // Recargar la tabla
                        $this->resetTable();

                    } catch (\Exception $e) {
                        Notification::make()
                            ->title('Error en la publicación')
                            ->body($e->getMessage())
                            ->danger()
                            ->send();
                    }
                })
                ->requiresConfirmation()
                ->modalHeading('Confirmar Publicación')
                ->modalDescription('¿Estás seguro de que deseas ejecutar una nueva publicación de datos? Esta acción no se puede deshacer.')
                ->modalSubmitActionLabel('Sí, publicar datos')
                ->modalCancelActionLabel('Cancelar'),
        ];
    }

    protected function getTableActions(): array
    {
        return [
            Actions\Action::make('viewDetails')
                ->label('Ver Detalles')
                ->icon('heroicon-o-eye')
                ->url(fn (DataPublication $record): string => route('filament.admin.pages.data-publication-details', ['record' => $record]))
                ->openUrlInNewTab(),

            Actions\Action::make('exportData')
                ->label('Exportar Datos')
                ->icon('heroicon-o-arrow-down-tray')
                ->action(function (DataPublication $record) {
                    // Aquí podrías implementar la exportación de datos
                    Notification::make()
                        ->title('Exportación iniciada')
                        ->body('Los datos de la publicación se están exportando...')
                        ->success()
                        ->send();
                }),
        ];
    }

    protected function getTableFilters(): array
    {
        return [
            Tables\Filters\Filter::make('date_range')
                ->form([
                    DatePicker::make('from_date')
                        ->label('Desde'),
                    DatePicker::make('to_date')
                        ->label('Hasta'),
                ])
                ->query(function ($query, array $data) {
                    return $query
                        ->when(
                            $data['from_date'],
                            fn ($query, $date) => $query->where('publication_date', '>=', $date)
                        )
                        ->when(
                            $data['to_date'],
                            fn ($query, $date) => $query->where('publication_date', '<=', $date)
                        );
                }),

            Tables\Filters\SelectFilter::make('published_by')
                ->label('Publicado Por')
                ->options(function () {
                    return User::where('can_publish_data', 1)
                        ->pluck('name', 'id')
                        ->toArray();
                })
                ->query(function ($query, array $data) {
                    return $query->when(
                        $data['value'],
                        fn ($query, $value) => $query->where('published_by', $value)
                    );
                }),
        ];
    }

    protected function getTableBulkActions(): array
    {
        return [
            Actions\BulkAction::make('exportSelected')
                ->label('Exportar Seleccionados')
                ->icon('heroicon-o-arrow-down-tray')
                ->action(function ($records) {
                    Notification::make()
                        ->title('Exportación masiva')
                        ->body('Se exportarán ' . $records->count() . ' publicaciones seleccionadas.')
                        ->success()
                        ->send();
                }),
        ];
    }

    public function getPublicationStats(): array
    {
        $stats = app(DataPublicationService::class)->getPublicationStats();

        return [
            'total_publications' => $stats['total_publications'] ?? 0,
            'total_projects_published' => $stats['total_projects_published'] ?? 0,
            'total_activities_published' => $stats['total_activities_published'] ?? 0,
            'total_metrics_published' => $stats['total_metrics_published'] ?? 0,
            'last_publication_date' => $stats['last_publication_date'] ?? null,
        ];
    }
}
