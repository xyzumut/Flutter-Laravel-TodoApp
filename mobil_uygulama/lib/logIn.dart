import 'package:flutter/material.dart';
import 'package:mobil_uygulama/background2.dart';
import 'package:mobil_uygulama/services.dart';
import 'package:mobil_uygulama/to_do_app.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class logIn extends StatefulWidget {
  const logIn({super.key});

  @override
  State<logIn> createState() => _logInState();
}

class _logInState extends State<logIn> {

  // Stateler /***************************************/

  String _password = '', _userName = '';
  final _formKey = GlobalKey<FormState>();

  // Stateler /***************************************/



  // Metotlar /***************************************/

  void _alertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hata'),
          content:
              SingleChildScrollView(child: Text('Kullanıcı veya Şifre Hatalı')),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Kapat')),
          ],
        );
      },
    );
  }

  // Metotlar /***************************************/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Background2(
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 60,
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'GİRİŞ YAP',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(234, 97, 109, 217),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Form(
                key: _formKey,
                //imleç üzerine tıklandığı anda error verecek(karakter sayısı vb.)
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: TextFormField(
                        /*initialvalue=otomatik olarak girdiğimiz değer geliyor*/
                        // initialValue: 'ZeynepAydın',
                        maxLength: 20,
                        decoration: const InputDecoration(
                            errorStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18.0),
                              ),
                            ),
                            labelText: 'Kullanıcı Adı',
                            ),
                        //autovalidation mode u aktif edip ekrana uyarı verdik
                        validator: (deger) {
                          if (deger!.length < 4) {
                            return 'Kullanıcı adı en az 4 karakter olmalı!';
                          } else {
                            return null;
                          }
                        },
                        //verileri kaydedicez
                        onSaved: (userName) {
                          _userName = userName!;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: TextFormField(
                        //şifreyi gizlememizi sağlıyor
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18.0))),
                          labelText: 'Şifre',
                        ),
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Şifre en az 6 karakterli olmalı!';
                          } else
                            return null;
                        },
                        onSaved: (password) {
                          _password = password!;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        bool status = false;
                        bool _validate = _formKey.currentState!.validate();
                        if (_validate) {
                          _formKey.currentState!.save();
                          /* */
                          status = await LoginApi(_userName, _password);
                          debugPrint('Login Denemesi ' + status.toString());
                          /* */
                          String result =
                              'username:$_userName,password:$_password';
                        }
                        if (status) {
                          EasyLoading.showSuccess('Hoşgeldin ${_userName}',
                              duration: Duration(milliseconds: 1000),
                              dismissOnTap: true);
                          Future.delayed(
                            Duration(milliseconds: 1100),
                            () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => toDoApp(username: _userName),
                              ));
                            },
                          );
                        } else {
                          _alertDialog();
                        }
                      },
                      child: Text('GİRİŞ YAP'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xEA616DD9)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    width: 250,
                    height: 180,
                    child: Image.asset('assets/images/erkek.jpg')),
              ),
            ]),
          ),
        ));
  }

  
}