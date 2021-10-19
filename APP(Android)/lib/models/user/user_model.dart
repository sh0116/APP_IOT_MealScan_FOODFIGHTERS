class User {
  final String? name;
  final String? service_no;
  final String? password;
  final int? upload_time;
  User(
    this.name,
    this.service_no,
    this.password,
    this.upload_time,
  );
  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['name'], json['service_no'], json['password'], json['upload_time']);
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'service_no': service_no,
      'password': password,
      'upload_time': upload_time
    };
  }
}
