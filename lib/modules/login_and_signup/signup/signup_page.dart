import 'package:flutter/material.dart';
import '../../../widgets/responsive_widget.dart';
import 'widgets/signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWidget(
        builder: (type) {
          if (type != DeviceType.WEB) {
            return const SingleChildScrollView(
              child: SignupForm(),
            );
          }
          return Row(
            children: [
              Flexible(
                child: _buildLogo(context),
              ),
              const Flexible(
                child: SignupForm(),
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
        child: Text(
          'Anya',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
