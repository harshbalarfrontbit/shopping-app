import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commaers/admin/auth/login/mobile_verify.dart';
import 'package:e_commaers/admin/auth/signup/signup_screen.dart';
import 'package:e_commaers/dashboard/home/home_screen.dart';
import 'package:e_commaers/user/user_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = true;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 50,
                      ),
                      height: 300,
                      decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const Image(
                          image: AssetImage('assets/images/e_commerce.png'),
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                    right: 10,
                    left: 10,
                  ),
                  child: TextFormField(
                    controller: username,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'name',
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, right: 10, left: 10),
                  child: TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'password is valid';
                      } else if (value.length < 8) {
                        return 'please enter 8 character';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: 'password',
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        debugPrint('required');

                        Get.offAll(() => const Home());
                        /*Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                            (route) => false);*/
                      } else {
                        debugPrint('not required');
                      }
                    },
                    child: const Text('login'),
                  ),
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Text('or Continue with'),
                    Expanded(
                      child: Divider(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        top: 20,
                        bottom: 20,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          padding: const EdgeInsets.all(10),
                        ),
                        onPressed: () {
                          signup(context);
                          // showLoader(context);
                          // FirebaseAuth.instance.currentUser!.uid;
                        },
                        child: const Image(
                          image: AssetImage('assets/images/google logo.png'),
                          height: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        top: 20,
                        bottom: 20,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          padding: const EdgeInsets.all(10),
                        ),
                        onPressed: () {},
                        child: const Image(
                          image: AssetImage('assets/images/apple-icon.png'),
                          height: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        top: 20,
                        bottom: 20,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          padding: const EdgeInsets.all(10),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Number(),
                            ),
                          );
                        },
                        child: const Image(
                          image: AssetImage('assets/images/mobile.png'),
                          height: 50,
                        ),
                      ),
                    ),
                  ],
                ),
                RichText(
                  text: TextSpan(
                    text: 'don t have an account? ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      color: Color(0xff999999),
                    ),
                    children: [
                      TextSpan(
                        text: 'Signup',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          color: Colors.blueGrey,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const Signup();
                                },
                              ),
                            );
                          },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signup(context) async {
    // try {
    showLoader(context);
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      // Getting users credential.
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;
      if (user != null) {
        debugPrint("user  $user");
        FirebaseFirestore.instance.collection("user").doc().set({
          "id": user.uid,
          "displayName": "${user.displayName}",
          "email": "${user.email}",
          "emailVerified": "${user.emailVerified}",
          "isAnonymous": "${user.isAnonymous}",
          "metadata": "${user.metadata}",
          "phoneNumber": "${user.phoneNumber}",
          "photoURL": "${user.photoURL}",
          "tenantId": "${user.tenantId}",
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserHome(),
          ),
        ).whenComplete(() {
          hideLoader(context);
        });
      }
    } else {
      hideLoader(context);
    }
    // } catch (e) {
    //   debugPrint('error = $e');
    // }
  }
}

void showLoader(context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );
}

void hideLoader(context) {
  Navigator.pop(context);
}
