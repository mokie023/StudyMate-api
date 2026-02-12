<?php

use Illuminate\Support\Facades\Route;

Route::get('/health', function () {
    return response()->json([
        'status' => 'ok',
        'service' => 'StudyMate API',
        'time' => now()->toISOString(),
    ]);
});
