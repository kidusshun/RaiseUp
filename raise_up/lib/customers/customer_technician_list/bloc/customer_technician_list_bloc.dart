import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'customer_technician_list_event.dart';
part 'customer_technician_list_state.dart';

class CustomerTechnicianListBloc
    extends Bloc<CustomerTechnicianListEvent, CustomerTechnicianListState> {
  CustomerTechnicianListBloc() : super(CustomerTechnicianListInitial()) {
    on<CustomerTechnicianListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
