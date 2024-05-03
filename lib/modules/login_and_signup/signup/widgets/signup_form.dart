import 'package:community_share/widgets/snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../model/user.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double formPadding = MediaQuery.sizeOf(context).width / 9;
    if (MediaQuery.sizeOf(context).width < 1000) {
      formPadding = MediaQuery.sizeOf(context).width / 5;
    }
    return Form(
      key: _formKey,
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        color: const Color.fromRGBO(21, 21, 21, 1.0),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: formPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ..._formHeader(),
              const SizedBox(
                height: 16,
              ),
              _emailField,
              const SizedBox(height: 16),
              _passwordField,
              const SizedBox(height: 32),
              _createAccountButton(context),
              const SizedBox(height: 16),
              _haveAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _formHeader() {
    return [
      const Text(
        "Welcome To WebSocket Chat App",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      const SizedBox(height: 8),
      const Text(
        "Please enter your login credentials to continue",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white54,
          fontSize: 14,
        ),
      ),
      const SizedBox(height: 36),
    ];
  }

  get _emailField => TextFormField(
        style: const TextStyle(color: Colors.white),
        controller: _emailController,
        decoration: InputDecoration(
            labelStyle: const TextStyle(
              color: Color.fromRGBO(196, 183, 227, 1.0),
            ),
            labelText: "Email address",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white38),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16)),
      );

  get _passwordField => TextFormField(
        style: const TextStyle(color: Colors.white),
        obscureText: true,
        controller: _passwordController,
        decoration: InputDecoration(
          labelStyle: const TextStyle(
            color: Color.fromRGBO(196, 183, 227, 1.0),
          ),
          labelText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white38),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
      );

  _createAccountButton(BuildContext context) {
    return FilledButton(
      onPressed: () async {
        var box = await Hive.openBox<User>('userdata');
        final user = Hive.box<User>('userdata');
        final check = user.get(_emailController.text);
        if (check == null) {
          User newUser = User(
            email: _emailController.text,
            password: _passwordController.text,
          );
          await user.put(_emailController.text, newUser);
          if(context.mounted){
            Navigator.pop(context);
          }
        } else {
          if(context.mounted){
            ScaffoldMessenger.of(context).showSnackBar(MySnackBar()
                .mySnackBar(text: 'User already exists', context: context));
          }
        }
        await box.close();
      },
      style: FilledButton.styleFrom(
        backgroundColor: const Color.fromRGBO(187, 159, 255, 1.0),
        minimumSize: const Size.fromHeight(56),
      ),
      child: const Text(
        "Create Account",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }

  _haveAccount(BuildContext context) => TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: TextButton.styleFrom(
          surfaceTintColor: Colors.transparent,
        ),
        child: const Text(
          "Have Account? Login.",
          style: TextStyle(
            color: Colors.white54,
            fontSize: 14,
          ),
        ),
      );
}
