import 'dart:async';

import 'package:client/API.dart';
import 'package:client/constants/ColorConst.dart';
import 'package:client/constants/controllers.dart';
import 'package:client/helpers/TextFieldSubmit.dart';
import 'package:client/helpers/auto_dropdown.dart';
import 'package:client/helpers/drop_down.dart';
import 'package:client/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class AddQuot extends StatefulWidget {
  final vals;
  const AddQuot({super.key, this.vals});

  @override
  State<AddQuot> createState() => _AddQuotState();
}

class _AddQuotState extends State<AddQuot> {
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
  final termsCtrl = TextEditingController();
  final footerCtrl = TextEditingController();

  final webCtrl = TextEditingController();
  bool submitted = false;
  int counter = 1;
  late ScrollController _controller;
  var arrIndex = 1;
  var quantity = [];
  var price = [];
  var data = {};
  var ndata = {};
  var quotArr = [];
  List<double> subtotal = List.empty(growable: true);
  var subQuot = [];
  double gSubtotal = 0;
  double delivery = 0;
  double netTotal = 0;
  double discount = 0.0;
  double vat = 0;
  double cc = 0;
  bool isVat = false;
  var date = DateTime.now();
  var format = '';
  // var currSign = '';
  double nVat = 0.0;
  var clientVals = {};
  var dropVal = '';
  final RegExp regex = RegExp('[a-zA-Z]');

  final _formkey = GlobalKey<FormState>();

  termsAndfooter() {
    termsCtrl.text =
        'Due to volatile nature of marketplace in the current climate,we are unable to guarantee pricing and stock availabilty.Please contact your account manager for the very latest pricing and stock availabilty.';
    footerCtrl.text =
        'All Quotations/Sale Orders and subsequent orders are subject to compliance to our standard terms & conditions unless stated otherwise.See terms and conditions of sale https://theinsightsolutions.com/terms-of-service/.No return accepetd without prior authorization.See return policy at https://theinsightsolutions.com/refund-and-reutrns-policy/';
  }

  List<Object> opt = [
    {'name': 'yasir', 'age': 50}
  ];
  var products = [
    {'name': 'Pound Sterling', 'sku': 'GBP'},
    {'name': 'US Dollar', 'sku': 'USD'},
    {'name': 'Euro', 'sku': 'URO'},
  ];
  var currList = ['Currency', 'US Dollar', 'Pound Sterling'];
  // var seen = Set<String>();

  dateformat() {
    setState(() {
      format = date.toString().split(' ')[0];
    });
  }

