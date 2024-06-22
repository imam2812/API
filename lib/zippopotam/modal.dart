class Places {
  String? placeName;
  String? longitude;
  String? state;
  String? stateAbbreviation;
  String? latitude;

  Places(
      {this.placeName,
        this.longitude,
        this.state,
        this.stateAbbreviation,
        this.latitude});

  Places.fromJson(Map<String, dynamic> json) {
    placeName = json['place name'];
    longitude = json['longitude'];
    state = json['state'];
    stateAbbreviation = json['state abbreviation'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['place name'] = this.placeName;
    data['longitude'] = this.longitude;
    data['state'] = this.state;
    data['state abbreviation'] = this.stateAbbreviation;
    data['latitude'] = this.latitude;
    return data;
  }
}
