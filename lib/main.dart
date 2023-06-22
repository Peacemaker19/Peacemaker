import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: Peacemaker()));
}

class Peacemaker extends StatefulWidget {
  const Peacemaker({super.key});

  @override
  State<Peacemaker> createState() => _PeacemakerState();
}

void getfcmtoken() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('Notifyme: $fcmToken');
}

class _PeacemakerState extends State<Peacemaker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notification")),
      body: const Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: getfcmtoken, child: Text('Notify Me')),
          ],
        ),
      ),
    );
  }
}
