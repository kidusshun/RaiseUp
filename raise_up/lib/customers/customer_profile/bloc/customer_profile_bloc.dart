import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/customer_profile_history.dart';
import '../repository/customer_profile_repository.dart';

part 'customer_profile_event.dart';
part 'customer_profile_state.dart';

class CustomerProfileBloc extends Bloc<CustomerProfileEvent, CustomerProfileState> {
  CustomerProfileBloc() : super(CustomerProfileInitial()) {
    on<CustomerProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CustomerHistoryInitialEvent>(customerHistoryInitialEvent);
    on<CustomerHistoryInitialNameEvent>(customerHistoryInitialNameEvent);
  }

  Future<FutureOr<void>> customerHistoryInitialEvent(CustomerHistoryInitialEvent event, Emitter<CustomerProfileState> emit) async {
    dynamic response = await CustomerProfileRepositoryImpl().getHistory();
    // print(response);
    if (response.length==0){
      emit(CustomerProfileNoHistoryState());
    }
    else if (response[0].runtimeType != String) {
      emit(CustomerProfileInitialState(history: response));
    } else {
      emit(CustomerProfileFailedToLoadHistoryActionState(failure: response[0]));
    }
  }

  Future<FutureOr<void>> customerHistoryInitialNameEvent(CustomerHistoryInitialNameEvent event, Emitter<CustomerProfileState> emit) async {
    dynamic responseName=await CustomerProfileRepositoryImpl().getCustomerName();
    emit(CustomerProfileNameLoadedState(profileName: responseName));
  }
}
