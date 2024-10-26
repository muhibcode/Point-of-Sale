import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class TextFieldSubmit extends StatefulWidget {
  final submitted;
  final String label;
  final controller;
  final rOnly;
  final focusNode;
  final onTap;
  final onChanged;

  const TextFieldSubmit({
    super.key,
    this.rOnly,
    this.controller,
    required this.submitted,
    required this.label,
    this.onChanged,
    this.focusNode,
    this.onTap,
  });
  @override
  State<TextFieldSubmit> createState() => _TextFieldSubmitState();
}

class _TextFieldSubmitState extends State<TextFieldSubmit> {
  bool _obscure = true;
  String pass = '';
  String cpass = '';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      cursorColor: Colors.yellow[900],
      maxLines: widget.label.toString().contains('Billing') ||
              widget.label.toString().contains('Shipping') ||
              widget.label.toString().contains('Terms') ||
              widget.label.toString().contains('Footer')
          ? 6
          : widget.label.toString().contains('Description')
              ? 3
              : 1,
      keyboardType: widget.label == 'OTP'
          ? TextInputType.number
          : widget.label == 'Email' || widget.label.contains('Password')
              ? TextInputType.emailAddress
              : TextInputType.text,
      readOnly: widget.rOnly == true ? widget.rOnly : false,
      obscureText: widget.label.contains('Password') ? _obscure : false,
      autovalidateMode: widget.submitted
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      controller: widget.controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow.shade900)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow.shade900)),
          errorStyle: TextStyle(color: Colors.yellow[900]),
          border: OutlineInputBorder(),
          // enabledBorder: OutlineInputBorder(
          //     borderSide: BorderSide(color: Colors.yellow.shade900)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.yellow.shade900)),
          suffixIcon: widget.label.contains('Password')
              ? Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                    child: Icon(
                      _obscure ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                )
              : null,
          labelText: widget.label,
          labelStyle: const TextStyle(color: Colors.white)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required field';
        }

        // if (widget.label == 'OTP') {
        //   if (value.isNotEmpty && RegExp(r'^[a-z]+$').hasMatch(value)) {
        //     return 'Please Enter Valid OTP in digits';
        //   }
        // }
        if (widget.label == 'OTP') {
          if (value.isNotEmpty && RegExp(r'^[a-z]+$').hasMatch(value)) {
            return 'Please Enter Valid OTP in digits';
          }
        }
        if (widget.label == 'Email') {
          var isValid = EmailValidator.validate(value);
          if (!isValid && value.isNotEmpty) {
            return 'Invalid Email';
          }
        }

        return null;
      },
    );
  }
}
