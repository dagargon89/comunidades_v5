<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            if (!Schema::hasColumn('users', 'can_publish_data')) {
                $table->boolean('can_publish_data')->default(0)->after('org_area');
            }
            if (!Schema::hasColumn('users', 'last_publication_access')) {
                $table->timestamp('last_publication_access')->nullable()->after('can_publish_data');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            if (Schema::hasColumn('users', 'can_publish_data')) {
                $table->dropColumn('can_publish_data');
            }
            if (Schema::hasColumn('users', 'last_publication_access')) {
                $table->dropColumn('last_publication_access');
            }
        });
    }
};
