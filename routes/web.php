<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return response()->json([
        'status' => 'ok',
        'service' => 'StudyMate API',
        'time' => now()->toISOString(),
    ]);
});

// Some platforms request this for metadata; return JSON instead of Blade error
Route::get('/meta.json', function () {
    return response()->json([
        'name' => 'StudyMate API',
        'status' => 'ok',
        'time' => now()->toISOString(),
    ]);
});
