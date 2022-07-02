class User {
  static const obj = 'user';
  static const idK = 'id';
  static const nameK = 'name';
  static const emailK = 'email';
  static const passwordK = 'password';
  static const uploadedFileK = 'uploadedFile';

  final String id;
  final String name;
  final String email;
  final String password;
  final String uploadedFile;
  final String birthPlace;
  final String birthDate;
  final String gender;
  final String address;

  User(this.name, this.email, this.id, this.password, this.uploadedFile,
      this.birthPlace, this.birthDate, this.gender, this.address);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        password = json['password'],
        uploadedFile = json['uploadedFile'],
        birthPlace = json['birthPlace'],
        birthDate = json['birthDate'],
        gender = json['gender'],
        address = json['address'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['uploadedFile'] = uploadedFile;
    data['birthPlace'] = birthPlace;
    data['birthDate'] = birthDate;
    data['gender'] = gender;
    data['address'] = address;
    return data;
  }
}
