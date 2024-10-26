import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController instance = Get.find();

  final navigation_key = GlobalKey<NavigatorState>();

  navigateTo(String routeName, val) {
    return navigation_key.currentState!.pushNamed(routeName, arguments: val);
  }

  goBack() => navigation_key.currentState!.pop();
}
