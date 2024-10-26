import 'package:flutter/material.dart';

class QuotRowSource extends DataTableSource {
  // final List<Map<String, dynamic>> mydata;
  var quotes = [
    // {
    //   'product': '',
    //   'description': '',
    //   'condition': '',
    //   'quantity': '',
    //   'price': '',
    //   'subtotal': ''
    // }
  ];

  // RowSource();
  // var quotes = menuController.mydata;
  @override
  DataRow? getRow(int index) {
    // return DataRow(
    //     cells: mydata.map((e) => DataCell(Text(e.keys.toString()))).toList());

    return DataRow(cells: [
      DataCell(Text(quotes[index]['product'].toString())),
      DataCell(Text(quotes[index]['description'].toString())),
      DataCell(Text(quotes[index]['condition'].toString())),
      DataCell(Text(quotes[index]['quantity'].toString())),
      // DataCell(Text(quotes[index]['price'].toString())),
      // DataCell(Text(quotes[index]['subtotal'].toString())),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => quotes.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
