class UserModel {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String birthDate;
  final String gender;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.birthDate,
    required this.gender,
  });

  // Convert UserModel to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'birthDate': birthDate,
      'gender': gender,
    };
  }

  // Create UserModel from Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      birthDate: map['birthDate'] ?? '',
      gender: map['gender'] ?? '',
    );
  }

  // Create a copy of UserModel with updated fields
  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? birthDate,
    String? gender,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, phone: $phone, birthDate: $birthDate, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.password == password &&
        other.birthDate == birthDate &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        password.hashCode ^
        birthDate.hashCode ^
        gender.hashCode;
  }
}



