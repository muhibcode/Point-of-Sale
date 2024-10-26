import 'package:client/constants/ColorConst.dart';
import 'package:client/constants/controllers.dart';
import 'package:client/helpers/TextFieldSubmit.dart';
import 'package:client/helpers/pdf_view.dart';
import 'package:client/helpers/quot_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewQuot extends StatefulWidget {
  ViewQuot({super.key});

  @override
  State<ViewQuot> createState() => _ViewQuotState();
}

class _ViewQuotState extends State<ViewQuot> {
  final nameCtrl = TextEditingController();

  final cnameCtrl = TextEditingController();

  final emailCtrl = TextEditingController();

  final phoneCtrl = TextEditingController();

  final faxCtrl = TextEditingController();

  final mobNumCtrl = TextEditingController();

  final bCityCtrl = TextEditingController();

  final bStateCtrl = TextEditingController();

  final sCityCtrl = TextEditingController();

  final sStateCtrl = TextEditingController();

  final billAddrCtrl = TextEditingController();

  final shipAddrCtrl = TextEditingController();

  final sCountryCtrl = TextEditingController();

  final bCountryCtrl = TextEditingController();

  final bPostCodeCtrl = TextEditingController();

  final sPostCodeCtrl = TextEditingController();

  final companyRegCtrl = TextEditingController();

  final vatNumCtrl = TextEditingController();

  final urlKeyCtrl = TextEditingController();

  final webCtrl = TextEditingController();
  bool submitted = false;
  int counter = 1;
  late ScrollController _controller;
  var arrIndex = 1;
  var quantity = [];
  var price = [];
  var data = {};
  var ndata = {};
  var qoRowArr = [];
  List<int> subtotal = List.empty(growable: true);
  var subQou = [];
  int gSubtotal = 0;
  double delivery = 0;
  double netTotal = 0;
  double discount = 0.0;
  double vat = 0;
  double cc = 0;
  bool isVat = false;
  var date = DateTime.now();
  var format = '';
  double nVat = 0.0;
  List<Object> opt = [
    {'name': 'yasir', 'age': 50}
  ];
  var products = [
    {'name': 'Pound Sterling', 'sku': 'GBP'},
    {'name': 'US Dollar', 'sku': 'USD'},
    {'name': 'Euro', 'sku': 'URO'},
  ];
  var currList = [
    {'name': 'Pound Sterling', 'code': 'GBP'},
    {'name': 'US Dollar', 'code': 'USD'},
  ];
  dateformat() {
    setState(() {
      format = date.toString().split(' ')[0];
    });
  }

  addQoutArr() {
    data = {
      'sku': TextEditingController(),
      'description': TextEditingController(),
      'condition': TextEditingController(),
      'eta': TextEditingController(),
      'quantity': 0,
      'price': 0,
      'subtotal': 0,
    };

    price.add(0);
    quantity.add(0);
    subtotal.add(0);
    qoRowArr.add(data);
    data = {};
  }

  onChVat() {
    if (isVat) {
      vat = (gSubtotal.toDouble() + delivery) * 0.2;
      nVat = double.parse(vat.toStringAsFixed(1));
      netTotal = gSubtotal.toDouble() + delivery + nVat + cc - discount;
    } else {
      vat = 0;
      nVat = double.parse(vat.toStringAsFixed(1));
      netTotal = gSubtotal.toDouble() + delivery + nVat + cc - discount;
    }
  }

  qouteSubmit() {
    for (var e in qoRowArr) {
      ndata = {
        'sku': e['sku'].text,
        'description': e['description'].text,
        'condition': e['condition'].text,
        'eta': e['eta'].text,
        'quantity': e['quantity'],
        'price': e['price'],
        'subtotal': e['subtotal'],
      };
      subQou.add(ndata);
      ndata = {};
    }
  }

  // setCurCode() {
  //   menuController.setDropDown('');
  // }

