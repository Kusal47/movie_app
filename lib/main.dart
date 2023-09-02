import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:movieapp/Login%20Register/viewmodel.dart';
import 'package:provider/provider.dart';
import 'Home Page/home.dart';
import 'Login Register/login_page.dart';
import 'const/export.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(),
      child: KhaltiScope(
          publicKey: 'test_public_key_d5d9f63743584dc38753056b0cc737d5',
          enabledDebugging: true,
          builder: (context, navKey) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
                theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.transparent,
        ),
              title: AppStrings.appName,
              home: const SplashScreen(),
              navigatorKey: navKey,
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
            );
          }),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return const HomePage();
                      } else {
                        return const LoginPage();
                      }
                    }))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[100],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 90,
                child: Image.asset(AssetsPath.logo),
              ),
              const DefaultTextStyle(
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                  child: Text(
                    AppStrings.appName,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: const LinearProgressIndicator(
                  backgroundColor: Colors.black,
                  minHeight: 5,
                ),
              )
            ],
          ),
        ));
  }
}
