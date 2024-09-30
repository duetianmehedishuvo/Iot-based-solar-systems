class Planet2Model {
  Planet2Model({
      this.name, 
      this.tagline, 
      this.taglineIcon, 
      this.picture, 
      this.textureUrl, 
      this.description, 
      this.distanceFromSun, 
      this.yearLength, 
      this.numberOfMoons, 
      this.namesake, 
      this.rings, 
      this.spaceTextureUrl,});

  Planet2Model.fromJson(dynamic json) {
    name = json['name'];
    tagline = json['tagline'];
    taglineIcon = json['tagline_icon'];
    picture = json['picture'];
    textureUrl = json['textureUrl'];
    description = json['description'];
    distanceFromSun = json['distanceFromSun'];
    yearLength = json['yearLength'];
    numberOfMoons = json['numberOfMoons'];
    namesake = json['namesake'];
    rings = json['rings'] != null ? Rings.fromJson(json['rings']) : null;
    spaceTextureUrl = json['spaceTexture_url'];
  }
  String? name;
  String? tagline;
  String? taglineIcon;
  String? picture;
  String? textureUrl;
  String? description;
  String? distanceFromSun;
  String? yearLength;
  num? numberOfMoons;
  String? namesake;
  Rings? rings;
  String? spaceTextureUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['tagline'] = tagline;
    map['tagline_icon'] = taglineIcon;
    map['picture'] = picture;
    map['textureUrl'] = textureUrl;
    map['description'] = description;
    map['distanceFromSun'] = distanceFromSun;
    map['yearLength'] = yearLength;
    map['numberOfMoons'] = numberOfMoons;
    map['namesake'] = namesake;
    if (rings != null) {
      map['rings'] = rings?.toJson();
    }
    map['spaceTexture_url'] = spaceTextureUrl;
    return map;
  }

}

class Rings {
  Rings({
      this.urlExists,});

  Rings.fromJson(dynamic json) {
    urlExists = json['url_exists'];
  }
  bool? urlExists;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url_exists'] = urlExists;
    return map;
  }

}