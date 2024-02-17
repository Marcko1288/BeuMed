import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:beumed/Class/Model/Enum_SelectionView.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';
import '../Library/FireAuth.dart';
import '../Model/TextFieldCustom.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  String mail = "";
  String password = "";
  bool secure = true;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var master = Provider.of<Master>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            master.selectionView.value,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image(image: AssetImage('images/logo.png')),
            ),
            AutofillGroup(
              child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFieldCustom(
                        text_labol: 'Mail',
                        text_default: widget.mail,
                        keyboardType: TextInputType.emailAddress,
                        onStringChanged: (String value) {
                          setState(() {
                            widget.mail = value;
                          });
                        },
                        autofill: [AutofillHints.email],
                        decoration: TypeDecoration.labolBord,
                        listValidator: [
                          TypeValidator.required,
                          TypeValidator.email
                        ],
                      ),
                      TextFieldCustom(
                        text_labol: 'Password',
                        text_default: widget.password,
                        secure: widget.secure,
                        onStringChanged: (String value) {
                          setState(() {
                            widget.password = value;
                          });
                        },
                        autofill: [AutofillHints.password],
                        decoration: TypeDecoration.labolBord,
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.only(left: 40),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       TextFieldCustom(
                      //         text_labol: 'Password',
                      //         text_default: widget.password,
                      //         secure: widget.secure,
                      //         onStringChanged: (String value) {
                      //           setState(() {
                      //             widget.password = value;
                      //           });
                      //         },
                      //         autofill: [AutofillHints.password],
                      //         decoration: TypeDecoration.labolBord,
                      //       ),
                      //
                      //       IconButton(
                      //           onPressed: changeSecure,
                      //           icon: widget.secure
                      //               ? const Icon(Icons.visibility)
                      //               : const Icon(Icons.visibility_off)),
                      //     ],
                      //   ),
                      // ),

                      TextButton(
                          onPressed: () {
                            routeNewPassword(context);
                          },
                          child: const Text(
                            'Password Dimenticata?',
                            style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                            ),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed:  () {routeLogin();},
                          child: const Text('Login'),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.only(
                                    left: 80, right: 80, top: 20, bottom: 20)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  void changeSecure() {
    setState(() {
      if (widget.secure == true) {
        widget.secure = false;
      } else {
        widget.secure = true;
      }
    });
  }

  void routeNewPassword(BuildContext contextT) {
    Navigator.pushNamed(contextT, SelectionView.ResetPassword.route,
        arguments: RouteElement(SelectionView.ResetPassword.value, null));
  }

  Future<void> routeLogin() async {
    var master = Provider.of<Master>(context, listen: false);

    if(_formKey.currentState!.validate()){
      try {
        await Auth().signInWithEmailAndPassword(
            email: widget.mail, password: widget.password);
        print('Accesso OK');
      } on FirebaseAuthException catch (error) {
        print('${error.toString()}');
        setState(() {
          master.gestion_Message('Autentificazione Fallita! Verificare Email/Passord inseriti. \n ${error.toString()}');
        });
      }
    }
  }
}