import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  //
  bool swtchValue = false;
  String selectedValue = "VBT";
  String selectedValueTR = "TR";
  String selectedValueCode = "TR";

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
}
