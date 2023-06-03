class CustomerServiceRequestModel{
  String name;
  DateTime date;
  int technicianId;
  int serviceId;
  // String status;
  CustomerServiceRequestModel({required this.name,required this.date,required this.technicianId,required this.serviceId});

  factory CustomerServiceRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerServiceRequestModel(
      name: json['technician']['name'],
      date: DateTime.parse(json['preferredDate']),
      technicianId:json['technician']['id'],
      serviceId:json['id'],
      // status:json['status'],
    );
  }
}