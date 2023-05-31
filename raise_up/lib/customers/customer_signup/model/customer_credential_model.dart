class CustomerCredential{
  String email;
  String name;
  String password;

  CustomerCredential({required this.email,required this.name,required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'password':password,
    };
  }
}