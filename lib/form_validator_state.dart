import 'package:flutter/foundation.dart';

@immutable
abstract class FormValidatorState {
  final String? error;
  final String? password;

  const FormValidatorState({this.error, this.password});

  FormValidatorState copyWith({String? error, String? password});
}

class FormValidatorInitial extends FormValidatorState {
  const FormValidatorInitial() : super();

  @override
  FormValidatorState copyWith({String? error, String? password}) {
    return const FormValidatorInitial();
  }
}

class FormValidatorValid extends FormValidatorState {
  const FormValidatorValid({String? password}) : super(password: password);

  @override
  FormValidatorState copyWith({String? error, String? password}) {
    return FormValidatorValid(password: password);
  }
}
