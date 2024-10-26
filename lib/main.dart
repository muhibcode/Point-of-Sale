import 'package:client/controllers/menu_controller.dart';
import 'package:client/controllers/navigation_controller.dart';
import 'package:client/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(MenusController());
  Get.put(NavigationController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: SiteLayout(),
    );
  }
}
