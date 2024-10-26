import 'package:client/helpers/textbutton_icon.dart';
import 'package:client/routing/routes.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int selected = -1;
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Yasir Ali',
                style: TextStyle(color: Colors.black, fontSize: 20),
              )
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Divider(
          color: Colors.black,
        ),
        SizedBox(
          height: 20,
        ),
        CustomeButton(
          label: AllClientsR,
        ),
        SizedBox(
          height: 10,
        ),
        CustomeButton(
          label: AllQuotsR,
        ),
        SizedBox(
          height: 10,
        ),
        CustomeButton(
          label: AddOrderR,
        ),
        SizedBox(
          height: 10,
        ),
        CustomeButton(
          label: UserLoginR,
        ),
        SizedBox(
          height: 10,
        ),
        CustomeButton(
          label: RegisterR,
        ),
      ],
    );
  }
}
