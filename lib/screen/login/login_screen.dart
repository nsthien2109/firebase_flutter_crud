// ignore_for_file: use_build_context_synchronously

import 'package:firebase_todo/provider/form_provider.dart';
import 'package:firebase_todo/utils/validate.dart';
import 'package:firebase_todo/widgets/submit_button.dart';
import 'package:firebase_todo/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<FormProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formProvider.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png',width: 80),
              const SizedBox(height: 30),
              TextInput(
                controller: formProvider.textControllerA,
                labelText: "Email",
                helpText: "Enter your email",
                icon: Icons.email_outlined,
                onChange: (value){},
                validate: (value) => ValidationForm.emailValidate(value),
              ),
              TextInput(
                controller: formProvider.textControllerB,
                labelText: "Password",
                helpText: "Enter your password",
                icon: Icons.key,
                obscureText: true,
                onChange: (value){},
                validate: (value) => ValidationForm.passwordValidate(value),
              ),
              SubmitButton(
                label: "Sign In",
                colorButton: Colors.green,
                onTap: ()=>formProvider.signIn(context),
              ),
              SubmitButton(
                label: "Sign Up",
                onTap: () async {
                  formProvider.signUp(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}