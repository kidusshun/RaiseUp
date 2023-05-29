import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'customer_signin_event.dart';
part 'customer_signin_state.dart';

class CustomerSignInBloc extends Bloc<CustomerSignInEvent, CustomerSignInState> {
  CustomerSignInBloc() : super(CustomerSignInInitial()) {
    on<CustomerSignInEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
