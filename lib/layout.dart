import 'package:client/helpers/responsive.dart';
import 'package:client/widgets/large_screen.dart';
import 'package:client/widgets/small_screen.dart';
import 'package:client/widgets/top_nav.dart';
import 'package:flutter/material.dart';

class SiteLayout extends StatelessWidget {
  // const SiteLayout({super.key});

  final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: topNaviagtionBar(context, scaffoldkey),
      drawer: const Drawer(),
      body: const LargeScreen(),
      // body: const Responsive(
      //     largeScreenWidget: LargeScreen(),
      //     mediumScreenWidget: SmallScreen(),
      //     smallScreenWidget: SmallScreen())
    );
  }
}
