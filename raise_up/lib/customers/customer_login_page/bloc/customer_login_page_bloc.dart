import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'customer_login_page_event.dart';
part 'customer_login_page_state.dart';

class CustomerLoginPageBloc extends Bloc<CustomerLoginPageEvent, CustomerLoginPageState> {
  CustomerLoginPageBloc() : super(CustomerLoginPageInitial()) {
    on<CustomerLoginPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
