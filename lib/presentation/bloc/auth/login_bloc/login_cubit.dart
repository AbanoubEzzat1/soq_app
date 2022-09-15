import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soq_app/app/app_prefs.dart';
import 'package:soq_app/app/injection_container.dart';
import 'package:soq_app/data/network/failure.dart';
import 'package:soq_app/domain/models.dart';
import 'package:soq_app/domain/usecases/login_usecase.dart';
import 'package:soq_app/presentation/bloc/auth/login_bloc/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LoginUseCase loginUseCase = instance<LoginUseCase>();

  bool ispassword = true;
  IconData suffex = Icons.visibility_off;
  void changePaasswordVisibility() {
    ispassword = !ispassword;
    suffex = ispassword ? Icons.visibility_off : Icons.visibility;
    emit(LoginchangePaasswordVisibilityState());
  }

  Authentication? authentication;
  login({required String email, required String password}) async {
    emit(LoginLoadingState());

    Either<Failure, Authentication> response =
        await loginUseCase.execute(LoginUseCaseInputs(email, password));

    response.fold((faliure) {
      if (kDebugMode) {
        print(faliure.code);
      }
      if (kDebugMode) {
        print(faliure.message);
      }
      emit(LoginErrorState(faliure.message));
    }, (data) async {
      authentication = data;
      await _appPreferences.setUserLoggedIn();
      emit(LoginSuccessState(data));
    });
  }
}
