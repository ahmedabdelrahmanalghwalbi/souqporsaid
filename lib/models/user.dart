class User {
  String name;
  String email;
  bool isAdmin;
  String password;
  String createdAt;
  String street;
  String apartment;
  String city;
  String zip;
  String country;
  String phone;

  User(
      {this.name,
        this.email,
        this.isAdmin,
        this.password,
        this.createdAt,
        this.street,
        this.apartment,
        this.city,
        this.zip,
        this.country,
        this.phone});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    isAdmin = json['isAdmin'];
    password = json['password'];
    createdAt = json['createdAt'];
    street = json['street'];
    apartment = json['apartment'];
    city = json['city'];
    zip = json['zip'];
    country = json['country'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['isAdmin'] = this.isAdmin;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['street'] = this.street;
    data['apartment'] = this.apartment;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['phone'] = this.phone;
    return data;
  }
}