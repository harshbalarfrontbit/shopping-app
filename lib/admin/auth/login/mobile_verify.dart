import 'package:e_commaers/admin/auth/login/otp_verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Number extends StatefulWidget {
  const Number({Key? key}) : super(key: key);

  @override
  State<Number> createState() => _NumberState();
}

class _NumberState extends State<Number> {
  TextEditingController mobileNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 10, right: 10, bottom: 50),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter your number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  controller: mobileNumber,
                  decoration: const InputDecoration(
                    labelText: 'phone number',
                    hintText: 'enter a number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth auth = FirebaseAuth.instance;

                  auth.verifyPhoneNumber(
                      phoneNumber: "+91${mobileNumber.text}",
                      timeout: const Duration(seconds: 60),
                      verificationCompleted: (AuthCredential authCredential) {
                        auth
                            .signInWithCredential(authCredential)
                            .then((result) {
                          debugPrint('user   ${result.user}');
                        }).catchError((e) {
                          debugPrint(e);
                        });
                      },
                      verificationFailed: (authException) {
                        debugPrint(authException.message);
                      },
                      codeSent:
                          (String verificationId, int? forceResendingToken) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const OtpNumber();
                            },
                          ),
                        );

                        debugPrint("id: $verificationId");
                        debugPrint("id: $forceResendingToken");
                        //otp
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {
                        verificationId = verificationId;
                        debugPrint(verificationId);
                        debugPrint("Timeout");
                      });
                },
                child: const Text('save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
