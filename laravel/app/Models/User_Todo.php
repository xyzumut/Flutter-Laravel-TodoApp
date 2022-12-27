<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class User_Todo extends Model
{
    use HasFactory;
    protected $table = 'user_todo';
    protected $fillable = ['user_id', 'todo_id'];
    public $timestamps = false;
}
