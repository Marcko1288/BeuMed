import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Class/Master.dart';
import '../Library/FireAuth.dart';

class ResetPasswordView extends StatefulWidget {
  ResetPasswordView({super.key});

  String mail = "";

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size_width = MediaQuery
        .of(context)
        .size
        .width * 0.4;
    var size_width_padding = defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android
        ? 10.0
        : 100.0;
    var size_text = defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android
        ? 18.0
        : 20.0;

    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: const Text(
            "Reset Password",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size_width_padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Mail
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: size_width,
                          child: Text(
                            'Mail *',
                            style: TextStyle(
                                fontSize: size_text,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      // TextFieldCustom(
                      //   text: 'Mail',
                      //   modify_text: widget.mail,
                      //   keyboardType: TextInputType.emailAddress,
                      //   decoration: TypeDecoration.focusBord,
                      //   onStringChanged: (String value) {
                      //     setState(() {
                      //       widget.mail = value;
                      //     });
                      //   },
                      //   listValidator: [
                      //     TypeValidator.required,
                      //     TypeValidator.email
                      //   ],
                      // ),

                    ],
                  ),

                  //Button Registra
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: resetPassword,
                      child: Text('INVIA'),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.only(
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
      ),
    );
  }

  Future<void> resetPassword() async {
    var master = Provider.of<Master>(context, listen: false);

    if(_formKey.currentState!.validate()){
      try {
        await Auth().sendPasswordResetEmail(email: widget.mail);
        print('Reset Password OK');
        setState(() {
          master.gestion_Message('Password Resettata, controllare la mail.');
        });
      } on FirebaseAuthException catch (error) {
        print('${error.toString()}');
        setState(() {
          master.gestion_Message('Errore nel reset \n${error.toString()}');
        });
      }
    }

  }
}