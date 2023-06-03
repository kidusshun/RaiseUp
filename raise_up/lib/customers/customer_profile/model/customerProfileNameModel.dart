class CustomerProfileName{
  String name;
  CustomerProfileName({required this.name});


  factory CustomerProfileName.fromJson(Map<String, dynamic> json) {
    return CustomerProfileName(
      name: json['name'],
    );
  }

}