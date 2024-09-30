class SatelliteDetailsModel {
  SatelliteDetailsModel({
      this.info, 
      this.passes,});

  SatelliteDetailsModel.fromJson(dynamic json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    if (json['passes'] != null) {
      passes = [];
      json['passes'].forEach((v) {
        passes?.add(Passes.fromJson(v));
      });
    }
  }
  Info? info;
  List<Passes>? passes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (info != null) {
      map['info'] = info?.toJson();
    }
    if (passes != null) {
      map['passes'] = passes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Passes {
  Passes({
      this.startAz, 
      this.startAzCompass, 
      this.startUTC, 
      this.maxAz, 
      this.maxAzCompass, 
      this.maxEl, 
      this.maxUTC, 
      this.endAz, 
      this.endAzCompass, 
      this.endUTC,});

  Passes.fromJson(dynamic json) {
    startAz = json['startAz'];
    startAzCompass = json['startAzCompass'];
    startUTC = json['startUTC'];
    maxAz = json['maxAz'];
    maxAzCompass = json['maxAzCompass'];
    maxEl = json['maxEl'];
    maxUTC = json['maxUTC'];
    endAz = json['endAz'];
    endAzCompass = json['endAzCompass'];
    endUTC = json['endUTC'];
  }
  num? startAz;
  String? startAzCompass;
  num? startUTC;
  num? maxAz;
  String? maxAzCompass;
  num? maxEl;
  num? maxUTC;
  num? endAz;
  String? endAzCompass;
  num? endUTC;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['startAz'] = startAz;
    map['startAzCompass'] = startAzCompass;
    map['startUTC'] = startUTC;
    map['maxAz'] = maxAz;
    map['maxAzCompass'] = maxAzCompass;
    map['maxEl'] = maxEl;
    map['maxUTC'] = maxUTC;
    map['endAz'] = endAz;
    map['endAzCompass'] = endAzCompass;
    map['endUTC'] = endUTC;
    return map;
  }

}

class Info {
  Info({
      this.satid, 
      this.satname, 
      this.transactionscount, 
      this.passescount,});

  Info.fromJson(dynamic json) {
    satid = json['satid'];
    satname = json['satname'];
    transactionscount = json['transactionscount'];
    passescount = json['passescount'];
  }
  num? satid;
  String? satname;
  num? transactionscount;
  num? passescount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['satid'] = satid;
    map['satname'] = satname;
    map['transactionscount'] = transactionscount;
    map['passescount'] = passescount;
    return map;
  }

}