import 'package:community_share/modules/login_and_signup/login/widgets/login_form.dart';
import 'package:community_share/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../widgets/responsive_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWidget(
        builder: (type) {
          if (type != DeviceType.WEB) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height / 3,
                    color: const Color.fromRGBO(187, 159, 255, 1.0),
                    child: Center(
                      child: Align(
                        alignment: const Alignment(0, 0.3),
                        child: Text(
                          'Anya',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.sizeOf(context).height * (2 / 3),
                      child: Form(
                          key: _formKey,
                          child: LoginForm(formKey: _formKey,),
                      ),
                  ),
                ],
              ),
            );
          }
          return Row(
            children: [
              Flexible(
                child: _buildLogo(context),
              ),
              Flexible(
                child: Form(
                    key: _formKey,
                    child: LoginForm(formKey: _formKey,),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _buildLogo(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(187, 159, 255, 1.0),
      child: Center(
        child: TextWidget(
          text: 'Anya',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
