<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTasksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
{
    Schema::create('tasks', function (Blueprint $table) {
        $table->id(); // Primary Key
        $table->string('title'); // The task name
        $table->text('description')->nullable(); // Optional details
        $table->enum('status', ['pending', 'completed'])->default('pending'); // Track progress
        
        // Links the task to the 'users' table and deletes it if the user is deleted
        $table->foreignId('user_id')->constrained()->onDelete('cascade'); 
        
        $table->timestamps(); // Created_at and updated_at columns
    });
}

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('tasks');
    }
}
