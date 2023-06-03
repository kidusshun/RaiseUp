import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raise_up/technician/technician_service_request/model/technician_appointment_model.dart';
import 'package:raise_up/widgets/timeselection.dart';
import 'package:raise_up/technician/technician_profile/ui/technician_profile.dart';
import 'package:intl/intl.dart';

import '../bloc/customer_appointments_bloc.dart';
import '../model/customer_appointments_model.dart';

class CustomerStAppointment extends StatelessWidget {
  const CustomerStAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerAppointmentsBloc(),
      child: CustomerAppointment(),
    );
  }
}

class CustomerAppointment extends StatefulWidget {
  const CustomerAppointment({Key? key}) : super(key: key);

  @override
  State<CustomerAppointment> createState() => _CustomerServiceRequestState();
}

class _CustomerServiceRequestState extends State<CustomerAppointment> {
  // final TechnicianServiceRequestBloc technicianServiceRequestBloc =
  //     TechnicianServiceRequestBloc();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CustomerAppointmentsBloc>(context)
        .add(CustomerAppointInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    // Hard-coded sample data for contacts
    return Scaffold(
      appBar: AppBar(
        title: Text("appointments"),
        backgroundColor: Color.fromARGB(255, 67, 139, 149),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<CustomerAppointmentsBloc, CustomerAppointmentsState>(
        listenWhen: (previousState, state) {
          return state is CustomerAppointmentsActionState;
        },
        buildWhen: (previousState, state) {
          return state is! CustomerAppointmentsActionState;
        },
        listener: (context, state) {
          // TODO: implement listener
          if (state is CustomerAppointmentsLoadingActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(child: Text("Loading...")),
                width: 200.0, // Width of the snackbar.
                behavior: SnackBarBehavior.floating,
                backgroundColor: Color.fromARGB(192, 17, 160, 165),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            );
          } else if (state is CustomerAppointmentsErrorActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(child: Text(state.error)),
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
          if (state is CustomerAppointmentsInitState) {
            List<CustomerAppointments> appointments = state.customerCredential;
            // print(appointments.length);
            return Container(
              child: ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final contactInfo = appointments[index];
                  return GestureDetector(
                    onTap: () async {
                      TimeSelection time = TimeSelection();
                      await time.selectTime(context);

                      // // TimeOfDay time = TimeOfDay.now();
                      // DateTime now = contactInfo.date;
                      // print(now);
                      // // DateTime dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
                      // // String formattedTime = DateFormat('hh:mm a').format(dateTime);

                      // String formattedDateTime =
                      //     DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime(
                      //         now.year,
                      //         now.month,
                      //         now.day,
                      //         time.hour,
                      //         time.minute));
                      // String iso8601String = formattedDateTime + "Z";

                      // // print(iso8601String);
                      // TechnicianAppointment appointment = TechnicianAppointment(
                      //     customer_id: contactInfo.id,
                      //     notes: "wheel fracture",
                      //     time: iso8601String);
                      // context.read<TechnicianAppointmentsBloc>().add(
                      //                     TechnicianAppointmentSetEvent(
                      //                         appointment: appointment));
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
                                        .format(contactInfo.time))
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.calendar_month,
                                        color: Colors.teal[300]),
                                    // Text(DateFormat('dd-MM-yy').format(contactInfo.date)),
                                    Text(DateFormat('dd-MM-yy')
                                        .format(contactInfo.time))
                                  ],
                                ),
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
