// ignore: camel_case_types

abstract class Login_States {}

class Initial_state extends Login_States {}

class Login_loding_state extends Login_States {}

class Login_success_state extends Login_States {
  String uId;
  Login_success_state(this.uId);
}

class Login_Error_state extends Login_States {
  final String error;
  Login_Error_state(this.error);
}

class changePassword extends Login_States {}
