class complaintmodel {
  String? name;
  String? msg;
  String? email;
  bool? adminrep;
  String? Uid;


  
  complaintmodel({
    required this.email,
    required this.msg,
    required this.name,
    required this.adminrep,
    required this.Uid,


  });
  complaintmodel.fromjson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    msg = json['msg'];
    adminrep = json['adminrep'];
    Uid = json['Uid'];


  }

  Map<String, dynamic> TOMap() {
    return {
      'name': name,
      'email': email,
      'msg': msg,
      'adminrep': adminrep,
      'Uid': Uid,


    };
  }
}
