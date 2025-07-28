<?php

namespace App\Filament\Widgets;

use App\Models\User;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget as BaseWidget;

class RecentProjects extends BaseWidget
{
    protected static ?int $sort = 2;
    protected int | string | array $columnSpan = 'full';

    protected static ?string $heading = 'Usuarios Recientes';

    public function table(Table $table): Table
    {
        $query = User::query()
            ->latest()
            ->limit(10);

        return $table
            ->query($query)
            ->columns([
                Tables\Columns\TextColumn::make('name')
                    ->label('Nombre')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('email')
                    ->label('Email')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Registrado')
                    ->dateTime('d/m/Y H:i')
                    ->sortable(),

                Tables\Columns\TextColumn::make('email_verified_at')
                    ->label('Estado')
                    ->getStateUsing(function (User $record): string {
                        return $record->email_verified_at ? 'Verificado' : 'Pendiente';
                    })
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'Verificado' => 'success',
                        'Pendiente' => 'warning',
                        default => 'gray',
                    }),
            ])
            ->actions([
                Tables\Actions\Action::make('view')
                    ->label('Ver')
                    ->icon('heroicon-m-eye')
                    ->url(fn (User $record): string => route('filament.admin.resources.usuarios.edit', ['record' => $record]))
                    ->color('primary'),
            ])
            ->paginated(false);
    }
}
