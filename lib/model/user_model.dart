class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? district;
  String? bloodType;
  String? requiredDistrict;
  String? requiredBloodType;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.lastName,
      this.district,
      this.bloodType,
      this.requiredDistrict,
      this.requiredBloodType});

  //takeing data from server
  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    email = map['email'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    district = map['district'];
    bloodType = map['bloodType'];
    requiredDistrict = map['requiredDistrict'];
    requiredBloodType = map['requiredBloodType'];
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
      'requiredDistrict': requiredDistrict,
      'requiredBloodType': requiredBloodType,
    };
  }
}
