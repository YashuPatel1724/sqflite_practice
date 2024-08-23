import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_practice/view/screen/home_page.dart';

void main()
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => HomePage(),),
      ],
    );
  }
}
