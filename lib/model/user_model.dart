// ignore_for_file: non_constant_identifier_names

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? district;
  String? bloodType;
  String? tokenId;
  String? Password;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.lastName,
      this.district,
      this.bloodType,
      this.tokenId,
      this.Password});

  //takeing data from server
  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    email = map['email'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    district = map['district'];
    bloodType = map['bloodType'];
    Password = map['Password'];
    tokenId = map['tokenId'];
  }

  //sending data to our server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'district': district,
      'bloodType': bloodType,
      'tokenId': tokenId,
      'Password': Password
    };
  }
}
