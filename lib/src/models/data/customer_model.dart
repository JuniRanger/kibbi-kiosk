class CustomerModel {
  String? firstname;
  String? lastname;
  String? email;
  int? phone;
  String? password;
  String? role;
  String? imageUrl;

  CustomerModel(
      {
        this.firstname,
        this.lastname,
        this.email,
        this.phone,
        this.role,
        this.password,
        this.imageUrl
      });

  CustomerModel copyWith({
    String? firstname,
    String? lastname,
    String? email,
    int? phone,
    String? role,
    String? password,
    String? imageUrl,
  }) =>
      CustomerModel(
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        role: role ?? this.role,
        password: password ?? this.password,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    phone: json["phone"],
    role: json["role"],
    password: json["password"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonMap = {
      "firstname": firstname,
      "email": email,
      "phone": phone,
      "role": role,
    };

    if (password != null) {
      jsonMap["password"] = password;
    }
    if (imageUrl != null) {
      jsonMap["imageUrl"] = imageUrl;
    }
    if (lastname != null) {
      jsonMap["lastname"] = lastname;
    }

    return jsonMap;
  }

}

