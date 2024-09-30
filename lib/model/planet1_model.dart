class Planet1Model {
  Planet1Model({
      this.name, 
      this.mass, 
      this.radius, 
      this.period, 
      this.semiMajorAxis, 
      this.temperature, 
      this.distanceLightYear, 
      this.hostStarMass, 
      this.hostStarTemperature,});

  Planet1Model.fromJson(dynamic json) {
    name = json['name'];
    mass = json['mass'];
    radius = json['radius'];
    period = json['period'];
    semiMajorAxis = json['semi_major_axis'];
    temperature = json['temperature'];
    distanceLightYear = json['distance_light_year'];
    hostStarMass = json['host_star_mass'];
    hostStarTemperature = json['host_star_temperature'];
  }
  String? name;
  num? mass;
  num? radius;
  num? period;
  num? semiMajorAxis;
  num? temperature;
  num? distanceLightYear;
  num? hostStarMass;
  num? hostStarTemperature;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['mass'] = mass;
    map['radius'] = radius;
    map['period'] = period;
    map['semi_major_axis'] = semiMajorAxis;
    map['temperature'] = temperature;
    map['distance_light_year'] = distanceLightYear;
    map['host_star_mass'] = hostStarMass;
    map['host_star_temperature'] = hostStarTemperature;
    return map;
  }

}