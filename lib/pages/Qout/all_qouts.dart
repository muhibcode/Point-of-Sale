import 'package:client/constants/controllers.dart';
import 'package:client/helpers/TextFieldSubmit.dart';
import 'package:client/helpers/auto_dropdown.dart';
import 'package:client/helpers/quot_source.dart';
import 'package:client/routing/routes.dart';
import 'package:flutter/material.dart';

class AllQuots extends StatefulWidget {
  AllQuots({super.key});

  @override
  State<AllQuots> createState() => _AllQuotsState();
}

class _AllQuotsState extends State<AllQuots> {
  bool sort = true;
  var colInd = 1;
  @override
  void initState() {
    // menuController.newArr();
    // print(menuController.newData);
    // TODO: implement initState
    super.initState();
  }

  succesModal() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // Future.delayed(const Duration(seconds: 1), () {
          //   Navigator.of(context).pop();
          //   navigationController.navigateTo(AllClientsR, '');
          // });
          return AlertDialog(
            backgroundColor: Colors.grey[800],
            content: Container(
              height: 250,
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  AutoCompDrop(
                    initalVal: '',
                    items: menuController.newData,
                    title: 'Search Client',
                    select: 'name',
                    width: 200,
                    onSelect: (option) {
                      print(option);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.edit_document,
                        ),
                        style: ButtonStyle(
                            textStyle: const MaterialStatePropertyAll(
                                TextStyle(fontWeight: FontWeight.bold)),
                            // fixedSize: const MaterialStatePropertyAll(Size.fromWidth(120)),
                            foregroundColor:
                                const MaterialStatePropertyAll(Colors.black),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.yellow[900])),
                        onPressed: () {
                          Navigator.pop(context);
                          navigationController.navigateTo(
                              AddQuotR, menuController.idVal);

                          // print(menuController.idVal);
                        },
                        label: const Text('Create Quote')),
                  ),
                ],
              ),
            ),
          );
        });
  }

  var quoteCtrl = TextEditingController();
  var newArr = [];

  // List<Map<String, dynamic>> pagedata = [
  //   {'clientID': 1, 'name': 'muhib', 'qoute': 35},
  //   {'clientID': 2, 'name': 'yasir', 'qoute': 45},
  //   {'clientID': 3, 'name': 'tahir', 'qoute': 55},
  //   {'clientID': 4, 'name': 'khan', 'qoute': 25},
  //   {'clientID': 5, 'name': 'bilal', 'qoute': 15},
  //   {'clientID': 6, 'name': 'muhib', 'qoute': 35},
  //   {'clientID': 7, 'name': 'yasir', 'qoute': 45},
  //   {'clientID': 8, 'name': 'tahir', 'qoute': 55},
  //   {'clientID': 9, 'name': 'khan', 'qoute': 25},
  //   {'clientID': 10, 'name': 'bilal', 'qoute': 15},
  //   {'clientID': 1, 'name': 'muhib', 'qoute': 35},
  //   {'clientID': 2, 'name': 'yasir', 'qoute': 45},
  //   {'clientID': 3, 'name': 'tahir', 'qoute': 55},
  //   {'clientID': 4, 'name': 'khan', 'qoute': 25},
  //   {'clientID': 5, 'name': 'bilal', 'qoute': 15},
  //   {'clientID': 6, 'name': 'muhib', 'qoute': 35},
  //   {'clientID': 7, 'name': 'yasir', 'qoute': 45},
  //   {'clientID': 8, 'name': 'tahir', 'qoute': 55},
  //   {'clientID': 9, 'name': 'khan', 'qoute': 25},
  //   {'clientID': 10, 'name': 'bilal', 'qoute': 15},
  // ];
  // var pagedata = menuController.mydata;

  // onSortColumn(ind, asc, val) {
  //   if (ind == 1) {
  //     if (asc) {
  //       pagedata.sort(
  //         (a, b) => b[val].toString().compareTo(a[val].toString()),
  //       );
  //     } else {
  //       pagedata.sort(
  //         (a, b) => a[val].toString().compareTo(b[val].toString()),
  //       );
  //     }
  //   }
  //   if (ind == 2) {
  //     if (asc) {
  //       pagedata.sort(
  //         (a, b) => int.parse(b[val].toString())
  //             .compareTo(int.parse(a[val].toString())),
  //       );
  //     } else {
  //       pagedata.sort(
  //         (a, b) => int.parse(a[val].toString())
  //             .compareTo(int.parse(b[val].toString())),
  //       );
  //     }
  //   }
  // }

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
                  Icons.request_quote_outlined,
                ),
                style: ButtonStyle(
                    textStyle: const MaterialStatePropertyAll(
                        TextStyle(fontWeight: FontWeight.bold)),
                    // fixedSize: const MaterialStatePropertyAll(Size.fromWidth(120)),
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.black),
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.yellow[900])),
                onPressed: () {
                  succesModal();
                },
                label: const Text('NEW')),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 250,
            child: TextFieldSubmit(
              controller: quoteCtrl,
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
                          .startsWith(quoteCtrl.text))
                      .toList();
                  for (var e in newArr) {
                    menuController.ndata.add(e);
                  }
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // menuController.mydata.isNotEmpty
              //     ?
              PaginatedDataTable(
                  // horizontalMargin: 170,
                  // columnSpacing: 200,
                  rowsPerPage: 10,
                  // sortColumnIndex: colInd,
                  // sortAscending: sort,
                  // arrowHeadColor: Colors.yellow[900],
                  header: Text('All Quotes'),
                  columns: [
                    const DataColumn(
                      label: Text('Quote'),
                    ),
                    DataColumn(
                      onSort: (columnIndex, ascending) {
                        setState(() {
                          sort = ascending;
                          colInd = columnIndex;
                        });
                        // onSortColumn(columnIndex, ascending, 'name');
                      },
                      label: const Text('Client'),
                    ),
                    DataColumn(
                        onSort: (columnIndex, ascending) {
                          setState(() {
                            sort = ascending;
                            colInd = columnIndex;
                          });
                          // onSortColumn(columnIndex, ascending, 'qoute');
                        },
                        label: const Text('Total')),
                    const DataColumn(label: Text('Action')),
                    // const DataColumn(
                    //     label: Padding(
                    //   padding: EdgeInsets.only(left: 30),
                    //   child: Text(
                    //     'Action',
                    //   ),
                    // ))
                  ],
                  source: QuotRowSource())
              // : const Center(child: Text('NO QUOTES ADDED')),
            ],
          ),
        ],
      ),
    );
  }
}
