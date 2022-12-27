import 'package:flutter/material.dart';
import 'package:mobil_uygulama/logIn.dart';
import 'package:mobil_uygulama/signUp.dart';
import 'background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Metotlar /***************************************/

  Column button_first() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 125,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            color: Color(0xFFF00BBBC),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'GİRİŞ YAP',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column button_second() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 125,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            color: Color.fromARGB(255, 194, 239, 239),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'KAYDOL',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xFFF00BBBC),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Metotlar /***************************************/

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Column(
      children: [
        SizedBox(
          height: 90,
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Welcome ToDo App',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF00BBBC)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        Container(
          width: 390,
          height: 250,
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Image.asset(
                    'assets/images/erkekkadin.jpg',
                  )),
            ],
          ),
        ),
        Container(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => logIn(),
                  ));
                },
                child: button_first(),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Container(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => signUp(),
                  ));
                },
                child: button_second(),
              )
            ],
          ),
        )
      ],
    ));
  }
}