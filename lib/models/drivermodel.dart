import 'package:project/models/road.dart';
import 'package:project/models/usermodel.dart';

class drivermodel {
  var name;
  var email;
  var phone;
  var uId;
  var c_chip;
  var licence;
  var front;
  var back;
  var bio;
  var profile;
  var n_o_passengers;
  var isset;
  var worker;
  var isfull;
  var from;
  var to;
  var cuurent;
  var rate;

  drivermodel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.back,
    required this.c_chip,
    required this.front,
    required this.licence,
    required this.bio,
    required this.profile,
    required this.n_o_passengers,
    required this.isset,
    required this.worker,
    required this.isfull,
    required this.from,
    required this.to,
    required this.cuurent,
    required this.rate,
  });
  drivermodel.fromjson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    back = json['back'];
    c_chip = json['c_chip'];
    front = json['front'];
    licence = json['licence'];
    bio = json['bio'];
    profile = json['profile'];
    isset = json['isset'];
    n_o_passengers = json['n_o_passengers'];
    worker = json['worker'];
    isfull = json['isfull'];
    from = json['from'];
    to = json['to'];
    cuurent = json['cuurent'];
    rate = json['rate'];
  }

  // عشان ال set بتحتاج map تتحط فيها
  Map<String, dynamic> TOMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'back': back,
      'c_chip': c_chip,
      'front': front,
      'licence': licence,
      'bio': bio,
      'profile': profile,
      'isset': isset,
      'n_o_passengers': n_o_passengers,
      'worker': worker,
      'isfull': isfull,
      'from': from,
      'to': to,
      'cuurent': cuurent,
      'rate': rate,
    };
  }
}
