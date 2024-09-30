class AstronyDayModel {
  AstronyDayModel({
      this.copyright, 
      this.date, 
      this.explanation, 
      this.hdurl, 
      this.mediaType, 
      this.serviceVersion, 
      this.title, 
      this.url,});

  AstronyDayModel.fromJson(dynamic json) {
    copyright = json['copyright'];
    date = json['date'];
    explanation = json['explanation'];
    hdurl = json['hdurl'];
    mediaType = json['media_type'];
    serviceVersion = json['service_version'];
    title = json['title'];
    url = json['url'];
  }
  String? copyright;
  String? date;
  String? explanation;
  String? hdurl;
  String? mediaType;
  String? serviceVersion;
  String? title;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['copyright'] = copyright;
    map['date'] = date;
    map['explanation'] = explanation;
    map['hdurl'] = hdurl;
    map['media_type'] = mediaType;
    map['service_version'] = serviceVersion;
    map['title'] = title;
    map['url'] = url;
    return map;
  }

}