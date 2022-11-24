// import 'package:get/get.dart';

// class LoginController  extends GetxController {
//   final AuthenticationController _authenticationController = Get.find();

//   final _loginStateStream = LoginState().obs;

//   LoginState get state => _loginStateStream.value;

//   void login(String email, String password) async {
//     _loginStateStream.value = LoginLoading();

//     try{
//       await _authenticationController.signIn(email, password);
//       _loginStateStream.value = LoginState();
//     } on AuthenticationException catch(e){
//       _loginStateStream.value = LoginFailure(error: e.message);
//     }
//   }
// }

import 'package:get/get_state_manager/get_state_manager.dart';

class LoginController extends GetxController {}
