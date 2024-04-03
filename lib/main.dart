import 'dart:async';
import 'dart:html' as web;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PushNotificationApp(),
    );
  }
}

/// Entry point for the example application.
class PushNotificationApp extends StatefulWidget {
  static const routeName = "/firebase-push";

  @override
  _PushNotificationAppState createState() => _PushNotificationAppState();
}

class _PushNotificationAppState extends State<PushNotificationApp> {
  @override
  void initState() {
    getPermission();
    messageListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return NotificationPage();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<void> getPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  void messageListener(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
  }
}

class NotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<NotificationPage> {
  late String _token;
  int notificationCount = 0;

  void setToken(String token) {
    print('FCM TokenToken: $token');
    setState(() {
      _token = token;
    });
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  Future<void> getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken(
        vapidKey:
            "BHjIj9cxG9O1ZGwHt4FpOzQPuj6zZjvAFxqp602U_Eby3kcCEBpMy05Jm0QIuJsL5Zl3X9T8dfTyeIS4nZ8tths");
    //get token
    setToken(fcmToken!);
    FirebaseMessaging.instance.getToken().then((value) => setToken(value!));
    FirebaseMessaging.instance.onTokenRefresh.listen(setToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Firebase push notification'),
        ),
        body: Center(
          child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 10,
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    var permission = web.Notification.permission;
                    if (permission != 'granted') {
                      permission = await web.Notification.requestPermission();
                    }
                    if (permission == 'granted') {
                      web.Notification( 'hello world ' );
                    }
                  },
                  child: const Text('push notification'),
                ),
              )),
        ));
  }
}
