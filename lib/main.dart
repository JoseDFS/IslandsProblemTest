import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'IslandsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Islands Problem',
      home: IniMatrix(),
    ); //MaterialApp
  }
}

class IniMatrix extends StatelessWidget {
  final sizeController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/islandL.json'),
              TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter matrix size (Default 4)",
                  ),
                  controller: sizeController),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                      onPressed: () {
                        var mSize = sizeController.text;
                        print(mSize);
                        if (mSize.isEmpty) mSize = "4";
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    IslandsPage(mSize: mSize)));
                      },
                      child: Text('Generate Islands'),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15))))))
            ],
          )),
    ));
  }
}
