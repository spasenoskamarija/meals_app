import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meals_app/screens/categories_page.dart';
import 'package:meals_app/screens/meals_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    initNotifications();
  }

  Future<void> initNotifications() async {
    final settings = await FirebaseMessaging.instance.requestPermission();
    print("Permission: ${settings.authorizationStatus}");


    await FirebaseMessaging.instance.subscribeToTopic("daily_recipe");
    print("Subscribed to topic: daily_recipe");


    final token = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $token");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TheMealDB Recipes",
      theme: ThemeData(primarySwatch: Colors.deepOrange),
        initialRoute: "/",
        routes: {
          "/": (context) => const CategoriesPage(),
          "/meals": (context) {
            final categoryName = ModalRoute.of(context)!.settings.arguments as String;
            return MealsPage(category: categoryName);
          },
        }
    // home: CategoriesPage(),
    );
  }
}

