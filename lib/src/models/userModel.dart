class userModel {
  userModel({
    required this.displayName,
    required this.email,
    required this.password,
    this.token,
  });
  late final String displayName;
  late final String email;
  late final String password;
  late final String? token;

  userModel.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['displayName'] = displayName;
    _data['email'] = email;
    _data['password'] = password;
    _data['token'] = token;
    return _data;
  }
}
