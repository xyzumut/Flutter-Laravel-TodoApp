import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mobil_uygulama/background2.dart';
import 'package:mobil_uygulama/logIn.dart';

class signUp extends StatefulWidget {
  const signUp({super.key});

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {

  // Stateler /***************************************/

  int _aktifStep = 0;
  String isim = '', sifre = '';
  late List<Step> tumStepler;
  var key1 = GlobalKey<FormFieldState>();
  var key2 = GlobalKey<FormFieldState>();
  bool hata = false;

  // Stateler /***************************************/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // tumStepler = _tumStepler();
  }

  @override
  Widget build(BuildContext context) {
    tumStepler = _tumStepler();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: Background2(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 40,
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'KAYDOL',
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
            Stepper(
              controlsBuilder: (context, details) {
                return Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(234, 97, 109, 217))),
                          onPressed: details.onStepContinue,
                          child: Text('Devam')),
                      SizedBox(
                        width: 17,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                          onPressed: details.onStepCancel,
                          child: Text('Çıkış')),
                    ],
                  ),
                );
              },
              steps: tumStepler,
              currentStep: _aktifStep,
              onStepContinue: () {
                setState(() {
                  _continueButton();
                });
              },
              onStepCancel: () {
                setState(() {
                  if (_aktifStep > 0) {
                    _aktifStep--;
                  } else {
                    _aktifStep = 0;
                  }
                });
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  width: 300,
                  height: 130,
                  child: Image.asset('assets/images/kadin.jpg')),
            ),
          ]),
        ),
      ),
    );
  }

  List<Step> _tumStepler() {
    List<Step> stepler = [
      Step(
        title: const Text('Kullanıcı adınızı belirleyiniz'),
        // state: StepState.complete,
        state: _stepStateAyarla(0),
        content: TextFormField(
          key: key1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLength: 20,
          decoration: const InputDecoration(
            hintText: 'Kullanıcı adı',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(18.0))),
          ),
          validator: (value) {
            if (value!.length < 6) {
              return 'Kullanıcı adı en az 6 karakter!';
            } else
              return null;
          },
          onSaved: (newValue) {
            setState(() {
              isim = newValue!;
            });
          },
        ),
      ),
      Step(
        title: const Text('Şifrenizi oluşturunuz'),
        // state: StepState.complete,
        state: _stepStateAyarla(2),
        content: TextFormField(
          key: key2,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: true,
          maxLength: 25,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            hintText: 'Şifre',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(18.0))),
          ),
          validator: (value) {
            if (value!.length < 6) {
              return 'Şifre en az 6 karakter içermelidir';
            } else
              return null;
          },
          onSaved: (newValue) {
            setState(() {
              sifre = newValue!;
            });
          },
        ),
      ),
    ];
    return stepler;
  }

  StepState _stepStateAyarla(int i) {
    if (_aktifStep == i) {
      if (hata) {
        return StepState.error;
      } else {
        return StepState.editing;
      }
    } else
      return StepState.complete;
  }

  void _continueButton() async {
    switch (_aktifStep) {
      /*continue butonona basıldığında validator da oluşturduğumuz
    kuralların uyulup uyyulmadığını kontrol ediyoruz
    eğer validator daki kuralların doğruysa bir sonraki adıma geçilecek*/
      case 0:
        /*currentState(o anki durumu) aldık gerçekleşiyorsa save(kurtardık) ettik*/
        if (key1.currentState!.validate()) {
          key1.currentState!.save();
          hata = false; //hata durumu yok
          _aktifStep++; //bir sonraki adıma geçiyo
        } else {
          hata = true;
        }
        break;
      case 1:
        bool response = false;
        if (key2.currentState!.validate()) {
          key2.currentState!.save();
          response = await signUpApi(isim, sifre);
          debugPrint('SignUp Denemesi: ' + response.toString());
          hata = false;
          if (response) {
            EasyLoading.showSuccess('Kayıt Başarılı',
                duration: Duration(milliseconds: 1000), dismissOnTap: true);
            Future.delayed(
              Duration(milliseconds: 1100),
              () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => logIn(),
                ));
              },
            );
          } else {
            _alertDialog();
          }
        } else {
          hata = true;
        }
        break;
    }
  }

  void _alertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hata'),
          content: SingleChildScrollView(
              child: Text('Kullanıcı Adı Daha Önce Kullanılmış')),
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
}

Future<bool> signUpApi(String isim, String sifre) async {
  var dio = Dio();
  var res = null;
  Map<String, dynamic> myResponse = {};
  res = (await dio.post('http://10.0.2.2:8000/api/user',
      data: {'name': isim, 'password': sifre},
      options: Options(contentType: 'application/json')));
  if (res.data['durum'] == true) {
    return true;
  } else {
    return false;
  }
}