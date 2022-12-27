<?php

use App\Http\Controllers\ApiController\TodoController;
use App\Http\Controllers\ApiController\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


Route::apiResources([
    'todo'=>TodoController::class,
    'user'=>UserController::class,
]);

Route::get('/user/get_id', [UserController::class, 'get_user_id']);