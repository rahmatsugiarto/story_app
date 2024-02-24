import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/common.dart';
import 'package:story_app/core/resources/text_styles.dart';
import 'package:story_app/core/state/view_data_state.dart';
import 'package:story_app/core/utils/validator.dart';
import 'package:story_app/presentation/blocs/sign_up_bloc/sign_up_cubit.dart';
import 'package:story_app/presentation/blocs/sign_up_bloc/sign_up_state.dart';
import 'package:story_app/presentation/widgets/custom_button.dart';
import 'package:story_app/presentation/widgets/custom_dialog_loading.dart';
import 'package:story_app/presentation/widgets/custom_text_form_field.dart';
import 'package:story_app/presentation/widgets/custom_toast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();
  final formKeyName = GlobalKey<FormState>();
  final formKeyEmail = GlobalKey<FormState>();
  final formKeyPass = GlobalKey<FormState>();

  @override
  void dispose() {
    nameC.dispose();
    emailC.dispose();
    passC.dispose();

    super.dispose();
  }

  void authRegister() {
    if (formKeyName.currentState!.validate() &&
        formKeyEmail.currentState!.validate() &&
        formKeyPass.currentState!.validate()) {
      context.read<SignUpCubit>().authSignUp(
            name: nameC.text.trim(),
            email: emailC.text.trim(),
            pass: passC.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          final status = state.signUpState.status;
          final message = state.signUpState.message;

          if (status.isLoading) {
            CustomDialogLoading.show();
          }

          if (status.isError) {
            CustomDialogLoading.dismiss();
            CustomToast.showError(message: message);
          }

          if (status.isHasData) {
            CustomDialogLoading.dismiss();
            CustomToast.showSuccess(
              message: AppLocalizations.of(context)!.successSignUp,
            );
            context.pop();
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 7,
                ),
                Text(
                  AppLocalizations.of(context)!.titleApp,
                  style: TextStyles.cok50W800(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  AppLocalizations.of(context)!.signUpDesc,
                  style: TextStyles.pop14W600(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  key: formKeyName,
                  child: CustomTextFormField(
                    controller: nameC,
                    hintText: AppLocalizations.of(context)!.name,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => formKeyName.currentState!.validate(),
                    validator: (value) {
                      return Validator.validateEmptyForm(
                        value,
                        emptyMsg: AppLocalizations.of(context)!.nameEmpty,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Form(
                  key: formKeyEmail,
                  child: CustomTextFormField(
                    controller: emailC,
                    hintText: AppLocalizations.of(context)!.email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => formKeyEmail.currentState!.validate(),
                    validator: (value) {
                      return Validator.validateEmailForm(
                        value,
                        emptyMsg: AppLocalizations.of(context)!.emailEmpty,
                        notValidEmailMsg:
                            AppLocalizations.of(context)!.emailInvalid,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Form(
                  key: formKeyPass,
                  child: CustomTextFormField(
                    controller: passC,
                    hintText: AppLocalizations.of(context)!.password,
                    hidePassIcon: true,
                    onChanged: (_) => formKeyPass.currentState!.validate(),
                    validator: (value) {
                      return Validator.validatePassForm(
                        value,
                        emptyMsg: AppLocalizations.of(context)!.passwordEmpty,
                        shortMsg: AppLocalizations.of(context)!.passAtLeast,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CustomButton(
                  onPressed: () => authRegister(),
                  child: Text(
                    AppLocalizations.of(context)!.signUp,
                    style: TextStyles.pop14W400(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.haveAccount,
                      style: TextStyles.pop14W400(),
                    ),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: TextStyles.pop14W600(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
