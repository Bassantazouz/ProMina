import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pro_mina/core/utils/base_request_state.dart';
import '../../domain/use_cases/login_usecase.dart';

@injectable
class LoginViewModel extends Cubit<BaseRequestStates> {
  LoginViewModel(this.useCase) : super(BaseRequestInitialState());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginUseCase useCase;
  void login() async {
    if (!formKey.currentState!.validate()) return;
    emit(LoginLoadingState());
    Either<String, bool> eitherResponse =
    await useCase.execute(nameController.text, passwordController.text);
    eitherResponse.fold((l) {
      emit(LoginErrorState(l));},
            (r) => emit(LoginSuccessState()));
  }
}