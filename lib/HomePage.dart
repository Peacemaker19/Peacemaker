import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:peacemaker/feature/authentication/cubit/authetication_cubit.dart';
import 'package:peacemaker/feature/authentication/cubit/authetication_state.dart';
import 'package:peacemaker/noti.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Locale? locale = const Locale("en");
  AutheticationCubit? authenticationCubit;
  @override
  void initState() {
    authenticationCubit = BlocProvider.of<AutheticationCubit>(context);
    super.initState();
  }

  void myMethod() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutheticationCubit, AutheticationState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 15,
          title: Text(tr('Hello User..')),
          backgroundColor: Colors.blue.withOpacity(0.5),
          actions: [
            IconButton(
                onPressed: () {
                  authenticationCubit?.logoutUser();
                  myMethod();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(tr('hello')),
                  ElevatedButton(
                    onPressed: () {
                      authenticationCubit?.changeLocale(context, "de");
                    },
                    child: const Text('Change Text to German'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      authenticationCubit?.changeLocale(context, "en");
                    },
                    child: const Text('Change Text to English'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      log('message');
                      Noti.showBigTextNotification(
                          title: "Peacemaker",
                          body: "You only live once..",
                          fln: flutterLocalNotificationsPlugin);
                    },
                    child: const Text("Notify me"),
                  ),
                ],
              ),
            )),
      );
    });
  }
}
