class placeModel {
  var place_lat;
  var place_long;
  var place;
  var schoolname;
  var Street;
  var Country;
  var Locality;

  placeModel({
    required this.place_lat,
    required this.place_long,
    required this.place,
    required this.schoolname,
    required this.Street,
    required this.Country,
    required this.Locality,
  });

  placeModel.fromjson(Map<String, dynamic> json) {
    place_lat = json['place_lat'];
    place_long = json['place_long'];
    schoolname = json['schoolname'];
    place = json['place'];
    Street = json['Street'];
    Country = json['Country'];
    Locality = json['Locality'];
  }

  // عشان ال set بتحتاج map تتحط فيها
  Map<String, dynamic> TOMap() {
    return {
      'place_lat': place_lat,
      'place_long': place_long,
      'place': place,
      'schoolname': schoolname,
      'Street': Street,
      'Country': Country,
      'Locality': Locality,
    };
  }
}
