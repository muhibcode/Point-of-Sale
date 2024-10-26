import 'package:client/API.dart';
import 'package:client/constants/controllers.dart';
import 'package:client/helpers/TextFieldSubmit.dart';
import 'package:client/routing/routes.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool submitted = false;

  final nameCtrl = TextEditingController();

  final emailCtrl = TextEditingController();

  final passwordCtrl = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  final data = {};

  final url = Uri.parse('http://localhost:8000/api/register');

  void _submit(ctx) {
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

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  onSubmit(ctx) async {
    // setState(() {
    //   buttonText = 'loading...';
    // });
    data.addAll({
      'name': nameCtrl.text,
      'email': emailCtrl.text,
      'password': passwordCtrl.text
    });
    // http.MultipartFile.fromString();
    var res = await postData(url, data);
    var json = res.data;
    if (json['message'] == 'success') {
      navigationController.navigateTo(AllClientsR, '');
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
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[800],
          ),
          width: 500,
          height: 500,
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Registeration',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 450,
                  child: TextFieldSubmit(
                      controller: nameCtrl,
                      submitted: submitted,
                      label: 'Name'),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 450,
                  child: TextFieldSubmit(
                      controller: emailCtrl,
                      submitted: submitted,
                      label: 'Email'),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 450,
                  child: TextFieldSubmit(
                      controller: passwordCtrl,
                      submitted: submitted,
                      label: 'Password'),
                ),
                const SizedBox(
                  height: 40,
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
                        icon: const Icon(
                          Icons.app_registration,
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
                        label: const Text('Register')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
