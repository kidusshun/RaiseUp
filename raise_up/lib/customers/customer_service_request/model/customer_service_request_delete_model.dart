class CustomerServiceRequestDelete{
  int serviceId;
  CustomerServiceRequestDelete({required this.serviceId});

  Map<String,dynamic> toJson(){
    return {
      "serviceId":serviceId,
    };
  }
}