class TechnicianConfirmationCredential{
  String email;
  String password;

  TechnicianConfirmationCredential({required this.email,required this.password});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password':password,
    };
  }
}