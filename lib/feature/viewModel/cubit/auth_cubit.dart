// ignore_for_file: avoid_print, unused_local_variable, unused_field, prefer_final_fields

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sms_auth/feature/utils/snackbar.dart';
import 'package:firebase_sms_auth/feature/view/otp_verification_view.dart';
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
  String? otpCodee;

  String? _verificationId;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;

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

  otpSetState(String value) {
    otpCodee = value;
    emit(OtpCodeUpdated());
  }

  //signInWithPhone
  Future<void> signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await auth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          buidPageRouteOTP(context, verificationId);
          // _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  //NavigatorMethod
  void buidPageRouteOTP(BuildContext context, String verificationId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            OtpVerificationView(verificationId: verificationId),
      ),
    );
  }

  //verificationOTP
  void verificationOTP({
    required BuildContext context,
    required String verificationId,
    required String smsCode,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    emit(OtpCodeUpdated());
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      User? user = (await auth.signInWithCredential(creds)).user;
      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      emit(OtpCodeUpdated());
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      emit(OtpCodeUpdated());
    }
  }
}
