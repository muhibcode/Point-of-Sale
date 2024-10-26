import 'dart:io';

import 'package:client/constants/controllers.dart';
import 'package:client/helpers/TextFieldSubmit.dart';
import 'package:client/helpers/client_row_source.dart';
import 'package:client/routing/routes.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllClients extends StatefulWidget {
  AllClients({super.key});

  @override
  State<AllClients> createState() => _AllClientsState();
}

class _AllClientsState extends State<AllClients> {
  bool sort = true;
  var inVal = '';
  var colInd = 1;
  var newArr = [];
  @override
  void initState() {
    // menuController.newArr();
    // print(menuController.newData);

    // TODO: implement initState
    super.initState();
  }

  var nameCtrl = TextEditingController();

  var pagedata = menuController.mydata;

  onSortColumn(ind, asc, val) {
    if (ind == 1) {
      if (asc) {
        pagedata.sort(
          (a, b) => b[val].toString().compareTo(a[val].toString()),
        );
      } else {
        pagedata.sort(
          (a, b) => a[val].toString().compareTo(b[val].toString()),
        );
      }
    }
    if (ind == 2) {
      if (asc) {
        pagedata.sort(
          (a, b) => int.parse(b[val].toString())
              .compareTo(int.parse(a[val].toString())),
        );
      } else {
        pagedata.sort(
          (a, b) => int.parse(a[val].toString())
              .compareTo(int.parse(b[val].toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // data.pagedata.length;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.person,
                ),
                style: ButtonStyle(
                    textStyle: const MaterialStatePropertyAll(
                        TextStyle(fontWeight: FontWeight.bold)),
                    // fixedSize: const MaterialStatePropertyAll(Size.fromWidth(120)),
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.black),
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.yellow[900])),
                onPressed: () async {
                  FilePickerResult? pickedFile =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['xlsx'],
                    allowMultiple: false,
                  );

                  /// file might be picked

                  if (pickedFile != null) {
                    var bytes = pickedFile.files.single.bytes;
                    var excel = Excel.decodeBytes(bytes as List<int>);
                    for (var table in excel.tables.keys) {
                      print(table); //sheet Name
                      // print(excel.tables[table]!.maxCols);
                      // print(excel.tables[table]!.maxRows);
                      for (var row in excel.tables[table]!.rows) {
                        print('$row');
                      }
                    }
                  }
                },
                label: const Text('NEW')),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 250,
                  child: TextFieldSubmit(
                    controller: nameCtrl,
                    submitted: false,
                    label: 'Search',
                    onChanged: (val) {
                      setState(() {
                        newArr.clear();
                        menuController.ndata.clear();
                        newArr = menuController.mydata
                            .where((element) => element['name']
                                .toString()
                                .toLowerCase()
                                .startsWith(nameCtrl.text))
                            .toList();
                        for (var e in newArr) {
                          menuController.ndata.add(e);
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.yellow[900],
                      borderRadius: const BorderRadius.all(Radius.circular(2))),
                  child: IconButton(
                      // splashRadius: 15,
                      splashColor: Colors.grey,
                      onPressed: () {
                        setState(() {});
                        nameCtrl.clear();
                        menuController.ndata.clear();

                        // print(inVal);
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.black,
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() =>
                      // menuController.mydata.isNotEmpty
                      //     ?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: PaginatedDataTable(
                            rowsPerPage: 10,
                            sortColumnIndex: colInd,
                            sortAscending: sort,
                            arrowHeadColor: Colors.yellow[900],
                            header: Text(
                                'All Clients\t${menuController.mydata.length.toString()}'),
                            columns: [
                              // const DataColumn(
                              //   label: Text('#'),
                              // ),
                              const DataColumn(
                                label: Text('Client ID'),
                              ),
                              DataColumn(
                                onSort: (columnIndex, ascending) {
                                  setState(() {
                                    sort = ascending;
                                    colInd = columnIndex;
                                  });
                                  onSortColumn(columnIndex, ascending, 'name');
                                },
                                label: const Text('Name'),
                              ),
                              // DataColumn(
                              //     onSort: (columnIndex, ascending) {
                              //       setState(() {
                              //         sort = ascending;
                              //         colInd = columnIndex;
                              //       });
                              //       onSortColumn(columnIndex, ascending, 'qoute');
                              //     },
                              //     label: const Text('Date Added')),
                              // const DataColumn(label: Text('Qoutes')),
                              const DataColumn(
                                  label: Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  'Action',
                                ),
                              ))
                            ],
                            source: ClientRowSource()),
                      )
                  // : Container(
                  //     color: Colors.amber,
                  //   ),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
