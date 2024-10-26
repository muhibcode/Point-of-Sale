import 'package:client/constants/controllers.dart';
import 'package:client/routing/routes.dart';
import 'package:flutter/material.dart';

class ClientRowSource extends DataTableSource {
  // final List<Map<String, dynamic>> mydata;
  // var newData = [];

  // RowSource();
  var mydata = menuController.mydata;
  var ndata = menuController.ndata;
  @override
  DataRow? getRow(int index) {
    // return DataRow(
    //     cells: mydata.map((e) => DataCell(Text(e.keys.toString()))).toList());

    return DataRow(cells: [
      // menuController.ndata.isEmpty
      //     ? DataCell(Text(mydata[index]['#'].toString()))
      //     : DataCell(Text(ndata[index]['#'].toString())),
      menuController.ndata.isEmpty
          ? DataCell(Text(mydata[index]['id'].toString()))
          : DataCell(Text(ndata[index]['id'].toString())),
      menuController.ndata.isEmpty
          ? DataCell(Text(mydata[index]['name'].toString()))
          : DataCell(Text(ndata[index]['name'].toString())),
      // DataCell(Text(mydata[index]['id'].toString())),
      // DataCell(Text(mydata[index]['name'].toString())),
      // DataCell(Text(newData[index]['qoute'].toString())),
      // DataCell(
      //   TextButton(
      //     onPressed: () {},
      //     child: Text(
      //       'Qout',
      //       style: TextStyle(color: Colors.yellow[900]),
      //     ),
      //   ),
      // ),
      DataCell(Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                menuController.ndata.isEmpty
                    ? navigationController.navigateTo(
                        EditClientR, menuController.mydata[index]['id'])
                    : navigationController.navigateTo(
                        EditClientR, menuController.ndata[index]['id']);

                // navigationController.navigateTo(
                //     EditClientR, menuController.mydata[index]['id']);
                // print(menuController.mydata[index]['id'].toString());
              },
              child: const Text('Edit')),

          // const SizedBox(
          //   width: 5,
          // ),
          const VerticalDivider(),
          // const SizedBox(
          //   width: 5,
          // ),
          TextButton(
              onPressed: () {
                menuController.ndata.isEmpty
                    ? menuController
                        .delClient(menuController.mydata[index]['id'])
                    : menuController
                        .delClient(menuController.ndata[index]['id']);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ))
        ],
      ))
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => ndata.isEmpty ? mydata.length : ndata.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
