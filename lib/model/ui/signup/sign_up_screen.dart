import 'package:chat/model/database/models/user.dart';
import 'package:chat/model/ui/base/base_view.dart';
import 'package:chat/model/ui/home/home_screen.dart';
import 'package:chat/model/ui/login/login_screen.dart';
import 'package:chat/model/ui/signup/signup_navigator.dart';
import 'package:chat/model/ui/signup/singn_up_viewmodel.dart';
import 'package:chat/model/ui/widgets/custom_elevated_button.dart';
import 'package:chat/model/ui/widgets/custom_form_field.dart';
import 'package:chat/model/ui/widgets/form_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const String screenName = "SignUpScreen";
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends BaseView<SignUpScreen, SignUpViewModel>
    implements SignUpNavigator {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

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
          // resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Sign Up'),
            centerTitle: true,
            elevation: 0,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const FormLabel(formLabel: 'Name'),
                          CustomFormField(
                            hintText: 'Enter Your Name',
                            controller: nameController,
                            type: TextInputType.emailAddress,
                            validator: (text) {
                              if (text?.trim().isEmpty ?? true) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const FormLabel(formLabel: 'Email'),
                          CustomFormField(
                            hintText: 'Enter Your Email',
                            type: TextInputType.emailAddress,
                            controller: emailController,
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
                            hintText: 'Enter Your Password',
                            hideText: true,
                            controller: passwordController,
                            validator: (text) {
                              if (text?.trim().isEmpty ?? true) {
                                return 'Please valid Password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                              child: Column(
                            children: [
                              const Text("Forgot Password?"),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, LoginScreen.screenName);
                                },
                                child: const Text(
                                  "Already Have Account? Login",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          )),
                          CustomElevatedButton(
                              onPressed: () {
                                signUp();
                              },
                              label: 'Sign Up')
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

  void signUp() {
    if (formKey.currentState!.validate()) {
      // Validate the form data
      // Submit the form data to a server
      viewModel.signUp(
        emailController.text,
        passwordController.text,
        nameController.text,
      );
    }
  }

  @override
  SignUpViewModel initViewmodel() {
    return SignUpViewModel();
  }

  @override
  goToHome(MyUser myUser) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (route) =>
          false, // This predicate removes all previous routes from the stack.
    );
  }
}
