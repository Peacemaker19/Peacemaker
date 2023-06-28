import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:peacemaker/feature/authentication/cubit/authetication_cubit.dart';
import 'package:peacemaker/feature/authentication/screen/authentication.dart';

import 'feature/authentication/cubit/authetication_state.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp();
  //final fcmToken = await FirebaseMessaging.instance.getToken();
  runApp(EasyLocalization(
    supportedLocales: const [
      Locale("en"),
      Locale("de"),
    ],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
    saveLocale: false,
    useOnlyLangCode: true,
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AutheticationCubit(AutheticationInitial()))
      ],
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  AutheticationCubit? autheticationCubit;
  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren((rebuild));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      home: const AuthScreen(),
    );
  }
}
