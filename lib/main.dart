import 'package:e_commaers/app_notification.dart';
import 'package:e_commaers/user/user_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

bool isAdmin = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp()
      .then((value) => debugPrint("flutter firebase run successfully"));
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // FirebaseCrashlytics.instance.crash();

  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(
    () => debugPrint('successful'),
  );*/

  await AppNotificationHandler.firebaseNotificationSetup();
  AppNotificationHandler.getInitialMsg();
  AppNotificationHandler.showMsgHandler();
  AppNotificationHandler.onMsgOpen();
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    // home: ChatScreen(
    //     receiverId: "HarshBhai", senderId: "Pratikbhai", name: "Harsh Bhai"),
    home: UserHome(),
  ));
}




