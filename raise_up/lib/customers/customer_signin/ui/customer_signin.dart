import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raise_up/customers/customer_signin/bloc/customer_signin_bloc.dart';

class CustomerSignIn extends StatefulWidget {
  const CustomerSignIn({super.key});

  @override
  State<CustomerSignIn> createState() => _CustomerSignInState();
}

class _CustomerSignInState extends State<CustomerSignIn> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerSignInBloc, CustomerSignInState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold();
      },
    );
  }
}
