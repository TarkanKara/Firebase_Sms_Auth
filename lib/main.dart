import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_sms_auth/feature/view/auth_sms_view.dart';
import 'package:firebase_sms_auth/feature/view/otp_verification_view.dart';
import 'package:firebase_sms_auth/feature/view/success_view.dart';
import 'package:firebase_sms_auth/firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const AuthSmsView(),
        "/otp": (context) =>  OtpVerificationView(),
        "/success": (context) => const SuccessView(),
      },
      title: 'Sms_Auth',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home:
    );
  }
}
