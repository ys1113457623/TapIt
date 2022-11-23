import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tapit/views/Login_Page/gradient_eclipse.dart';

import 'login_footer_widget.dart';
import 'login_form.dart';
import 'login_header_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const GradientEclipse(),
            SizedBox(height: 40.h),
            Container(
              padding: EdgeInsets.all(20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const LoginHeaderWidget(),
                  SizedBox(height: 20.h),
                  const LoginForm(),
                  const LoginFooterWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
