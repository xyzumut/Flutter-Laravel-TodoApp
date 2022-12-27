import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobil_uygulama/services.dart';

class toDoApp extends StatefulWidget {

  toDoApp({super.key, required this.username});
  late String username;// Loginden Gelen Username

  @override
  State<toDoApp> createState() => _toDoAppState(username: username);
}

class _toDoAppState extends State<toDoApp> {
  _toDoAppState({required this.username});

  // Stateler /***************************************/

  late String username;
  var items = [];
  int user_id = 0;
  bool user_id_loader = true;
  bool loader = true;
  
  // Stateler /***************************************/




  // Metotlar /***************************************/

  void getAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Todo Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Positioned(
                child: TextField(
                  maxLength: 100,
                  textInputAction: TextInputAction.done,
                  maxLines: 2,
                  onSubmitted: (String value) async {
                    debugPrint(value);
                    var res = await PostTodoApi(value, user_id);
                    setState(() {
                      items = items.reversed.toList();
                      items.add({'todo': res['eklenen_kayit']['todo'], 'id':res['eklenen_kayit']['id']});
                      items = items.reversed.toList();
                      user_id_loader = true;
                      loader = true;
                      debugPrint(items.toString());
                      if (res['durum']) {
                        loader = false;
                        EasyLoading.showSuccess('Todo Eklendi',
                            duration: const Duration(milliseconds: 500),
                            dismissOnTap: true);
                      }
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Kapat')),
          ],
        );
      },
    );
  }

  void getTodos(int id) async {
    var response = await getUsersTodosApi(id);
    debugPrint(response['todos'].length.toString());
    var responseItems = response['todos'];
    setState(() {
      items = responseItems;
      items = items.reversed.toList();
      loader = false;
      user_id = response['id'];
    });
  }

  void getUserId(String username) async {
    int id = await getUserIdApi(username);
    setState(() {
      user_id = id;
      user_id_loader = false;
    });
  }

  // Metotlar /***************************************/
  
  
  @override
  Widget build(BuildContext context) {
    if (user_id_loader) {
      getUserId(username);
    } else if (loader == true) {
      getTodos(user_id);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('$username\'in Notlari'),
        backgroundColor: Color.fromARGB(234, 108, 120, 221),
      ),
      body: loader
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                            color: Color.fromARGB(234, 108, 120, 221))),
                    child: Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(
                              Icons.delete,
                              size: 40,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                      onDismissed: (direction) async {
                        debugPrint(items[index]['id'].toString());
                        bool status = await TodoDeleteApi(items[index]['id']);
                        if (status) {
                          setState(() {
                            items.removeAt(index);
                          });
                          EasyLoading.showSuccess('Todo Silindi',
                              duration: const Duration(milliseconds: 500),
                              dismissOnTap: true);
                        }
                      },
                      key: UniqueKey(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(18),
                            child: Text('${items[index]['todo']}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(234, 108, 120, 221),
        onPressed: () {
          debugPrint(context.toString());
          getAlertDialog(context);
        },
      ),
    );
  }
}