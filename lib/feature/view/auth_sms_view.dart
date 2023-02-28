import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sms_auth/feature/view/otp_verification_view.dart';
import 'package:flutter/material.dart';

class AuthSmsView extends StatelessWidget {
  const AuthSmsView({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "Phone Number"),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '+44 7123 123 456',
                    verificationCompleted:
                        (PhoneAuthCredential credential) async {
                      await auth.signInWithCredential(credential);
                    },
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            OtpVerificationView(verificationId: verificationId),
                      ));
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                },
                child: const Text("Next Otp")),
          ],
        ),
      ),
    );
  }
}
