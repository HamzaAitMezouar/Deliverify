class GoogleModel {
  GoogleModel({
    required this.displayName,
    required this.email,
    required this.photoUrl,
    this.token,
  });
  late final String displayName;
  late final String email;
  late final String? token;
  late final String photoUrl;

  GoogleModel.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    ;
    photoUrl = json['photoUrl'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['displayName'] = displayName;
    _data['email'] = email;
    _data['token'] = token;
    _data['photoUrl'] = token;
    return _data;
  }
}
