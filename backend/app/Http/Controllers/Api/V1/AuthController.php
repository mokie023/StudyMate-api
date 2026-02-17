<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;

class AuthController extends Controller
{
    public function register(): JsonResponse
    {
        return response()->json(['message' => 'register scaffold']);
    }

    public function login(): JsonResponse
    {
        return response()->json(['message' => 'login scaffold']);
    }

    public function logout(): JsonResponse
    {
        return response()->json(['message' => 'logout scaffold']);
    }
}
