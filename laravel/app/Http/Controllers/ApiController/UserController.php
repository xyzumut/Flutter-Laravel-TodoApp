<?php

namespace App\Http\Controllers\ApiController;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        if (isset($request->purpose) && $request->purpose=='get_user_id') {
            return response([
                'durum'=>true,
                'user_id'=>User::where('name', $request->username)->select('id as user_id')->first()
            ]);
        }
        else if (User::get()->count()>1 && isset($request->username) && isset($request->password)) {
            $tumKullanicilar = User::select('name','password')->get();
            
            $username = $request->username;
            $password = $request->password;
            
            $status = false;
            for ($i=0; $i < count($tumKullanicilar); $i++) { 
                $_name = $tumKullanicilar[$i]['name'];
                $_password = $tumKullanicilar[$i]['password'];
                if ($_name == $username) {
                    if ($_password == $password) {
                        $status = true;
                    }
                    else{
                        break;
                    }
                }
            }
            return response(['durum'=>$status]);
        }
        else{
            return response(['durum'=>false]);
        }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name'=>'required|string|max:50|unique:users',
            'password'=>'required'
        ]);
        if ($validator->fails()) {
            return response([
                'error'=>$validator->errors(),
                'message'=>'Doğrulama hatası',
                'durum'=>false
            ]);
        }
        else{
            $eklenenKullanici = User::create($request->all());
            return response([
                'durum'=>true,
                'eklenen_kullanici'=>$eklenenKullanici
            ]);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\User  $user
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
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, User $user)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function destroy(User $user)
    {
        //
    }

}