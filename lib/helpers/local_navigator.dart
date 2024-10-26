import 'package:client/constants/controllers.dart';
import 'package:client/routing/router.dart';
import 'package:client/routing/routes.dart';
import 'package:flutter/material.dart';

Navigator localNavigator() {
  return Navigator(
      key: navigationController.navigation_key,
      initialRoute: AllClientsR,
      onGenerateRoute: generateRoute);
}
