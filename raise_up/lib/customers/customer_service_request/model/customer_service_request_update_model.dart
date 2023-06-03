class CustomerServiceRequestUpdate{
  String preferredDate;
  int serviceId;
  int technicianId;
  CustomerServiceRequestUpdate({required this.preferredDate,required this.serviceId,required this.technicianId});

  Map<String, dynamic> toJson() {
    return {
      'preferredDate': preferredDate,
      'serviceId': serviceId,
      'technicianId':technicianId,
    };
  }
}