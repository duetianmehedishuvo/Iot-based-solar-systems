class SatelliteModel {
  SatelliteModel({
    this.satid,
    this.satname,
    this.intDesignator,
    this.launchDate,
    this.satlat,
    this.satlng,
    this.satalt,
  });

  SatelliteModel.fromJson(dynamic json) {
    satid = json['satid'];
    satname = json['satname'];
    intDesignator = json['intDesignator'];
    launchDate = json['launchDate'];
    satlat = json['satlat'];
    satlng = json['satlng'];
    satalt = json['satalt'];
  }

  num? satid;
  String? satname;
  String? intDesignator;
  String? launchDate;
  num? satlat;
  num? satlng;
  num? satalt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['satid'] = satid;
    map['satname'] = satname;
    map['intDesignator'] = intDesignator;
    map['launchDate'] = launchDate;
    map['satlat'] = satlat;
    map['satlng'] = satlng;
    map['satalt'] = satalt;
    return map;
  }
}
