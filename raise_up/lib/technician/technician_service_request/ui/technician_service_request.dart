import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raise_up/technician/technician_service_request/model/technician_appointment_model.dart';
import 'package:raise_up/widgets/timeselection.dart';
import '../bloc/technician_service_request_bloc.dart';
import 'package:raise_up/technician/technician_profile/ui/technician_profile.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:raise_up/technician/app_route_constatnts.dart';
import '../model/technician_appointment_status_model.dart';
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
              // final technicianServiceRequestBloc =
              //     BlocProvider.of<TechnicianServiceRequestBloc>(context);
              // technicianServiceRequestBloc
              //     .add(TechnicianServiceRequestProfileButtonClickedEvent());
              GoRouter.of(context).pushNamed(
                TechnicianAppRouteConstant.technicianProfile,
              );
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
          if (state is TechnicianServiceRequestIntState) {
            List<TechnicianCustomerServiceRequest> serviceRequests =
                state.customerCredential;
            // print(serviceRequests.length);
            return Container(
              child: ListView.builder(
                itemCount: serviceRequests.length,
                itemBuilder: (context, index) {
                  final contactInfo = serviceRequests[index];
                  return GestureDetector(
                    onTap: () async {
                      TimeSelection time = TimeSelection();
                      dynamic tt=await time.selectTime(context);
                      DateTime now = contactInfo.date;

                      String formattedDateTime =
                          DateFormat("yyyy-MM-ddTHH:mm:ss").format(DateTime(
                              now.year,
                              now.month,
                              now.day,
                              time.hour,
                              time.minute));
                      String iso8601String = formattedDateTime + "Z";

                      // print(iso8601String);
                      TechnicianAppointment appointment = TechnicianAppointment(
                          customer_id: contactInfo.customerId,
                          notes: "wheel fracture",
                          time: iso8601String);
                      TechnicianAppointmentStatus status=TechnicianAppointmentStatus(
                        serviceId: contactInfo.serviceId,
                        status:contactInfo.status,
                      );
                      // print(tt);
                      if (tt!=null){
                        context.read<TechnicianServiceRequestBloc>().add(
                          TechnicianAppointmentSetEvent(
                              appointment: appointment,
                              status:status,
                              ));
                      }
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
            return Center(
              child: Container(
                child:Text(
                  "NO REQUESTS",
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
                final technicianServiceRequestBloc =
                    BlocProvider.of<TechnicianServiceRequestBloc>(context);
                technicianServiceRequestBloc
                    .add(TechnicianAppointmentInitialEvent());
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                GoRouter.of(context).pushNamed(
                  TechnicianAppRouteConstant.technicianAppointments,
                );
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
