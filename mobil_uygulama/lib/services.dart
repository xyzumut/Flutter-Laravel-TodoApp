import 'package:dio/dio.dart';

Future<bool> LoginApi(String username, String password) async {
  var dio = Dio();
  var res = null;
  res = (await dio.get(
      'http://10.0.2.2:8000/api/user?username=${username}&password=${password}',
      options: Options(contentType: 'application/json')));
  if (res.data['durum'] == true) {
    return true;
  } else {
    return false;
  }
}

Future<Map<String, dynamic>> PostTodoApi(String todo, int user_id) async {
  var dio = Dio();
  Map<String, dynamic> data = {'durum': false, 'id': -1};
  var res = null;
  res = (await dio.post('http://10.0.2.2:8000/api/todo',
      data: {'todo': todo, 'user_id': user_id},
      options: Options(contentType: 'application/json')));
  if (res.data['durum'] == true) {
    data['durum'] = res.data['durum'];
    data['eklenen_kayit'] = res.data['eklenen_kayit'];
    return data;
  } else {
    return data;
  }
}

Future<Map<String, dynamic>> getUsersTodosApi(int user_id) async {
  var dio = Dio();
  Map<String, dynamic> data = {
    'id': null,
    'name': null,
    'todos': <List<Map<String, dynamic>>>[],
    'durum': false
  };
  var res = null;
  res = (await dio.get('http://10.0.2.2:8000/api/user/$user_id',
      options: Options(contentType: 'application/json')));
  data['id'] = res.data['kullanici_verileri']['id'];
  data['name'] = res.data['kullanici_verileri']['name'];
  data['todos'] = res.data['kullanici_verileri']['todos'];
  return data;
}

Future<bool> TodoDeleteApi(int todo_id) async {
  var dio = Dio();
  var res = null;
  res = (await dio.delete('http://10.0.2.2:8000/api/todo/$todo_id',
      options: Options(contentType: 'application/json')));
  if (res.data['durum'] == true) {
    return true;
  } else {
    return false;
  }
}

Future<int> getUserIdApi(String username) async {
  var dio = Dio();
  var res = null;
  res = (await dio.get(
      'http://10.0.2.2:8000/api/user?username=${username}&purpose=get_user_id',
      options: Options(contentType: 'application/json')));
  if (res.data['durum'] == true) {
    return res.data['user_id']['user_id'];
  } else {
    return -1;
  }
}