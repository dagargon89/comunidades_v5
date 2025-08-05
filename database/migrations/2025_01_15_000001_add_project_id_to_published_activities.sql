< ? php

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
        Schema::table('published_activities', function (Blueprint $table) {
            $table->unsignedBigInteger('project_id')->after('original_activity_id')->nullable();

/
/
Agregar índice para mejorar performance
            $table->index(['publication_id', 'project_id'], 'idx_published_activities_project');

});

}

/**
 * Reverse the migrations.
 */
public function down(): void
    {
        Schema::table('published_activities', function (Blueprint $table) {
            $table->dropIndex('idx_published_activities_project');

$table -> dropColumn ('project_id');

});

} };
