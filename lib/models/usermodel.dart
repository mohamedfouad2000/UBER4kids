class usermodel {
  var name;
  var email;
  var phone;
  var uId;
  var isemailv;
  var isdriver;
  var driverNumber;
  var gender;
  var admin;
  var profile;
  var bio;
  var n;

  usermodel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.uId,
      required this.isemailv,
      required this.isdriver,
      required this.driverNumber,
      required this.gender,
      required this.admin,
      required this.profile,
      required this.bio,
      this.n});
  usermodel.fromjson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isemailv = json['isemailv'];
    isdriver = json['isdriver'];
    driverNumber = json['driverNumber'];
    gender = json['gender'];
    admin = json['admin'];
    profile = json['profile'];
    bio = json['bio'];
  }

  // عشان ال set بتحتاج map تتحط فيها
  Map<String, dynamic> TOMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isemailv': isemailv,
      'isdriver': isdriver,
      'driverNumber': driverNumber,
      'gender': gender,
      'admin': admin,
      'profile': profile,
      'bio': bio,
    };
  }
}
