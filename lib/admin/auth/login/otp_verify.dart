import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpNumber extends StatefulWidget {
  const OtpNumber({Key? key}) : super(key: key);

  @override
  State<OtpNumber> createState() => _OtpNumberState();
}

class _OtpNumberState extends State<OtpNumber> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Pinput(
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
            validator: (s) {
              return s == '2222' ? null : 'Pin is incorrect';
            },
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            length: 6,
            onCompleted: (pin) => debugPrint(pin),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                padding: const EdgeInsets.all(10),
              ),
              onPressed: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                //otp verify
                var credential = PhoneAuthProvider.credential(
                    verificationId:
                    "AL3R4eQzXYzxvFTbs9ykDXpAYQ8qoDN4OMe0jf3epLod45SK8ndcGFMFUY92f6FugaJK4vHP3QE44Ydb8ZYua1ngtmizWhOc1aTgCOGdU0RoF-K9yBe72CENVKwkkpvOdaaJ7oSkT9z-sI5lTSyz3y9Azs9IOuv5o8Np6LxXlCllZ0w2lt_H-hgbTp9hBOwdRi1q9BcP16od1lc0MBy9JR1k3bjFPI9Z8fu3HGrxox0AlYHTymzqBug",
                    smsCode: "077259  ");
                auth.signInWithCredential(credential).then((result) {
                  debugPrint('user   ${result.user}');
                }).catchError((e) {
                  debugPrint(e);
                  //error
                });
              },
              child: const Text("submit"),
            ),
          ),
        ],
      ),
    );
  }
}