  @override
  void initState() {
    // addQoutArr();
    dateformat();
    // setCurCode();
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.yellow[900],
                              borderRadius: BorderRadius.circular(5)),
                          height: 240,
                          width: 450,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 50,
                                width: 450,
                                color: Colors.orange[900],
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Bill To',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              textStyle:
                                                  const MaterialStatePropertyAll(
                                                      TextStyle(fontSize: 15)),
                                              foregroundColor:
                                                  const MaterialStatePropertyAll(
                                                      Colors.white),
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.grey.shade800)),
                                          // icon: const Icon(
                                          //   Icons.save,
                                          // ),
                                          onPressed: () {
                                            qouteSubmit();
                                          },
                                          child: const Text('Edit')),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Client Name',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Client Name',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Compnay Name',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'State, Country',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Email',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Phone Num',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.yellow[900],
                              borderRadius: BorderRadius.circular(5)),
                          height: 240,
                          width: 450,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 50,
                                width: 450,
                                color: Colors.orange[900],
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Ship To',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              textStyle:
                                                  const MaterialStatePropertyAll(
                                                      TextStyle(fontSize: 15)),
                                              foregroundColor:
                                                  const MaterialStatePropertyAll(
                                                      Colors.white),
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.grey.shade800)),
                                          // icon: const Icon(
                                          //   Icons.save,
                                          // ),
                                          onPressed: () {
                                            qouteSubmit();

                                            print(subQou);
                                          },
                                          child: const Text('Edit')),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Client Name',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Client Name',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Compnay Name',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'State, Country',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Email',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Phone Num',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: PaginatedDataTable(
                            rowsPerPage: 6,
                            columns: const [
                              DataColumn(label: Text('Product')),
                              DataColumn(label: Text('Description')),
                              DataColumn(label: Text('Condition')),
                              DataColumn(label: Text('Quantity')),
                              DataColumn(label: Text('Price')),
                              DataColumn(label: Text('SubTotal')),
                            ],
                            source: QuotRowSource()),
                      ),
                    ],
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              color: Colors.orange[900],
                              width: 450,
                              height: 50,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, top: 12),
                                child: CustomText('Terms and Conditions', 16,
                                    Colors.black, FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              color: Colors.grey[800],
                              width: 450,
                              child: TextFieldSubmit(
                                  submitted: submitted,
                                  label: 'Terms & Conditons'),
                            ),
                          ],
                        ),
                        const VerticalDivider(),
                        Column(
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              color: Colors.orange[900],
                              width: 450,
                              height: 50,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, top: 12),
                                child: CustomText('Footer Section', 16,
                                    Colors.black, FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              color: Colors.grey[800],
                              width: 450,
                              child: TextFieldSubmit(
                                  submitted: submitted,
                                  label: 'Footer Section'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: SizedBox(
                    height: 38,
                    child: ElevatedButton.icon(
                        style: ButtonStyle(
                            textStyle: const MaterialStatePropertyAll(TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                            foregroundColor:
                                const MaterialStatePropertyAll(Colors.black),
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.yellow.shade900)),
                        icon: const Icon(Icons.edit_document),
                        onPressed: () {},
                        label: const Text('Edit')),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Center(
                  child: SizedBox(
                    height: 38,
                    child: ElevatedButton.icon(
                        style: ButtonStyle(
                            textStyle: const MaterialStatePropertyAll(TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                            foregroundColor:
                                const MaterialStatePropertyAll(Colors.black),
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.yellow.shade900)),
                        icon: const Icon(Icons.picture_as_pdf),
                        onPressed: () {
                          generateInvoice();
                        },
                        label: const Text('PDF')),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Center(
                  child: SizedBox(
                    height: 38,
                    child: ElevatedButton.icon(
                        style: ButtonStyle(
                            textStyle: const MaterialStatePropertyAll(TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                            foregroundColor:
                                const MaterialStatePropertyAll(Colors.black),
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.yellow.shade900)),
                        icon: const Icon(Icons.email),
                        onPressed: () {},
                        label: const Text('Email')),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(5)),
                  width: 250,
                  height: 500,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.orange[900],
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(5),
                                topLeft: Radius.circular(5))),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 12.0, left: 10),
                          child: Text(
                            'Options',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            CustomText(
                                'Qout#', 18, Colors.white, FontWeight.w600),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomText(
                                'QUO87', 17, Colors.white, FontWeight.normal),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomText(
                                'Date', 18, Colors.white, FontWeight.w600),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomText(
                                format, 17, Colors.white, FontWeight.normal),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText('SubTotal :', 18, Colors.white,
                                    FontWeight.bold),
                                Obx(
                                  () => CustomText(
                                      '${menuController.curSign.value}${delivery.toString()}',
                                      18,
                                      Colors.white,
                                      FontWeight.normal),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText('Delivery :', 18, Colors.white,
                                    FontWeight.bold),
                                Obx(
                                  () => CustomText(
                                      '${menuController.curSign.value}${delivery.toString()}',
                                      18,
                                      Colors.white,
                                      FontWeight.normal),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText('VAT (20%) :', 18, Colors.white,
                                    FontWeight.bold),
                                Obx(
                                  () => CustomText(
                                      '${menuController.curSign.value}${delivery.toString()}',
                                      18,
                                      Colors.white,
                                      FontWeight.normal),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                    'CC :', 18, Colors.white, FontWeight.bold),
                                Obx(
                                  () => CustomText(
                                      '${menuController.curSign.value}${delivery.toString()}',
                                      18,
                                      Colors.white,
                                      FontWeight.normal),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText('Discount :', 18, Colors.white,
                                    FontWeight.bold),
                                Obx(
                                  () => CustomText(
                                      '-${menuController.curSign.value}${delivery.toString()}',
                                      18,
                                      Colors.white,
                                      FontWeight.normal),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                    'Total', 18, Colors.white, FontWeight.bold),
                                Obx(
                                  () => CustomText(
                                      '${menuController.curSign.value}${delivery.toString()}',
                                      18,
                                      Colors.white,
                                      FontWeight.normal),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
