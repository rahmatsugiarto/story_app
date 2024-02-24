import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/common.dart';
import 'package:story_app/core/constants/app_routes.dart';
import 'package:story_app/core/resources/text_styles.dart';
import 'package:story_app/core/state/view_data_state.dart';
import 'package:story_app/core/utils/validator.dart';
import 'package:story_app/presentation/blocs/login_bloc/login_cubit.dart';
import 'package:story_app/presentation/blocs/login_bloc/login_state.dart';
import 'package:story_app/presentation/widgets/custom_button.dart';
import 'package:story_app/presentation/widgets/custom_dialog_loading.dart';
import 'package:story_app/presentation/widgets/custom_text_form_field.dart';
import 'package:story_app/presentation/widgets/custom_toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();
  final formKeyEmail = GlobalKey<FormState>();
  final formKeyPass = GlobalKey<FormState>();

  @override
  void dispose() {
    emailC.dispose();
    passC.dispose();

    super.dispose();
  }

  void authLogin() {
    if (formKeyEmail.currentState!.validate() &&
        formKeyPass.currentState!.validate()) {
      context.read<LoginCubit>().authLogin(
            email: emailC.text.trim(),
            pass: passC.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          final status = state.loginState.status;
          final message = state.loginState.message;

          if (status.isLoading) {
            CustomDialogLoading.show();
          }

          if (status.isError) {
            CustomDialogLoading.dismiss();
            CustomToast.showError(message: message);
          }

          if (status.isHasData) {
            CustomDialogLoading.dismiss();
            context.goNamed(AppRoutes.home.name);
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 3.5,
                ),
                Text(
                  AppLocalizations.of(context)!.titleApp,
                  style: TextStyles.cok50W800(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
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
                      return Validator.validateEmptyForm(
                        value,
                        emptyMsg: AppLocalizations.of(context)!.passwordEmpty,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                CustomButton(
                  onPressed: () => authLogin(),
                  child: Text(
                    AppLocalizations.of(context)!.login,
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
                      AppLocalizations.of(context)!.dontHaveAccount,
                      style: TextStyles.pop14W400(),
                    ),
                    GestureDetector(
                      onTap: () => context.goNamed(AppRoutes.signUp.name),
                      child: Text(
                        AppLocalizations.of(context)!.signUp,
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
