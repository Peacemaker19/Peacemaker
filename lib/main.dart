import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:peacemaker/noti.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Noti.initialize(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.blue.withOpacity(0.5),
          ),
          body: Center(
            child: SizedBox(
              width: 200,
              height: 200,
              child: Column(
                children: [
                  const ElevatedButton(
                      onPressed: getFcmToken, child: Text('GetToken')),
                  ElevatedButton(
                    onPressed: () {
                      Noti.showBigTextNotification(
                          title: "Peacemaker",
                          body: "You only live once..",
                          fln: flutterLocalNotificationsPlugin);
                    },
                    child: const Text("Notify me"),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

void getFcmToken() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
}
