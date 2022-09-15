// ignore_for_file: must_be_immutable

import 'package:buildcondition/buildcondition.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soq_app/presentation/bloc/home_bloc/home_cubit.dart';
import 'package:soq_app/presentation/bloc/home_bloc/home_states.dart';
import 'package:soq_app/presentation/pages/login/login_view.dart';
import 'package:soq_app/presentation/recources/strings_manger.dart';
import 'package:soq_app/presentation/recources/values_manger.dart';
import 'package:soq_app/presentation/widgets/widgets.dart';

class SettingsView extends StatelessWidget {
  SettingsView({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formProfileKey = GlobalKey<FormState>();
  // ignore: prefer_typing_uninitialized_variables
  var fcmToken;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (HomeCubit.get(context).authenticationData != null) {
          var cubit = HomeCubit.get(context).authenticationData!;
          nameController.text = cubit.name;
          emailController.text = cubit.email;
          phoneController.text = cubit.phone;
          fcmToken = cubit.token;
        }

        return BuildCondition(
          condition: HomeCubit.get(context).authenticationData != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(AppSize.s20),
            child: SingleChildScrollView(
              child: Form(
                key: formProfileKey,
                child: Column(
                  children: [
                    if (state is UpdateProfileLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: AppSize.s15),
                    deffaultFormField(
                      controller: nameController,
                      labelText: AppStrings.name.tr(),
                      prefix: Icons.person,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.nameMustNoTbeEmpty.tr();
                        }
                        return null;
                      },
                      type: TextInputType.name,
                    ),
                    const SizedBox(height: AppSize.s15),
                    deffaultFormField(
                      controller: emailController,
                      labelText: AppStrings.emailHint.tr(),
                      prefix: Icons.person,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.invalidEmail.tr();
                        }
                        return null;
                      },
                      type: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppSize.s15),
                    deffaultFormField(
                      controller: phoneController,
                      labelText: AppStrings.phone.tr(),
                      prefix: Icons.person,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.phoneInvalid.tr();
                        }
                        return null;
                      },
                      type: TextInputType.phone,
                    ),
                    const SizedBox(height: AppSize.s20),
                    deffaultButton(
                      function: () {
                        if (formProfileKey.currentState!.validate()) {
                          HomeCubit.get(context).updateProfile(
                            nameController.text,
                            emailController.text,
                            phoneController.text,
                          );
                        }
                      },
                      text: AppStrings.update.tr(),
                    ),
                    const SizedBox(height: AppSize.s15),
                    deffaultButton(
                      function: () {
                        HomeCubit.get(context).changeLanguage(context);
                      },
                      text: AppStrings.changeLanguage.tr(),
                    ),
                    const SizedBox(height: AppSize.s15),
                    deffaultButton(
                      function: () {
                        HomeCubit.get(context).logoutFun();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const LoginView()),
                            ),
                            (Route<dynamic> route) => false);
                      },
                      text: AppStrings.logout.tr(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
