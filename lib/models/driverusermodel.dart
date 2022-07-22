class driverusermodel {
  var number;
  var driverId;
  driverusermodel({required this.driverId, required this.number});
  driverusermodel.fromjson(Map<String, dynamic> json) {
    number = json['number'];
    driverId = json['driverId'];
  }
  Map<String, dynamic> TOMap() {
    return {
      'number': number,
      'driverId': driverId,
    };
  }
}
