class FacebookModel {
  late final String name;
  late final String email;
  late final String url;
  FacebookModel({required this.name, required this.email, required this.url});
  FacebookModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    // url = json['picture']['data']['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;

    return _data;
  }
}
