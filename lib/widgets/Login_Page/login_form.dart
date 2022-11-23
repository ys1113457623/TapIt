import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant.dart';
import '../../theme.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _passwordVisible = false;
  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              emailAddress,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).primaryColorDark),
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              height: 40.h,
              child: TextFormField(
                decoration: InputDecoration(
                    isCollapsed: true,
                    // contentPadding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 10.w),
                    // prefixIcon: Icon(Icons.person_outline_outlined),
                    suffixIcon: Icon(
                      Icons.mail,
                      size: 25.sp,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    // labelText: tEmail,

                    border: const OutlineInputBorder(gapPadding: 0)),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  password,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Themes.light.primaryColorDark),
                ),
                Text(
                  forgotPasswor,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Themes.light.primaryColorDark),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              height: 40.h,
              child: TextFormField(
                keyboardType: TextInputType.text,
                //  controller: _userPasswordController,
                obscureText: !_passwordVisible, //This will obscure text dynamically
                decoration: InputDecoration(
                    isCollapsed: true,

                    // Here is key idea
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                    border: const OutlineInputBorder()),
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.green;
                  }
                  return Theme.of(context).canvasColor;
                })),
                onPressed: () {},
                child: Text(tLogin.toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
