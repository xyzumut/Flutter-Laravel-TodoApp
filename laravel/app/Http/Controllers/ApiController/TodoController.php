<?php

namespace App\Http\Controllers\ApiController;
use App\Http\Controllers\Controller;
use App\Models\Todo;
use App\Models\User;
use App\Models\User_Todo;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\File\Exception\FileNotFoundException;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

class TodoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
       
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        /* todo parametre */
        $item = Todo::create($request->all());
        $pivot = ['user_id'=>$request->user_id, 'todo_id'=>$item['id']];
        User_Todo::create($pivot);
        return response([
            'eklenen_kayit'=>$item,
            'durum'=>true,
        ]);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Todo  $todo
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        return response([
            'durum'=>true,
            'kullanici_verileri'=>User::with('todos')->find($id)
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Todo  $todo
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Todo $todo)
    {
        $todo->update($request->all());
        return response([
            'durum'=>true,
            'guncellenen_kayit'=>$todo
        ]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Todo  $todo
     * @return \Illuminate\Http\Response
     */
    public function destroy(Todo $todo)
    {
        $status = $todo->delete();
        return response([
            'durum'=>$status,
            'silinen_kayit'=>$todo
        ]);
    }
}
