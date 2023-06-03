import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raise_up/technician/technician_service_request/model/technician_appointment_model.dart';
import 'package:raise_up/widgets/timeselection.dart';
import '../bloc/technician_service_request_bloc.dart';
import 'package:raise_up/technician/technician_profile/ui/technician_profile.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:raise_up/technician/app_route_constatnts.dart';
import '../model/technician_customer_service_request.dart';

class TechnicianServiceStRequest extends StatelessWidget {
  const TechnicianServiceStRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TechnicianServiceRequestBloc>(
      create: (context) => TechnicianServiceRequestBloc(),
      child: TechnicianServiceRequest(),
    );
  }
}

class TechnicianServiceRequest extends StatefulWidget {
  const TechnicianServiceRequest({Key? key}) : super(key: key);

  @override
  State<TechnicianServiceRequest> createState() =>
      _TechnicianServiceRequestState();
}

class _TechnicianServiceRequestState extends State<TechnicianServiceRequest> {
  late TechnicianServiceRequestBloc technicianServiceRequestBloc;

  @override
  void initState() {
    super.initState();
    technicianServiceRequestBloc =
        BlocProvider.of<TechnicianServiceRequestBloc>(context);
    technicianServiceRequestBloc.add(TechnicianAppointmentInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    // Hard-coded sample data for contacts

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        key: Key('title'),
        title: Text("Service Requests"),
        backgroundColor: Color.fromARGB(255, 67, 139, 149),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              final technicianServiceRequestBloc =
                  BlocProvider.of<TechnicianServiceRequestBloc>(context);
              technicianServiceRequestBloc
                  .add(TechnicianServiceRequestProfileButtonClicked());
              GoRouter.of(context).pushNamed(
                TechnicianAppRouteConstant.technicianProfile,
              );
              // technicianProfileBloc
              //     .add(TechnicianProfileTodoButtonClickedEvent());
              // Handle todo button functionality here
            },
          ),
        ],
      ),
      body: BlocConsumer<TechnicianServiceRequestBloc,
          TechnicianServiceRequestState>(
        listenWhen: (previousState, state) {
          return state is TechnicianServiceRequestActionState;
        },
        buildWhen: (previousState, state) {
          return state is! TechnicianServiceRequestActionState;
        },
        listener: (context, state) {
          // TODO: implement listener
          if (state is TechnicianAppointmentSuccessActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(child: Text(state.sucess)),
                width: 200.0, // Width of the snackbar.
                behavior: SnackBarBehavior.floating,
                backgroundColor: Color.fromARGB(192, 17, 160, 165),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            );
          } else if (state is TechnicianAppointmentUnSuccessfulActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(child: Text(state.failure)),
                width: 200.0, // Width of the snackbar.
                behavior: SnackBarBehavior.floating,
                backgroundColor: Color.fromARGB(192, 236, 59, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          // print("hi");
          if (state is TechnicianServiceRequestIntState) {
            List<TechnicianCustomerServiceRequest> serviceRequests =
                state.customerCredential;
            print(serviceRequests.length);
            return Container(
              child: ListView.builder(
                itemCount: serviceRequests.length,
                itemBuilder: (context, index) {
                  final contactInfo = serviceRequests[index];
                  return GestureDetector(
                    onTap: () async {
                      TimeSelection time = TimeSelection();
                      await time.selectTime(context);

                      // TimeOfDay time = TimeOfDay.now();
                      DateTime now = DateTime.now();
                      // DateTime dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
                      // String formattedTime = DateFormat('hh:mm a').format(dateTime);

                      String formattedDateTime =
                          DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime(
                              now.year,
                              now.month,
                              now.day,
                              time.hour,
                              time.minute));
                      String iso8601String = formattedDateTime + "Z";

                      print(iso8601String);
                      TechnicianAppointment appointment = TechnicianAppointment(
                          customer_id: contactInfo.id,
                          notes: "wheel fracture",
                          time: iso8601String);
                      context.read<TechnicianServiceRequestBloc>().add(
                          TechnicianAppointmentSetEvent(
                              appointment: appointment));
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: SingleChildScrollView(
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
                                'Name: //${contactInfo.name}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.calendar_month,
                                    color: Colors.teal[300]),
                                Text(DateFormat('dd-MM-yy')
                                    .format(contactInfo.date)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Container();
          }
          // return Container(
          //   child: ListView.builder(
          //     itemCount: contacts.length,
          //     itemBuilder: (context, index) {
          //       final contactInfo = contacts[index];

          //       return GestureDetector(
          //         onTap: () async {
          //           TimeSelection time = TimeSelection();
          //           await time.selectTime(context);

          //           // TimeOfDay time = TimeOfDay.now();
          //           DateTime now = DateTime.now();
          //           // DateTime dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
          //           // String formattedTime = DateFormat('hh:mm a').format(dateTime);

          //           String formattedDateTime =
          //               DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime(
          //                   now.year,
          //                   now.month,
          //                   now.day,
          //                   time.hour,
          //                   time.minute));
          //           String iso8601String = formattedDateTime + "Z";

          //           // print(iso8601String);
          //           TechnicianAppointment appointment = TechnicianAppointment(
          //               customer_id: contactInfo.id,
          //               notes: contactInfo.note,
          //               time: iso8601String);
          //           context.read<TechnicianServiceRequestBloc>().add(
          //                               TechnicianAppointmentSetEvent(
          //                                   appointment: appointment));
          //         },
          //         child: Padding(
          //           padding:
          //               EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          //           child: SingleChildScrollView(
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.circular(10),
          //                 boxShadow: [
          //                   BoxShadow(
          //                     color: Color.fromARGB(115, 93, 193, 206),
          //                     spreadRadius: 2,
          //                     blurRadius: 5,
          //                     offset:
          //                         Offset(0, 2), // changes position of shadow
          //                   ),
          //                 ],
          //               ),
          //               child: ListTile(
          //                 contentPadding: EdgeInsets.all(10),
          //                 leading: CircleAvatar(
          //                   backgroundColor:
          //                       Color.fromARGB(255, 67, 139, 149),
          //                   foregroundColor: Colors.white,
          //                   radius: 25.0,
          //                   child: Icon(Icons.person),
          //                 ),
          //                 title: Align(
          //                   alignment: Alignment.centerLeft,
          //                   child: Text(
          //                     'Name: //${contactInfo.customerName}',
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                       fontSize: 17,
          //                     ),
          //                   ),
          //                 ),
          //                 subtitle: Align(
          //                   alignment: Alignment.centerLeft,
          //                   child: Text(
          //                     'Phone No: ${contactInfo.customerPhoneNumber}',
          //                     style: TextStyle(
          //                       fontSize: 15,
          //                     ),
          //                   ),
          //                 ),
          //                 trailing: Row(
          //                   mainAxisSize: MainAxisSize.min,
          //                   children: [
          //                     Icon(Icons.calendar_month,
          //                         color: Colors.teal[300]),
          //                     Text("5/15/23"),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                final technicianServiceRequestBloc =
                    BlocProvider.of<TechnicianServiceRequestBloc>(context);
                technicianServiceRequestBloc.add(
                    TechnicianServiceRequestHomeNavigationButtonClickedEvent());

                GoRouter.of(context).pushNamed(
                  TechnicianAppRouteConstant.technicianServiceRequest,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                final technicianServiceRequestBloc =
                    BlocProvider.of<TechnicianServiceRequestBloc>(context);
                technicianServiceRequestBloc
                    .add(TechnicianServiceRequestRefreshButtonClickedEvent());

                // technicianProfileBloc
                //     .add(TechnicianProfileTodoButtonClickedEvent());
                // Handle todo button functionality here
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                final technicianServiceRequestBloc =
                    BlocProvider.of<TechnicianServiceRequestBloc>(context);
                technicianServiceRequestBloc.add(
                    TechnicianServiceRequestToDoNavigationButtonClickedEvent());
                GoRouter.of(context).pushNamed(
                  TechnicianAppRouteConstant.technicianAppointments,
                );
                // technicianProfileBloc
                //     .add(TechnicianProfileTodoButtonClickedEvent());
                // Handle todo button functionality here
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ContactInfo {
  String customerName;
  String customerPhoneNumber;
  int id;
  String note;

  ContactInfo(
      {required this.note,
      required this.id,
      required this.customerName,
      required this.customerPhoneNumber});
}
