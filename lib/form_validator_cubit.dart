import 'package:flutter_bloc/flutter_bloc.dart';
import 'form_validator_state.dart';

class FormValidatorCubit extends Cubit<FormValidatorState> {
  FormValidatorCubit() : super(const FormValidatorInitial());

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void validatePassword(String password) {
    if (password.isEmpty) {
      emit(state.copyWith(error: 'Password cannot be empty'));
    } else if (password.length < 8) {
      emit(state.copyWith(error: 'Password must be at least 8 characters'));
    } else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password)) {
      emit(state.copyWith(error: 'Password is invalid'));
    } else {
      emit(state.copyWith(error: null));
    }
  }
}
