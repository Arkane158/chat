import 'package:chat/model/ui/base/base_view.dart';
import 'package:chat/model/ui/forgot_password/forgot_password_viewmodel.dart';
import 'package:chat/model/ui/login/login_screen.dart';
import 'package:chat/model/ui/widgets/custom_elevated_button.dart';
import 'package:chat/model/ui/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/form_label.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String screenName = "ForgotPasswordScreen";

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends BaseView<ForgotPasswordScreen, ForgotPasswordViewModel>
    implements ForgotPasswordNavigator {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/main_bg.png'),
                fit: BoxFit.cover)),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Login',
            ),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey, // Form key for validation
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: Text('Welcome Back!'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const FormLabel(formLabel: 'Email'),
                          CustomFormField(
                            hintText: 'Enter Your Email',
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (text) {
                              // Regular expression pattern for email validation
                              final emailRegExp =
                                  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                              if (text?.trim().isEmpty ?? true) {
                                return 'Please enter your email.';
                              } else if (!emailRegExp.hasMatch(text!)) {
                                return 'Please enter a valid email address.';
                              }

                              return null; // Return null for valid input
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomElevatedButton(
                            onPressed: () {
                              // Perform form validation before proceeding
                              viewModel.forgotPassword(emailController.text);
                            },
                            label: 'Submit',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ForgotPasswordViewModel initViewmodel() {
    return ForgotPasswordViewModel();
  }

  @override
  goToLogin() {
    Navigator.pushReplacementNamed(context, LoginScreen.screenName);
  }
}
