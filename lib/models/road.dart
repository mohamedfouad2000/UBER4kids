class roadmodel {
  var from_lat;
  var from_long;
  var to_lat;
  var to_long;
  var from;
  var to;

  roadmodel({
    required this.from_lat,
    required this.from_long,
    required this.to_lat,
    required this.to_long,
    required this.to,
    required this.from,

  });

  roadmodel.fromjson(Map<String, dynamic> json) {
    from_lat = json['from_lat'];
    from_long = json['from_long'];
    to_lat = json['to_lat'];
    to_long = json['to_long'];
    to = json['to'];
    from = json['from'];
  }

  // عشان ال set بتحتاج map تتحط فيها
  Map<String, dynamic> TOMap() {
    return {
      'from_lat': from_lat,
      'from_long': from_long,
      'to_lat': to_lat,
      'to_long': to_long,
      'from': from,
      'to': to,
    };
  }
}
