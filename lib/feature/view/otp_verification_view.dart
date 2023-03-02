// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:firebase_sms_auth/feature/utils/snackbar.dart';
import 'package:firebase_sms_auth/feature/view/success_view.dart';
import 'package:firebase_sms_auth/feature/viewModel/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationView extends StatelessWidget {
  final String? verificationId;
  const OtpVerificationView({super.key, this.verificationId});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.read<AuthCubit>().isLoading;
    TextEditingController otpController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
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
                          onCompleted: (value) {
                            context.read<AuthCubit>().otpSetState(value);
                          },
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
                      onTap: () {
                        if (context.read<AuthCubit>().otpCodee != null) {
                          final ap = context.read<AuthCubit>();
                          ap.verificationOTP(
                            context: context,
                            verificationId: verificationId!,
                            smsCode: ap.otpCodee!,
                            onSuccess: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SuccessView(),
                                  ));
                            },
                          );
                        } else {
                          showSnackBar(context, "6 Karekterden az olamaz");
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
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
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
