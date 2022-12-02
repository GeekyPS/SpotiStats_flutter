import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:flutter_complete_guide/splash.dart';
import 'package:google_fonts/google_fonts.dart';
void main() async {
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotistats',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.black,
        fontFamily: GoogleFonts.barlow().fontFamily,
        textTheme: ThemeData.light().textTheme.copyWith(
            headline1: TextStyle(
                fontSize: 16,
                fontFamily: GoogleFonts.barlow().fontFamily,
                fontWeight: FontWeight.w500)),
      ),
      routes: {
        '/': (context) => SplashScreen(),
      },
    );
  }
}

class MyHomepage extends StatefulWidget {
  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sign up now"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(hintText: 'Password'),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
