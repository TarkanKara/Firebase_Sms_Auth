// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sms_auth/feature/view/success_view.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationView extends StatelessWidget {
  final String? verificationId;

  const OtpVerificationView({super.key, this.verificationId});

  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();

    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Verification Code",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                    ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                child: Center(
                  child: Pinput(
                    controller: otpController,
                    length: 6,
                    defaultPinTheme: PinTheme(
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Colors.red),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              InkWell(
                onTap: () async {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId!,
                    smsCode: otpController.text,
                  );
                  // Sign the user in (or link) with the credential
                  await auth.signInWithCredential(credential);
                  if (auth.currentUser?.uid != null) {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const SuccessView(),
                    ));
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.green,
                  ),
                  child: Center(
                    child: Text(
                      "LOGIN",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