  succesModal() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop();
            navigationController.navigateTo(ViewQuotR, '');
          });
          return AlertDialog(
            backgroundColor: Colors.grey[800],
            content: Container(
              height: 110,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  CustomText('Quote Saved Successfully', 20, Colors.white,
                      FontWeight.bold),
                  const SizedBox(
                    height: 10,
                  ),
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 60,
                  )
                ],
              ),
            ),
          );
        });
  }

  addQoutArr() {
    data = {
      'sku': TextEditingController(),
      'description': TextEditingController(),
      'condition': TextEditingController(),
      'eta': TextEditingController(),
      'quantity': TextEditingController(),
      'price': TextEditingController(),
      'subtotal': 0,
    };

    price.add(0);
    quantity.add(0);
    subtotal.add(0);
    quotArr.add(data);
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
    for (var e in quotArr) {
      ndata = {
        'sku': e['sku'].text,
        'description': e['description'].text,
        'condition': e['condition'].text,
        'eta': e['eta'].text,
        'quantity': e['quantity'].text,
        'price': menuController.curSign.value + e['price'].text,
        'subtotal': e['subtotal'],
      };
      subQuot.add(ndata);
      ndata = {};
    }
  }

  clientInit() async {
    var id = widget.vals['id'];

    var res = await getReq('clients/$id');
    setState(() {
      clientVals = res.data['client'];
      dropVal = clientVals['currency'].toString();
    });
    print(dropVal);
  }

  @override
  void initState() {
    addQoutArr();
    dateformat();
    clientInit();
    termsAndfooter();
    menuController.setCurCode(dropVal);

    _controller = ScrollController();
    super.initState();
  }

  onSubmit(ctx) async {
    // setState(() {
    //   buttonText = 'loading...';
    // });

    data.addAll({
      'client_id': clientVals['id'],
      'quote_item': subQuot,
      'gSubtotal': menuController.curSign.value + gSubtotal.toString(),
      'delivery_charges': menuController.curSign.value + delivery.toString(),
      'cc_percent': cc,
      'cc_charges': menuController.curSign.value + cc.toString(),
      'vat': menuController.curSign.value + nVat.toString(),
      'discount': menuController.curSign.value + discount.toString(),
      'terms&con': termsCtrl,
      'footer': footerCtrl,
    });
    // var res = await postData('register', data);
    // var endres = res.data;
    // print(menu);
    // var body = jsonEncode(data);
    // var res = await http.post(url, body: body, headers: headers);
    // var endres = jsonDecode(res.body);

    // print(endres);
    // if (endres['message'] == 'success') {
    //   succesModal();
    //   // navigationController.navigateTo(AllClientsR);
    // }
    //  else {
    //   if (endres['message'] == 'invalid esp') {
    //     Navigator.pushReplacementNamed(ctx, 'Error',
    //         arguments: {'val': 'signup-esp'});
    //   }
    //   if (endres['message'] == 'invalid esp') {
    //     Navigator.pushReplacementNamed(ctx, 'Error',
    //         arguments: {'val': 'signup-user'});
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomText('Date', 18, Colors.white, FontWeight.w600),
                const SizedBox(
                  height: 10,
                ),
                CustomText(format, 17, Colors.white, FontWeight.normal),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 38,
                  child: ElevatedButton.icon(
                      style: ButtonStyle(
                          textStyle: const MaterialStatePropertyAll(TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                          foregroundColor:
                              const MaterialStatePropertyAll(Colors.black),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.yellow.shade900)),
                      icon: const Icon(
                        Icons.save,
                      ),
                      onPressed: () {
                        // qouteSubmit();
                        succesModal();
                        // Navigator.pop(context);
                        print(subQuot);
                        // Timer(
                        //     Duration(seconds: 5),
                        //     () => navigationController
                        //         .navigateTo(AddClientR));
                      },
                      label: const Text('Save')),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                height: 350,
                decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 26),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText('ITEMS\t\t\t${quotArr.length.toString()}',
                              16, Colors.white, FontWeight.w600),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                  style: ButtonStyle(
                                      foregroundColor:
                                          const MaterialStatePropertyAll(
                                              Colors.black),
                                      backgroundColor: MaterialStatePropertyAll(
                                          Colors.yellow.shade900)),
                                  icon: const Icon(
                                    Icons.add,
                                  ),
                                  onPressed: () {
                                    addQoutArr();
                                    setState(() {
                                      arrIndex += 1;
                                    });
                                  },
                                  label: const Text(
                                    'Add Item',
                                    // style: TextStyle(color: Colors.black),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 160,
                          height: 50,
                          child: CustomDropDown(
                            submitted: false,
                            dlist: currList,
                            initVal: dropVal,
                            onChange: (value) {
                              if (value != currList[0]) {
                                menuController.setCurCode(value);

                                setState(() {
                                  dropVal = value!;
                                });
                              } else {
                                menuController.setCurCode(value);

                                setState(() {
                                  dropVal = '';
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                            height: 35,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, right: 35),
                              child: CustomText('SubTotal', 16, Colors.white,
                                  FontWeight.normal),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: IconButton(
                            splashRadius: 2,
                            icon: Icon(
                              Icons.delete,
                              color: Colors.yellow[900],
                            ),
                            onPressed: () {
                              var index = quotArr.length - 1;
                              quotArr[index]['price'].clear();
                              quotArr[index]['quantity'].clear();
                              gSubtotal = gSubtotal - subtotal[index];
                              netTotal = netTotal - gSubtotal;

                              setState(() {
                                subtotal[index] = 0;

                                quotArr.removeAt(index);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: WebSmoothScroll(
                        controller: _controller,
                        child: SingleChildScrollView(
                          controller: _controller,
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                              children: List.generate(
                            quotArr.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomText((index + 1).toString(), 15,
                                      Colors.white, FontWeight.normal),
                                  SizedBox(
                                      width: 120,
                                      child: AutoCompDrop(
                                        width: 90,
                                        initalVal: '',
                                        items: [],
                                        title: 'SKU',
                                        select: 'sku',
                                        onSelect: (option) {},
                                      )),
                                  SizedBox(
                                      width: 240,
                                      child: TextFieldSubmit(
                                        controller: quotArr[index]
                                            ['description'],
                                        submitted: false,
                                        label: 'Description',
                                      )),
                                  SizedBox(
                                      width: 110,
                                      child: TextFieldSubmit(
                                          controller: quotArr[index]
                                              ['condition'],
                                          submitted: false,
                                          label: 'Condition')),
                                  SizedBox(
                                      width: 100,
                                      child: TextFieldSubmit(
                                          controller: quotArr[index]['eta'],
                                          submitted: false,
                                          label: 'ETA')),
                                  SizedBox(
                                      width: 90,
                                      child: TextFieldSubmit(
                                          controller: quotArr[index]
                                              ['quantity'],
                                          onChanged: (val) {
                                            setState(() {
                                              if (val == '') {
                                                subtotal[index] = 0.0 *
                                                    double.parse(quotArr[index]
                                                            ['price']
                                                        .text
                                                        .toString());
                                                quotArr[index]['subtotal'] =
                                                    subtotal[index];
                                                gSubtotal = subtotal.reduce(
                                                  (value, element) {
                                                    return value + element;
                                                  },
                                                );
                                                onChVat();
                                              } else {
                                                if (quotArr[index]['price']
                                                    .text
                                                    .toString()
                                                    .isNotEmpty) {
                                                  var q = double.parse(
                                                      val.toString());
                                                  var p = double.parse(
                                                      quotArr[index]['price']
                                                          .text
                                                          .toString());
                                                  subtotal[index] = p * q;
                                                  quotArr[index]['subtotal'] =
                                                      subtotal[index];
                                                  gSubtotal = subtotal
                                                      .reduce((value, element) {
                                                    return value + element;
                                                  });
                                                  onChVat();
                                                }
                                              }
                                            });
                                          },
                                          submitted: false,
                                          label: 'Qty')),
                                  Row(
                                    children: [
                                      Text(
                                        menuController.curSign.value,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      SizedBox(
                                          width: 100,
                                          child: TextFieldSubmit(
                                              controller: quotArr[index]
                                                  ['price'],
                                              onChanged: (val) {
                                                setState(() {
                                                  if (val == '') {
                                                    subtotal[index] = 0.0 *
                                                        double.parse(
                                                            quotArr[index]
                                                                    ['quantity']
                                                                .text
                                                                .toString());
                                                    quotArr[index]['subtotal'] =
                                                        subtotal[index];
                                                    gSubtotal = subtotal.reduce(
                                                      (value, element) {
                                                        return value + element;
                                                      },
                                                    );
                                                    onChVat();
                                                  } else {
                                                    if (quotArr[index]
                                                            ['quantity']
                                                        .text
                                                        .toString()
                                                        .isNotEmpty) {
                                                      var p = double.parse(
                                                          val.toString());
                                                      var q = double.parse(
                                                          quotArr[index]
                                                                  ['quantity']
                                                              .text
                                                              .toString());
                                                      subtotal[index] = p * q;

                                                      quotArr[index]
                                                              ['subtotal'] =
                                                          subtotal[index];
                                                      gSubtotal =
                                                          subtotal.reduce(
                                                        (value, element) {
                                                          return value +
                                                              element;
                                                        },
                                                      );
                                                      onChVat();
                                                    }
                                                  }

                                                  // subtotal[index] = 0;
                                                  // print(gSubtotal);
                                                });
                                                // menuController.quotArr[index]
                                                //     ['price'] = int.parse(val);
                                                // menuController.addq(index);
                                              },
                                              submitted: false,
                                              label: 'Price')),
                                    ],
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 10),
                                      child: Text(subtotal[index].toString())),
                                  TextButton(
                                    child: Text(
                                      'Clear',
                                      style: TextStyle(
                                        color: Colors.yellow[900],
                                      ),
                                    ),
                                    onPressed: () {
                                      quotArr[index]['description'].clear();
                                      quotArr[index]['condition'].clear();
                                      quotArr[index]['eta'].clear();
                                      quotArr[index]['price'].clear();
                                      quotArr[index]['quantity'].clear();
                                      gSubtotal = gSubtotal - subtotal[index];
                                      netTotal = netTotal - gSubtotal;

                                      setState(() {
                                        subtotal[index] = 0;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          )),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          // SizedBox(
                          //   width: 40,
                          // ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(5)),
                              height: 240,
                              width: 360,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 360,
                                    decoration: BoxDecoration(
                                        color: Colors.orange[900],
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        )),
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
                                                          TextStyle(
                                                              fontSize: 15)),
                                                  foregroundColor:
                                                      const MaterialStatePropertyAll(
                                                          Colors.white),
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Colors
                                                              .grey.shade800)),
                                              // icon: const Icon(
                                              //   Icons.save,
                                              // ),
                                              onPressed: () {
                                                navigationController.navigateTo(
                                                    EditClientR,
                                                    clientVals['id']);
                                              },
                                              child: const Text('Edit')),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          clientVals['unique_name'].toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          clientVals['name'].toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          clientVals['billing_address']
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${clientVals['bill_state'].toString()},\t${clientVals['bill_country'].toString()}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          clientVals['email'].toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          clientVals['phone'].toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                          const SizedBox(
                            width: 50,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(5)),
                              height: 240,
                              width: 360,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 360,
                                    decoration: BoxDecoration(
                                        color: Colors.orange[900],
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        )),
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
                                                          TextStyle(
                                                              fontSize: 15)),
                                                  foregroundColor:
                                                      const MaterialStatePropertyAll(
                                                          Colors.white),
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Colors
                                                              .grey.shade800)),
                                              // icon: const Icon(
                                              //   Icons.save,
                                              // ),
                                              onPressed: () {
                                                navigationController.navigateTo(
                                                    EditClientR, '');
                                              },
                                              child: const Text('Edit')),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          clientVals['unique_name'].toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          clientVals['name'].toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          clientVals['shipping_address']
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${clientVals['ship_state'].toString()},\t${clientVals['ship_country'].toString()}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          clientVals['email'].toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          clientVals['phone'].toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Colors.grey[800],
                        width: 450,
                        child: TextFieldSubmit(
                            controller: termsCtrl,
                            submitted: submitted,
                            label: 'Terms & Conditons'),
                      ),
                    ],
                  ),
                  Container(
                    width: 380,
                    height: 400,
                    decoration: BoxDecoration(color: Colors.grey[800]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText('SubTotal', 18, Colors.white,
                                  FontWeight.normal),
                              CustomText(
                                  '${menuController.curSign.value}${gSubtotal.toString()}',
                                  18,
                                  Colors.white,
                                  FontWeight.normal),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 120,
                                child: TextFieldSubmit(
                                  submitted: submitted,
                                  label: 'Delivery',
                                  onChanged: (val) {
                                    setState(() {
                                      if (val == '' || regex.hasMatch(val)) {
                                        delivery = 0.0;
                                        onChVat();
                                      } else {
                                        delivery = double.parse(val).toDouble();

                                        onChVat();
                                      }
                                    });
                                  },
                                ),
                              ),
                              CustomText(
                                  '${menuController.curSign.value}${delivery.toString()}',
                                  18,
                                  Colors.white,
                                  FontWeight.normal),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200,
                                child: TextFieldSubmit(
                                  submitted: submitted,
                                  label: 'CC',
                                  onChanged: (val) {
                                    setState(() {
                                      if (val == '' || regex.hasMatch(val)) {
                                        cc = 0.0;
                                        onChVat();
                                      } else {
                                        cc = double.parse(val).toDouble();

                                        onChVat();
                                      }
                                    });
                                  },
                                ),
                              ),
                              CustomText(
                                  '${menuController.curSign.value}${cc.toString()}',
                                  18,
                                  Colors.white,
                                  FontWeight.normal),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CustomText('VAT 20%', 18, Colors.white,
                                      FontWeight.normal),
                                  Checkbox(
                                      side:
                                          const BorderSide(color: Colors.white),
                                      activeColor: Colors.white,
                                      checkColor: Colors.black,
                                      value: isVat,
                                      onChanged: (val) {
                                        setState(() {
                                          isVat = val!;
                                          onChVat();
                                        });
                                      }),
                                ],
                              ),
                              CustomText(
                                  '${menuController.curSign.value}${nVat.toString()}',
                                  18,
                                  Colors.white,
                                  FontWeight.normal),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200,
                                child: TextFieldSubmit(
                                  submitted: submitted,
                                  label: 'Discount',
                                  onChanged: (val) {
                                    setState(() {
                                      if (val == '' || regex.hasMatch(val)) {
                                        discount = 0.0;
                                        onChVat();
                                      } else {
                                        discount = double.parse(val).toDouble();

                                        onChVat();
                                      }
                                    });
                                  },
                                ),
                              ),
                              CustomText(
                                  '-${menuController.curSign.value}${discount.toString()}',
                                  18,
                                  Colors.white,
                                  FontWeight.normal),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // const Divider(
                          //   height: 1,
                          //   color: Colors.black,
                          // ),
                          Container(
                            height: 65,
                            color: Colors.orange[900],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    CustomText('Total', 20, Colors.black,
                                        FontWeight.bold),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 24.0),
                                      child: Text(
                                        '(incl Vat)',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                CustomText(
                                    '${menuController.curSign.value}${netTotal.toString()}',
                                    20,
                                    Colors.black,
                                    FontWeight.bold),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
