class Ipify {
  String? ip;

  Ipify({this.ip});

  Ipify.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ip'] = this.ip;
    return data;
  }
}
