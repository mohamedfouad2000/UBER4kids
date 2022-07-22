class requestmodel {
  var number;
  var uId;
  requestmodel({
    required this.number,
    required this.uId,
  });
  requestmodel.fromjson(Map<String, dynamic> json) {
    number = json['number'];
  }
  Map<String, dynamic> TOMap() {
    return {
      'number': number,
      'uId': uId,
    };
  }
}
