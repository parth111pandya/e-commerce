import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/route/route_constants.dart';

import '../firebase_auth/auth_services.dart';
import '../square_tile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthServices authServices = AuthServices();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  bool _isLoading = false;

  Future<Null> _handleGoogleSignIn(context) async {
    setState(() {
      _isLoading = true;
    });
    AuthServices().signWithGoogle(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/login_dark.png",
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome back!",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "Log in with your data that you intered during your registration.",
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          onSaved: (emal) {
                            // Email
                          },
                          controller: emailTextController,
                          validator: emaildValidator.call,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Email address",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding * 0.75),
                              child: SvgPicture.asset(
                                "assets/icons/Message.svg",
                                height: 24,
                                width: 24,
                                colorFilter: ColorFilter.mode(
                                    Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.3),
                                    BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: defaultPadding),
                        TextFormField(
                          onSaved: (pass) {
                            // Password
                          },
                          validator: passwordValidator.call,
                          controller: passwordTextController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: defaultPadding * 0.75),
                              child: SvgPicture.asset(
                                "assets/icons/Lock.svg",
                                height: 24,
                                width: 24,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withOpacity(0.3),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(_isLoading ? 20.0 : 0.0),
                        width: 75,
                        height: 75,
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : SquareTile(
                                onTap: () => _handleGoogleSignIn(context),
                                imagePath: 'assets/images/google.png',
                              ),
                      )
                    ],
                  ),
                  SizedBox(
                    height:
                        size.height > 700 ? size.height * 0.1 : defaultPadding,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        authServices.signUserIn(
                          context,
                          passwordController: passwordTextController,
                          emailController: emailTextController,
                        );
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context,
                        //     entryPointScreenRoute,
                        //     ModalRoute.withName(logInScreenRoute));
                      }
                    },
                    child: const Text("Log in"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, signUpScreenRoute);
                        },
                        child: const Text("Sign up"),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
