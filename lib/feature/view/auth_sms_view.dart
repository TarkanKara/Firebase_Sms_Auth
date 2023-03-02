import 'package:firebase_sms_auth/feature/view/otp_verification_view.dart';
import 'package:firebase_sms_auth/feature/viewModel/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../product/widget/custom_dropdownfield.dart';
import '../../product/widget/custom_elevated_btn.dart';

class AuthSmsView extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();
  AuthSmsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthCodeSent) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OtpVerificationView()));
            }
          },
          builder: (context, state) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 60),
            child: Center(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.arrow_back_ios_rounded),
                  ),
                  Image.asset("assets/sun.PNG"),
                  buildText(
                      context,
                      "Mobil Uygulamayı Kullanmak için lütfen giriş\n yapınız.",
                      15,
                      FontWeight.bold,
                      textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      buildText(
                          context,
                          "Bilgisayar şifrem yok. SMS ile şifre almak\n istiyorum",
                          15,
                          FontWeight.bold),
                      const SizedBox(width: 10),
                      Switch(
                        activeColor: Colors.red,
                        value: context.read<AuthCubit>().swtchValue,
                        onChanged: (value) {
                          context.read<AuthCubit>().onChangeSwitch(value);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomDropDownFormField(
                    items: context.read<AuthCubit>().selectItems,
                    value: context.read<AuthCubit>().selectedValue,
                    onChanged: (value) {
                      context.read<AuthCubit>().onSelectedValue(value!);
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomDropDownFormField(
                    items: context.read<AuthCubit>().selectTRR,
                    value: context.read<AuthCubit>().selectedValueTR,
                    onChanged: (value) {
                      context.read<AuthCubit>().onSelectedValueTR(value!);
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      /* Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton(
                            isExpanded: false,
                            borderRadius: BorderRadius.circular(10),
                            value: context.read<AuthCubit>().selectedValueCode,
                            items: context.read<AuthCubit>().selectCode,
                            onChanged: null,
                          ),
                        ),
                      ), */

                      SizedBox(
                        width: 360,
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(20)),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(15)),
                            filled: true,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomElevatedButton(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.red.shade400,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      buildSubmit(context);
                    },
                    data: "SUBMİT",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void buildSubmit(BuildContext context) {
    String phoneNumber = "+90${phoneController.text.trim()}";
    //BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
    context
        .read<AuthCubit>()
        .signInWithPhone(context, phoneNumber);
  }

  //buildText Method
  Widget buildText(BuildContext context, String text, double fontSize,
      FontWeight fontWeightBold,
      {TextAlign? textAlign}) {
    return Text(
      textAlign: textAlign,
      text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: fontSize,
            fontWeight: fontWeightBold,
          ),
    );
  }
}
