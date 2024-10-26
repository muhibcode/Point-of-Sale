import 'package:client/helpers/local_navigator.dart';
import 'package:client/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class LargeScreen extends StatefulWidget {
  const LargeScreen({super.key});

  @override
  State<LargeScreen> createState() => _LargeScreenState();
}

class _LargeScreenState extends State<LargeScreen> {
  @override
  void initState() {
    // getHttp();
    // TODO: implement initState
    super.initState();
  }

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(color: Colors.yellow[900], child: const SideMenu())),
      Expanded(
          flex: 5,
          child: Container(color: Colors.black87, child: localNavigator()))
    ]);
  }
}
