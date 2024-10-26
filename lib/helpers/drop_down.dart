import 'package:client/constants/controllers.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final bool submitted;
  final List<String> dlist;
  final String initVal;
  final onChange;

  CustomDropDown({
    super.key,
    required this.submitted,
    required this.dlist,
    required this.initVal,
    required this.onChange,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  List<String> vat = [];
  var newval = '';
  String vatType = '';

  @override
  initState() {
    setArr();
    menuController.setDropDown(widget.dlist[0], widget.initVal);

    super.initState();
  }

  setArr() {
    // for (var e in widget.dlist) {
    //   vat.add(e);
    // }
    setState(() {
      vat = widget.dlist;
    });
  }

  vatDropDown() {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow.shade900)),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              label: Text(
                widget.initVal.isEmpty ? '' : vat[0],
                style: const TextStyle(color: Colors.white),
              ),
              errorText: widget.submitted && widget.initVal.isEmpty
                  ? 'Required Field'
                  : null,
              // labelStyle: textStyle,
              errorStyle:
                  TextStyle(fontSize: 12.0, color: Colors.yellow.shade900),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
          // isEmpty: _currentSelectedValue == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: widget.initVal.isEmpty ? vat[0] : widget.initVal,
              isDense: true,
              onChanged: widget.onChange,
              // onChanged: (value) {
              //   setState(() {
              //     vat[0] = value!;
              //     // vatType = value;
              //     // newval = value;
              //     // print(vatType);
              //   });
              //   // if (value != vat[0]) {
              //   //   // menuController.setDropDown(vat[0], value!);
              //   //   // menuController.setCurCode(value);
              //   //   setState(() {
              //   //     vat[0] = value!;
              //   //     // vatType = value;
              //   //     // newval = value;
              //   //     // print(vatType);
              //   //   });
              //   // } else {
              //   //   menuController.setDropDown(vat[0], '');

              //   //   setState(() {
              //   //     vatType = '';
              //   //   });
              //   // }
              // },
              items: vat.map((String value) {
                return DropdownMenuItem<String>(
                    value: value, child: Text(value.toString()));
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return vatDropDown();
  }
}
