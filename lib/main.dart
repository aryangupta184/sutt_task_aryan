import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sutt_task_aryan/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  var box = await dbcheck();


  runApp(MyApp());
}

int dbcheck(){
  if(Hive.isBoxOpen('mybox')==true){
    return 1;
  }
  else {
    Hive.openBox('mybox');
    return 1;
  }
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "SUTT Aryan Gupta",
      debugShowCheckedModeBanner: false,
      routeInformationParser: AppRouter().router.routeInformationParser,
      routerDelegate: AppRouter().router.routerDelegate,
    );
  }
}