// ignore_for_file: avoid_print, unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController controller = TextEditingController();
  AuthCubit() : super(AuthInitial());

  //
  bool swtchValue = false;
  String selectedValue = "VBT";
  String selectedValueTR = "TR";
  String selectedValueCode = "TR";

  String? _verificationId;

  //dropDownItems
  List<DropdownMenuItem<String>> selectItems = [
    const DropdownMenuItem(value: "VBT", child: Text("Şirket Seçiniz")),
    const DropdownMenuItem(value: "SUN", child: Text("SUN")),
  ];
  List<DropdownMenuItem<String>> selectTRR = [
    const DropdownMenuItem(value: "TR", child: Text("Türkiye Cumhuriyeti +90")),
    const DropdownMenuItem(value: "ABD", child: Text("Amerika +1"))
  ];
  List<DropdownMenuItem<String>> selectCode = [
    const DropdownMenuItem(value: "TR", child: Text("+90")),
    const DropdownMenuItem(value: "ABD", child: Text("+1"))
  ];

  //Switch Icon
  onChangeSwitch(bool value) {
    swtchValue = value;
    emit(SwitchUpdated());
  }

  //DropDownSelected
  onSelectedValue(String value) {
    selectedValue = value;
  }

  onSelectedValueTR(String value) {
    selectedValueTR = value;
  }

  //sendOTP
  Future<void> sendOTP(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {
        signInWithPhone(phoneAuthCredential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        emit(AuthCodeSent());
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  //verificationOTP
  void verificationOTP(String smsCode) {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: smsCode);
    signInWithPhone(credential);
  }

  //SignInPhone
  Future<void> signInWithPhone(PhoneAuthCredential credential) async {
    try {
      UserCredential user = await auth.signInWithCredential(credential);
      if (user.user != null) {
        emit(AuthLoggedIn());
      }
    } on FirebaseAuthException catch (e) {
      print("Exception :${Exception(e)}");
    }
  }
}
