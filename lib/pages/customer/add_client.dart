import 'package:client/API.dart';
import 'package:client/constants/ColorConst.dart';
import 'package:client/constants/controllers.dart';
import 'package:client/helpers/TextFieldSubmit.dart';
import 'package:client/helpers/drop_down.dart';
import 'package:client/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class AddClient extends StatefulWidget {
  const AddClient({super.key});

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  bool submitted = false;
  bool same = false;
  var activeVal = '';
  var indus = '';
  var language = '';
  var dcurrency = '';
  var payTerms = '';
  late ScrollController _scrollctrl;
  var data = {};
  final addCategoryCtrl = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

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

  final vat = ['Select Type', '10%'];
  final currency = ['Default Currency', 'Pound Sterling', 'Dollar'];
  final lang = ['Language', 'English', 'German', 'French'];
  final industry = [
    'Industry',
    'Ecommerce',
    'Software Development',
    'Hardware Services'
  ];
  final pterms = [
    'Payment Terms',
    'PrePaid',
    'COD',
    'Net-1',
    'Net-3',
    'Net-5',
    'Net-7',
    'Net-10',
    'Net-15',
    'Net-21',
    'Net-30'
  ];
  final active = ['Active', 'Yes', 'No'];

  void _submit(ctx) {
    print(shipAddrCtrl.text);
    setState(() {
      submitted = true;
    });
    // validate all the form fields
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      // on success, notify the parent widget
      onSubmit(ctx);
    }
  }

  succesModal() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop();
            navigationController.navigateTo(AllClientsR, '');
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
                  CustomText('Client Added Successfully', 20, Colors.white,
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

  final url = 'http://localhost:8000/api/clients';

  onSubmit(ctx) async {
    // setState(() {
    //   buttonText = 'loading...';
    // });

    data.addAll({
      'name': nameCtrl.text,
      'unique_name': cnameCtrl.text,
      'email': emailCtrl.text,
      'mobile': mobNumCtrl.text,
      'phone': phoneCtrl.text,
      'web_url': webCtrl.text,
      'fax': faxCtrl.text,
      'comp_reg_num': companyRegCtrl.text,
      'billing_address': billAddrCtrl.text,
      'shipping_address': shipAddrCtrl.text,
      'ship_city': sCityCtrl.text,
      'ship_state': sStateCtrl.text,
      'ship_country': sCountryCtrl.text,
      'ship_zip': sPostCodeCtrl.text,
      'bill_city': bCityCtrl.text,
      'bill_state': bStateCtrl.text,
      'bill_country': bCountryCtrl.text,
      'bill_zip': bPostCodeCtrl.text,
      'vat_number': vatNumCtrl.text,
      'language': menuController.language.value,
      'payment_opt': menuController.pterms.value,
      'industry': menuController.industry.value,
      'currency': menuController.currency.value,
    });
    // var res = await postData('register', data);
    // var endres = res.data;
    var res = await postData(url, data);
    var json = res.data;

    if (json['message'] == 'success') {
      succesModal();
      // navigationController.navigateTo(AllClientsR);
    }
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
  void initState() {
    _scrollctrl = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[850],
      child: WebSmoothScroll(
        controller: _scrollctrl,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _scrollctrl,
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'EZONE TECNOLOGIES',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                const SizedBox(
                  height: 60,
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.only(left: 20, top: 15),
                              color: Colors.yellow[900],
                              height: 50,
                              width: 620,
                              child: const Text(
                                'Client',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 450,
                            child: TextFieldSubmit(
                                controller: cnameCtrl,
                                submitted: submitted,
                                label: 'Company Name'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 450,
                            child: TextFieldSubmit(
                                controller: nameCtrl,
                                submitted: submitted,
                                label: 'Client Name'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 450,
                            child: TextFieldSubmit(
                                controller: emailCtrl,
                                submitted: submitted,
                                label: 'Email Address'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 450,
                            child: TextFieldSubmit(
                                controller: phoneCtrl,
                                submitted: submitted,
                                label: 'Phone Number'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 450,
                            child: TextFieldSubmit(
                                controller: faxCtrl,
                                submitted: submitted,
                                label: 'Fax Number'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 450,
                            child: TextFieldSubmit(
                                controller: mobNumCtrl,
                                submitted: submitted,
                                label: 'Mobile Number'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 450,
                            child: TextFieldSubmit(
                                controller: companyRegCtrl,
                                submitted: submitted,
                                label: 'Company Reg#'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 450,
                            child: TextFieldSubmit(
                                controller: vatNumCtrl,
                                submitted: submitted,
                                label: 'Vat Number'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 450,
                            child: TextFieldSubmit(
                                controller: webCtrl,
                                submitted: submitted,
                                label: 'Website'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const VerticalDivider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.only(left: 20, top: 15),
                              color: Colors.yellow[900],
                              height: 50,
                              width: 620,
                              child: const Text(
                                'Address',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 450,
                            child: TextFieldSubmit(
                                controller: billAddrCtrl,
                                submitted: submitted,
                                label: 'Billing Address'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextFieldSubmit(
                                    controller: bCityCtrl,
                                    submitted: submitted,
                                    label: 'City'),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 100,
                                child: TextFieldSubmit(
                                    controller: bStateCtrl,
                                    submitted: submitted,
                                    label: 'State'),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 100,
                                child: TextFieldSubmit(
                                    controller: bPostCodeCtrl,
                                    submitted: submitted,
                                    label: 'Postal Code'),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 100,
                                child: TextFieldSubmit(
                                    controller: bCountryCtrl,
                                    submitted: submitted,
                                    label: 'Country'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Row(
                            children: [
                              const Text(
                                'Same As Billing Adddress',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Switch(
                                  activeColor: Colors.yellow[900],
                                  activeTrackColor: Colors.yellow[600],
                                  value: same,
                                  onChanged: (val) {
                                    setState(() {
                                      same = val;
                                      if (val) {
                                        shipAddrCtrl.text = billAddrCtrl.text;
                                        sCountryCtrl.text = bCountryCtrl.text;
                                        sStateCtrl.text = bStateCtrl.text;
                                        sPostCodeCtrl.text = bPostCodeCtrl.text;
                                        sCityCtrl.text = bCityCtrl.text;
                                      } else {
                                        shipAddrCtrl.text = '';
                                        sCountryCtrl.text = '';
                                        sStateCtrl.text = '';
                                        sPostCodeCtrl.text = '';
                                        sCityCtrl.text = '';
                                      }
                                    });
                                  }),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 450,
                            child: TextFieldSubmit(
                                controller: shipAddrCtrl,
                                submitted: submitted,
                                label: 'Shipping Address'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 100,
                                child: TextFieldSubmit(
                                    controller: sCityCtrl,
                                    submitted: submitted,
                                    label: 'City'),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 100,
                                child: TextFieldSubmit(
                                    controller: sStateCtrl,
                                    submitted: submitted,
                                    label: 'State'),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 100,
                                child: TextFieldSubmit(
                                    controller: sPostCodeCtrl,
                                    submitted: submitted,
                                    label: 'Postal Code'),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 100,
                                child: TextFieldSubmit(
                                    controller: sCountryCtrl,
                                    submitted: submitted,
                                    label: 'Country'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                    padding: const EdgeInsets.only(left: 20, top: 15),
                    color: Colors.yellow[900],
                    height: 50,
                    width: double.infinity,
                    child: const Text(
                      'Other Info',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    )),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        width: 450,
                        child: CustomDropDown(
                            onChange: (value) {
                              if (value != currency[0]) {
                                setState(() {
                                  dcurrency = value!;
                                });
                              } else {
                                setState(() {
                                  dcurrency = '';
                                });
                              }
                            },
                            initVal: '',
                            submitted: submitted,
                            dlist: currency)),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                        width: 450,
                        child: CustomDropDown(
                            onChange: (value) {
                              if (value != lang[0]) {
                                setState(() {
                                  language = value!;
                                });
                              } else {
                                setState(() {
                                  language = '';
                                });
                              }
                            },
                            initVal: '',
                            submitted: submitted,
                            dlist: lang)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        width: 450,
                        child: CustomDropDown(
                            onChange: (value) {
                              if (value != pterms[0]) {
                                setState(() {
                                  payTerms = value!;
                                });
                              } else {
                                setState(() {
                                  payTerms = '';
                                });
                              }
                            },
                            initVal: '',
                            submitted: submitted,
                            dlist: pterms)),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                        width: 450,
                        child: CustomDropDown(
                            onChange: (value) {
                              if (value != industry[0]) {
                                setState(() {
                                  indus = value!;
                                });
                              } else {
                                setState(() {
                                  indus = '';
                                });
                              }
                            },
                            initVal: '',
                            submitted: submitted,
                            dlist: industry)),
                  ],
                ),

                // const SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     SizedBox(
                //         width: 450,
                //         child: CustomDropDown(submitted: submitted, dlist: vat)),
                //     // const SizedBox(
                //     //   width: 20,
                //     // ),
                //     // SizedBox(
                //     //     width: 450,
                //     //     child: CustomDropDown(submitted: submitted, dlist: vat)),
                //   ],
                // ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.yellow[900])),
                      onPressed: () {
                        _submit(context);
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
