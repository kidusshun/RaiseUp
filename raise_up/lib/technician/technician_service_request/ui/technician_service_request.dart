import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raise_up/technician/technician_service_request/model/technician_appointment_model.dart';
import 'package:raise_up/widgets/timeselection.dart';
import '../bloc/technician_service_request_bloc.dart';
import 'package:raise_up/technician/technician_profile/ui/technician_profile.dart';
import 'package:intl/intl.dart';

import '../model/technician_customer_service_request.dart';

class TechnicianServiceStRequest extends StatelessWidget {
  const TechnicianServiceStRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TechnicianServiceRequestBloc(),
      child:TechnicianServiceRequest(),
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
  // final TechnicianServiceRequestBloc technicianServiceRequestBloc =
  //     TechnicianServiceRequestBloc();
    @override
  void initState() {
    super.initState();
    BlocProvider.of<TechnicianServiceRequestBloc>(context).add(TechnicianAppointmentInitialEvent());
  }
  @override
  Widget build(BuildContext context) {
    // Hard-coded sample data for contacts
    final List<ContactInfo> contacts = [
      ContactInfo(
          id: 1,
          note: "Engine Defect",
          customerName: 'John Doe',
          customerPhoneNumber: '1234567890'),
      ContactInfo(
          id: 2,
          note: "Spoiler Defect",
          customerName: 'Jane Smith',
          customerPhoneNumber: '0987654321'),
      ContactInfo(
          id: 3,
          note: "wheel Defect",
          customerName: 'Bob Johnson',
          customerPhoneNumber: '09876543210'),
      ContactInfo(
          id: 4,
          note: "Spoiler Defect",
          customerName: 'Jane Smit',
          customerPhoneNumber: '098765432'),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text("Service Requests"),
          backgroundColor: Color.fromARGB(255, 67, 139, 149),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
            ),
          ],
        ),
        body: BlocConsumer<TechnicianServiceRequestBloc, TechnicianServiceRequestState>(
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
              }
              else if (state is TechnicianAppointmentUnSuccessfulActionState) {
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
            if (state is TechnicianServiceRequestIntState){
              List<TechnicianCustomerServiceRequest> serviceRequests=state.customerCredential;
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
                                Text(DateFormat('dd-MM-yy').format(contactInfo.date)),
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
            }
            else{
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
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.refresh),
              label: 'Refresh',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'To Do',
            ),
          ],
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
