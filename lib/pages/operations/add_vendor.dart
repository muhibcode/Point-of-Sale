import 'package:client/helpers/TextFieldSubmit.dart';
import 'package:flutter/material.dart';

class AddOrders extends StatefulWidget {
  AddOrders({super.key});

  @override
  State<AddOrders> createState() => _AddOrdersState();
}

class _AddOrdersState extends State<AddOrders> {
  bool submitted = false;

  final addCategoryCtrl = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void _submit(ctx) {
    setState(() {
      submitted = true;
    });
    // validate all the form fields
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      // on success, notify the parent widget
      // onSubmit(ctx);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 400,
                child: TextFieldSubmit(
                    controller: addCategoryCtrl,
                    submitted: submitted,
                    label: 'Product Name'),
              ),
              SizedBox(
                width: 400,
                child: TextFieldSubmit(
                    controller: addCategoryCtrl,
                    submitted: submitted,
                    label: 'Price'),
              ),
              SizedBox(
                width: 400,
                child: TextFieldSubmit(
                    controller: addCategoryCtrl,
                    submitted: submitted,
                    label: 'Part Number'),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 450,
                child: TextFieldSubmit(
                    controller: addCategoryCtrl,
                    submitted: submitted,
                    label: 'Part Number'),
              ),
              SizedBox(
                width: 450,
                child: TextFieldSubmit(
                    controller: addCategoryCtrl,
                    submitted: submitted,
                    label: 'SKU'),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 400,
                child: TextFieldSubmit(
                    controller: addCategoryCtrl,
                    submitted: submitted,
                    label: 'Vendor Name'),
              ),
              SizedBox(
                width: 400,
                child: TextFieldSubmit(
                    controller: addCategoryCtrl,
                    submitted: submitted,
                    label: 'Place of Shipment'),
              ),
              SizedBox(
                width: 400,
                child: TextFieldSubmit(
                    controller: addCategoryCtrl,
                    submitted: submitted,
                    label: 'Vendor Address'),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          // SizedBox(
          //     width: 400,
          //     child: CustomDropDown(
          //       submitted: submitted,
          //     )),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 40,
            child: ElevatedButton(
                onPressed: () {
                  _submit(context);
                },
                child: const Text('Submit')),
          )
        ],
      ),
    );
  }
}
