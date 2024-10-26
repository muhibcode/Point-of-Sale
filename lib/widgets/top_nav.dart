import 'package:client/helpers/responsive.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

AppBar topNaviagtionBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !Responsive.isSmallScreen(context)
          ? const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                )
              ],
            )
          : IconButton(
              onPressed: () {
                key.currentState!.openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              )),
      elevation: 0,
      backgroundColor: Colors.white,
      title: Row(children: [
        const Visibility(
            child: Text(
          'DashBoard',
          style: TextStyle(color: Colors.grey, fontSize: 20),
        )),
        Expanded(child: Container()),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.black,
            )),
        const Stack(
          children: [],
        )
      ]),
    );

// class TopNavigation extends StatelessWidget {
//   const TopNavigation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar();
//   }
// }
