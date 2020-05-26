import 'dart:convert';

class User {
  int id;
  String fullName;
  String identityPassport;
  String contactNo;
  String address1;
  String address2;
  String postcode;
  String city;
  String state;
  String country;
  String idUrl;
  int status;

  User(
      {this.id,
      this.fullName,
      this.identityPassport,
      this.contactNo,
      this.address1,
      this.address2,
      this.postcode,
      this.city,
      this.state,
      this.country,
      this.idUrl,
      this.status});

  User.initial()
      : id = 0,
        fullName = '',
        identityPassport = '',
        contactNo = '',
        address1 = '',
        address2 = '',
        postcode = '',
        city = '',
        state = '',
        country = '',
        idUrl = '',
        status = 0;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['identityPassport'] = this.identityPassport;
    data['contactNo'] = this.contactNo;
    data['address1'] = this.address1;
    if (this.address2.length > 0) {
      data['address2'] = this.address2;
    }
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    if (this.idUrl != null) {
      data['idUrl'] = this.idUrl;
    }
    if (this.status != null) {
      data['status'] = this.status;
    }
    return data;
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'],
      fullName: map['fullName'],
      identityPassport: map['identityPassport'],
      contactNo: map['contactNo'],
      address1: map['address1'],
      address2: map['address2'],
      postcode: map['postcode'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      idUrl: map['idUrl'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String src) => fromMap(json.decode(src));
}
