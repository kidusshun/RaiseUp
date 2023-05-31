class CustomerConfirmationCredential{
  String email;
  String password;

  CustomerConfirmationCredential({required this.email,required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password':password,
    };
  }
}