class User {
  static const String collectionName = 'Users';
  final String? fullName;
  final String? email;
  final String? id;
  final String? phone;
  final int? age;
  User({
    this.fullName,
    this.email,
    this.id,
    this.phone,
    this.age,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'FullName': fullName,
      'Email': email,
      'Id': id,
      'Phone': phone,
      'Age': age,
    };
  }

  factory User.fromFirestore(Map<String, dynamic>? data) {
    return User(
        fullName: data?['FullName'],
        email: data?['Email'],
        id: data?['Id'],
        phone: data?['Phone'],
        age: data?['Age']);
  }
}
