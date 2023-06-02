part of 'customer_technician_list_bloc.dart';

@immutable
abstract class CustomerTechnicianListEvent {}

class CustomerTechnicianListInitEvent extends CustomerTechnicianListEvent{}

class CustomerTechnicianListBookButtonClickedEvent extends CustomerTechnicianListEvent{
  String iso;
  int technicianId;
  String notes;
  CustomerTechnicianListBookButtonClickedEvent({required this.iso,required this.technicianId,required this.notes});
}
