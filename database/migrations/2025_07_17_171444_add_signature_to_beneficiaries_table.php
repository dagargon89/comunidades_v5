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
        Schema::table('beneficiary_registries', function (Blueprint $table) {
            $table->text('signature')->nullable()->after('data_collectors_id');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('beneficiary_registries', function (Blueprint $table) {
            $table->dropColumn('signature');
        });
    }
};
