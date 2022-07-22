abstract class register_States {}

class Initial_register_state extends register_States {}

class register_loding_state extends register_States {}

class register_succ_state extends register_States {}

class register_eroor_state extends register_States {
  String ?err;
  register_eroor_state({this.err});
}

class createUser_loding_state extends register_States {}

class createUser_succ_state extends register_States {
  String? uId;
  createUser_succ_state({this.uId});
}

class createUser_eroor_state extends register_States {
  String? eroor;
  createUser_eroor_state({this.eroor});
}

class changePasswordRe extends register_States {}
