import 'package:chat/model/database/models/user.dart';
import 'package:chat/model/ui/base/base_view.dart';
import 'package:chat/model/ui/home/home_screen.dart';
import 'package:chat/model/ui/login/login_navigator.dart';
import 'package:chat/model/ui/login/login_viewmodel.dart';
import 'package:chat/model/ui/signup/sign_up_screen.dart';
import 'package:chat/model/ui/widgets/custom_elevated_button.dart';
import 'package:chat/model/ui/widgets/custom_form_field.dart';
import 'package:chat/model/ui/widgets/form_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String screenName = "login-screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  // Initialize TextEditingControllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
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
                          const FormLabel(formLabel: 'Password'),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomFormField(
                            hideText: true,
                            type: TextInputType.visiblePassword,
                            hintText: 'Enter Your Password',
                            controller: passwordController,
                            validator: (text) {
                              if (text?.trim().isEmpty ?? true) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                const Text("Forgot Password?"),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, SignUpScreen.screenName);
                                  },
                                  child: const Text(
                                    "Don't have an account? Sign up",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomElevatedButton(
                            onPressed: () {
                              // Perform form validation before proceeding
                              login();
                            },
                            label: 'Login',
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

  login() {
    if (formKey.currentState!.validate()) {
      viewModel.login(emailController.text, passwordController.text);
    }
  }

  @override
  LoginViewModel initViewmodel() {
    return LoginViewModel();
  }

  @override
  goToHome(MyUser myUser) {
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) =>const HomeScreen(),
    ),
    (route) => false, // This predicate removes all previous routes from the stack.
  );
  }
}
