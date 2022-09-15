import 'package:buildcondition/buildcondition.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soq_app/app/app_prefs.dart';
import 'package:soq_app/app/injection_container.dart';
import 'package:soq_app/presentation/bloc/auth/login_bloc/login_cubit.dart';
import 'package:soq_app/presentation/bloc/auth/login_bloc/login_states.dart';
import 'package:soq_app/presentation/recources/route_manger.dart';
import 'package:soq_app/presentation/recources/strings_manger.dart';
import 'package:soq_app/presentation/widgets/widgets.dart';

import '../../recources/values_manger.dart';
import '../register/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            _appPreferences.setUserToken(state.authentication.data!.token);
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.layoutRoute, (Route<dynamic> route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: AppSize.s0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppSize.s20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: AppSize.s28),
                      getLogo(),
                      const SizedBox(height: AppSize.s28),
                      getFormFiled(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getFormFiled() {
    return Column(
      children: [
        deffaultFormField(
          controller: _userNameController,
          labelText: AppStrings.emailHint.tr(),
          prefix: Icons.email_outlined,
          validate: (value) {
            if (value == null || value.isEmpty) {
              return AppStrings.invalidEmail.tr();
            }
            return null;
          },
        ),
        const SizedBox(height: AppSize.s20),
        BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {},
          builder: (context, state) {
            LoginCubit cubit = LoginCubit.get(context);
            return deffaultFormField(
              controller: _passwordController,
              labelText: AppStrings.password.tr(),
              isPassword: cubit.ispassword,
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.passwordInvalid.tr();
                }
                return null;
              },
              onFieldSubmitted: (value) {
                if (formKey.currentState!.validate()) {
                  cubit.login(
                    email: _userNameController.text,
                    password: _passwordController.text,
                  );
                }
              },
              prefix: Icons.password_outlined,
              suffix: cubit.suffex,
              suffixPressed: () {
                cubit.changePaasswordVisibility();
              },
            );
          },
        ),
        const SizedBox(height: AppSize.s20),
        getLogin(),
        getRegister(),
      ],
    );
  }

  Widget getRegister() {
    return Padding(
      padding: const EdgeInsets.only(top: AppSize.s20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.registerText.tr(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          deffaultTextButton(
            context: context,
            onPressed: () {
              navigateTo(context, RegisterView());
            },
            text: AppStrings.register.tr(),
          ),
        ],
      ),
    );
  }

  Widget getLogin() {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LoginCubit cubit = LoginCubit.get(context);
        return BuildCondition(
          condition: state is! LoginLoadingState,
          builder: (context) => deffaultButton(
            function: () {
              if (formKey.currentState!.validate()) {
                cubit.login(
                  email: _userNameController.text,
                  password: _passwordController.text,
                );
              }
            },
            text: AppStrings.login.tr(),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
