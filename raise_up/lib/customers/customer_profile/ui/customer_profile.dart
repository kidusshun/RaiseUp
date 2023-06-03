import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../landing/app_route_customers_constatnts.dart';
import '../../app_route_customers_constatnts.dart';
import '../../customer_service_request/ui/customer_service_request.dart';
import '../bloc/customer_profile_bloc.dart';
import '../model/customer_profile_history.dart';

class CustomerStProfile extends StatelessWidget {
  const CustomerStProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerProfileBloc(),
      child: CustomerProfile(),
    );
  }
}

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key? key});

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CustomerProfileBloc>(context)
        .add(CustomerHistoryInitialEvent());
    BlocProvider.of<CustomerProfileBloc>(context)
    .add(CustomerHistoryInitialNameEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        color:
            Color.fromRGBO(251, 165, 46, 1), // Set background color to green
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(70),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor:Color.fromARGB(255, 172, 132, 14),
              radius: 60,
              child: Icon(
                Icons.person,
                size: 80,
              ),
            ),
            SizedBox(height: 10),
            BlocConsumer<CustomerProfileBloc, CustomerProfileState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                // print(state);
                if (state is CustomerProfileNameLoadedState){
                  return Text(
                  state.profileName,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                );
                }else{
                  return Text("No Data");
                }
              },
            ),
          ],
        ),
      ),
      SizedBox(height: 15),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
            child: Text(
              'History:',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      BlocConsumer<CustomerProfileBloc, CustomerProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Column(
            children: [
              BlocConsumer<CustomerProfileBloc, CustomerProfileState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is CustomerProfileInitialState) {
                    List<CustomerProfileHistory> appointmentHistory = state.history;
                    return Container(
                        child: ListView.builder(
                      itemCount: appointmentHistory.length,
                      itemBuilder: (context, index) {
                        CustomerProfileHistory contactInfo=appointmentHistory[index];
                        return SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(115, 93, 193, 206),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset:
                                      Offset(0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10),
                              leading: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 67, 139, 149),
                                foregroundColor: Colors.white,
                                radius: 25.0,
                                child: Icon(Icons.person),
                              ),
                              title: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Name: ${contactInfo.name}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              trailing: Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.schedule,
                                          color: Colors.teal[300]),
                                      // Text(DateFormat('dd-MM-yy').format(contactInfo.date)),
                                      Text(DateFormat('h:mm a')
                                          .format(contactInfo.dateTime))
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.calendar_month,
                                          color: Colors.teal[300]),
                                      // Text(DateFormat('dd-MM-yy').format(contactInfo.date)),
                                      Text(DateFormat('dd-MM-yy')
                                          .format(contactInfo.dateTime))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ));
                  } else {
                    return Center(
                      child: Container(
                          child: Text("No History",
                              style: TextStyle(
                                  color: Color.fromRGBO(251, 166, 46, 0.692),
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold))),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    ]),

        bottomNavigationBar:
            BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              GoRouter.of(context).pushNamed(
                LandingAppRouteConstant.customerServiceRequest,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.build),
            onPressed: () {
              GoRouter.of(context).pushNamed(
                LandingAppRouteConstant.customerAppointment,
              );
            },
          ),
        ],
      ),
    ));
  }
}