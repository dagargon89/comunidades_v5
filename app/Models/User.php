<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Spatie\Permission\Traits\HasRoles;
use Filament\Models\Contracts\FilamentUser;
use Filament\Panel;

class User extends Authenticatable implements FilamentUser
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasFactory, Notifiable, HasRoles;

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'point_of_contact_id',
        'phone',
        'org_role',
        'organizations_id',
        'org_area',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    /**
     * Get the point of contact for this user.
     */
    public function pointOfContact(): BelongsTo
    {
        return $this->belongsTo(User::class, 'point_of_contact_id');
    }

    /**
     * Get the users that have this user as their point of contact.
     */
    public function subordinates(): HasMany
    {
        return $this->hasMany(User::class, 'point_of_contact_id');
    }

    /**
     * Get the organization that this user belongs to.
     */
    public function organization(): BelongsTo
    {
        return $this->belongsTo(Organization::class, 'organizations_id');
    }

    /**
     * Get the activities created by this user.
     */
    public function activities(): HasMany
    {
        return $this->hasMany(Activity::class, 'created_by');
    }

    /**
     * Get the projects created by this user.
     */
    public function projectsCreados(): HasMany
    {
        return $this->hasMany(Project::class, 'created_by');
    }

    /**
     * Get the beneficiaries created by this user.
     */
    public function beneficiariesCreados(): HasMany
    {
        return $this->hasMany(Beneficiary::class, 'created_by');
    }

    public function canAccessPanel(Panel $panel): bool
    {
        // Panel Admin - solo admin y super_admin
        if ($panel->getId() === 'admin') {
            return $this->hasAnyRole(['admin', 'super_admin']);
        }

        // Panel Usuario - solo capturista y responsable
        if ($panel->getId() === 'usuario') {
            return $this->hasAnyRole(['capturista', 'responsable']);
        }

        // Por defecto, denegar acceso
        return false;
    }
}
