import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_sms_auth/feature/view/auth_sms_view.dart';
import 'package:firebase_sms_auth/feature/view/otp_verification_view.dart';
import 'package:firebase_sms_auth/feature/view/success_view.dart';
import 'package:firebase_sms_auth/feature/viewModel/cubit/auth_cubit.dart';
import 'package:firebase_sms_auth/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sms_Auth',
        theme: ThemeData(useMaterial3: true),
        initialRoute: "/",
        routes: {
          "/": (context) =>  AuthSmsView(),
          "/otp": (context) => const OtpVerificationView(),
          "/success": (context) => const SuccessView(),
        },
      ),
    );
  }
}
