import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:raise_up/technician/technician_service_request/bloc/technician_service_request_bloc.dart';
import 'package:raise_up/technician/technician_service_request/model/technician_appointment_model.dart';
import 'package:raise_up/widgets/timeselection.dart';
import 'package:raise_up/technician/technician_profile/ui/technician_profile.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:raise_up/technician/app_route_constatnts.dart';

import '../bloc/technician_appointments_bloc.dart';
import '../model/technician_appointment_delete_model.dart';
import '../model/technician_appointments_model.dart';
import '../model/technician_appointments_update_model.dart';

class TechnicianStAppointment extends StatelessWidget {
  const TechnicianStAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TechnicianAppointmentsBloc(),
      child: TechnicianAppointment(),
    );
  }
}

class TechnicianAppointment extends StatefulWidget {
  const TechnicianAppointment({Key? key}) : super(key: key);

  @override
  State<TechnicianAppointment> createState() =>
      _TechnicianServiceRequestState();
}

class _TechnicianServiceRequestState extends State<TechnicianAppointment> {
  // final TechnicianServiceRequestBloc technicianServiceRequestBloc =
  //     TechnicianServiceRequestBloc();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TechnicianAppointmentsBloc>(context)
        .add(TechnicianAppointInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    // Hard-coded sample data for contacts
    return Scaffold(
      appBar: AppBar(
        title: Text("Technician Appointments"),
        backgroundColor: Color.fromARGB(255, 67, 139, 149),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              GoRouter.of(context).pushNamed(
                TechnicianAppRouteConstant.technicianProfile,
              );
            },
          ),
        ],
      ),
      body:
          BlocConsumer<TechnicianAppointmentsBloc, TechnicianAppointmentsState>(
        listenWhen: (previousState, state) {
          return state is TechnicianAppointmentsActionState;
        },
        buildWhen: (previousState, state) {
          return state is! TechnicianAppointmentsActionState;
        },
        listener: (context, state) {
          // TODO: implement listener
          if (state is TechnicianAppointmentsSucssesfullyUpdatedActionState) {
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
          } else if (state is TechnicianAppointmentsFailedToUpdateActionState) {
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
          } else if (state is TechnicianAppointmentsSucssesfullyDeletedActionState) {
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
          }else if (state is TechnicianAppointmentsFailedToDeleteActionState) {
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
          if (state is TechnicianAppointmentsInitState) {
            List<TechnicianAppointments> appointments =
                state.customerCredential;
            // print(appointments.length);
            return Container(
              child: ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final contactInfo = appointments[index];
                  return Dismissible(
                    key:Key(contactInfo.appointmentId.toString()),
                    direction:DismissDirection.startToEnd,
                    onDismissed: (DismissDirection direction){
                      TechnicianAppointmentDelete appointmentDelete=TechnicianAppointmentDelete(appointmentId: contactInfo.appointmentId);
                      if(direction==DismissDirection.startToEnd){
                        context.read<TechnicianAppointmentsBloc>().add(
                          TechnicianAppointmentDeleteButtonClickedEvent(appointmentDelete: appointmentDelete)
                        );
                      }
                    },
                    background: Container(
                    color: Color.fromARGB(255, 255, 165, 142), // Background color when sliding right
                    child: Row(
                      children:[
                        Icon(Icons.delete),
                        Text("Delete")
                        ]
                      ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16.0),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        TimeSelection time = TimeSelection();
                        await time.selectTime(context);
                        String formattedDateTime =
                            DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime(
                                contactInfo.time.year,
                                contactInfo.time.month,
                                contactInfo.time.day,
                                time.hour,
                                time.minute));
                        String iso8601String = formattedDateTime + "Z";
                        // print(iso8601String);
                        // contactInfo.appointmentId;
                        TechnicianAppointmentsUpdate updatedAppointment=TechnicianAppointmentsUpdate(appointmentId:contactInfo.appointmentId,time:iso8601String,status:contactInfo.status);
                        context.read<TechnicianAppointmentsBloc>().add(
                          TechnicianAppointmentsCustomerCardClickedEvent(updatedAppointment: updatedAppointment)
                        );
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
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Container(
                child:Text(
                  "NO APPOINTMENTS",
                  style:TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(123, 0, 150, 135),
                  ),
                  )
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                GoRouter.of(context).pushNamed(
                  TechnicianAppRouteConstant.technicianServiceRequest,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                BlocProvider.of<TechnicianAppointmentsBloc>(context).add(TechnicianAppointInitialEvent());
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
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
