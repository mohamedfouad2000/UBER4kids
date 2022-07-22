class ratingmodel {
  var ratingnumber;
  var comment;
  var improvements;

  ratingmodel({
    required this.ratingnumber,
    required this.comment,
    required this.improvements,
  });
  ratingmodel.fromjson(Map<String, dynamic> json) {
    ratingnumber = json['ratingnumber'];
    comment = json['comment'];
    improvements = json['improvements'];
  }
  Map<String, dynamic> TOMap() {
    return {
      'ratingnumber': ratingnumber,
      'improvements': improvements,
      'comment': comment,
    };
  }
}
