import 'package:client/helpers/TextFieldSubmit.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool submitted = false;
  final _formkey = GlobalKey<FormState>();

  final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();


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
    return Center(
      child: Container(
         decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[800],),
            width: 500,
            height: 350,
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 450,
                child: TextFieldSubmit(
                    controller: emailCtrl, submitted: submitted, label: 'Email'),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 450,
                child: TextFieldSubmit(
                    controller: passwordCtrl, submitted: submitted, label: 'Password'),
              ),
              const SizedBox(
                height: 30,
              ),
             Center(
                                child: SizedBox(
                                  height: 38,
                                  child: ElevatedButton.icon(
                                      style: ButtonStyle(
                                          textStyle: const MaterialStatePropertyAll(
                                              TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                          foregroundColor:
                                              const MaterialStatePropertyAll(
                                                  Colors.black),
                                          backgroundColor: MaterialStatePropertyAll(
                                              Colors.yellow.shade900)),
                                      icon: const Icon(
                                        Icons.login,
                                      ),
                                      onPressed: () {
                                        _submit(context);
                                        // qouteSubmit();
                                        // succesModal();
                                        // Navigator.pop(context);
            
                                        // Timer(
                                        //     Duration(seconds: 5),
                                        //     () => navigationController
                                        //         .navigateTo(AddClientR));
            
                                        // print(subQou);
                                      },
                                      label: const Text('Login')),
          ))],
          ),
        ),
      ),
    );
  }
}
