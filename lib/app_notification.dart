import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppNotificationHandler {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    InitializationSettings initializationSettings =
        const InitializationSettings(
            android: AndroidInitializationSettings("@drawable/ic_notification"),
            iOS: DarwinInitializationSettings(
                requestAlertPermission: true,
                requestSoundPermission: true,
                requestBadgePermission: true));

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (NotificationResponse res) {
        debugPrint(
            "onDidReceiveBackgroundNotificationResponse  ${res.payload}    ");
      },
      onDidReceiveNotificationResponse: (NotificationResponse res) {
        debugPrint("onDidReceiveNotificationResponse  ${res.payload}    ");
      },
    );
  }

  /// FIREBASE NOTIFICATION SETUP
  static Future<void> firebaseNotificationSetup() async {
    ///firebase initiallize
    await Firebase.initializeApp();

    ///local notification...
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    ///IOS Setup
    DarwinInitializationSettings initializationSettings =
        const DarwinInitializationSettings(
            requestAlertPermission: true,
            requestSoundPermission: true,
            requestBadgePermission: true);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.initialize(initializationSettings);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    // Update the iOS foreground notification presentation options to allow
    // heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    ///Get FCM Token..
    await getFcmToken();
  }

  ///background notification handler..
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();

    // debugPrint('Handling a background message ${message.messageId}');
  }

  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
      "high_importance_channel", // id
      'high_importance_channel', // title
      description: "high_importance_channel", // description
      importance: Importance.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('apple_apple_iphone_60164')
      );

  ///get fcm token
  static Future<void> getFcmToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    try {
      String? token = await firebaseMessaging.getToken().catchError((e)
      // ignore: body_might_complete_normally_catch_error
      {
        debugPrint("=========fcm- Error ....:$e");
      });

      debugPrint("fcm-token :  $token");
    } catch (e) {
      debugPrint("=========fcm- Error :$e");
      return;
    }
  }

  ///call when app in fore ground
  static Future<void> showMsgHandler() async {
    // debugPrint('showMsgHandler...');
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;

        // AndroidNotification? android = message.notification?.android;

        debugPrint("-=-=-=-=-$message");
        // debugPrint("-=-=-=-=-${message.data}");

        // log('Notification Call :$android  ${notification?.apple}title---- ${notification!.title} body--- ${notification.body}');
        showMsg(notification!, message.data);
      },
      onDone: () {
        debugPrint("reMort on tap ++++++++++++++");
      },
      onError: (s, o) {
        debugPrint("reMort on tap error+++++++++++++ $o   $s   $o");
      },
    ).onError((e) {
      // debugPrint('Error Notification : ....$e');
    });
  }

  /// handle notification when app in fore ground..
  static void getInitialMsg() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      debugPrint(
          'tap on noTi function =========  $message  =======================');
    });
  }

  ///show notification msg
  static void showMsg(
      RemoteNotification notification, Map<String, dynamic> time) async{
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "high_importance_channel", // id
          'high_importance_channel', // title
          channelDescription: "high_importance_channel",
          // description
          importance: Importance.high,
          priority: Priority.high,
          icon: '@drawable/ic_notification',
          playSound: true,
          //
          /// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
          // actions: [
          //   AndroidNotificationAction("stop", "Stop"),
          // ],
          // ledOnMs: 1000,
          // ledOffMs: 500,
          sound:
              RawResourceAndroidNotificationSound('apple_apple_iphone_60164'),
        ),
      ),
    );
    // await FlutterRingtonePlayer.playNotification();
  }

  ///call when click on notification
  static onMsgOpen() {
    FirebaseMessaging.onMessageOpenedApp.listen(
      (
        RemoteMessage message,
      ) async {
        // debugPrint("-=-=-1=-=-$message");
        debugPrint("-=-=-1=-=-${message.notification!.title}");
        debugPrint("-=-=-1=-=-${message.notification!.body}");
        // debugPrint("-=-=-1=-=-${message.data}");

        // var dir = await DownloadsPathProvider.downloadsDirectory;

        // OpenFile.open("$dir");

        // // debugPrint("========  OnTap  =======");
        // if (message.data.toString() != "{}" ||
        //     message.data['type'] == "pay") {
        //   setRoute(message: message);
        // }
      },
      onDone: () {
        debugPrint("reMort on tap");
      },
      onError: (s, o) {
        debugPrint("reMort on tap error   $s   $o");
      },
    );
  }
}
