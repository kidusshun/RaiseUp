import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raise_up/technician/technician_service_request/model/technician_appointment_model.dart';
import 'package:raise_up/widgets/timeselection.dart';
import 'package:raise_up/technician/technician_profile/ui/technician_profile.dart';
import 'package:intl/intl.dart';

import '../../../landing/app_route_customers_constatnts.dart';
import '../../app_route_customers_constatnts.dart';
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
    int selectedIndex=0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Technician appointments"),
        backgroundColor:Color.fromRGBO(251, 165, 46, 1),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(itemBuilder: (context)=>[
            PopupMenuItem(
              value:0,
              child:Row(children:[
                Icon(Icons.person,color:Color.fromARGB(192, 17, 160, 165)),
                SizedBox(width:3),
                Text("Profile")
              ])
            ),
            PopupMenuItem(
              value:1,
              child:Row(children:[
                Icon(Icons.logout,color:Color.fromARGB(255, 187, 45, 34)),
                SizedBox(width:3),
                Text("Logout")
              ])
            )
          ],
          onSelected: (item){
            switch(item){
              case(0):
                GoRouter.of(context).pushNamed(
                  LandingAppRouteConstant.customerProfile
                );
                break;
              case(1):
                GoRouter.of(context).pushNamed(
                  LandingAppRouteConstant.customerSignin
                );
            }
          },
          )
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
                  return 
                    // onTap: () async {
                      // TimeSelection time = TimeSelection();
                      // await time.selectTime(context);

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
                    // },
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(73, 255, 193, 7),
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
                                  Colors.amber,
                              foregroundColor: Colors.white,
                              radius: 25.0,
                              child: Icon(Icons.person),
                            ),
                            title: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Technician:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                        ),
                                      ),
                                      SizedBox(width:2),
                                      Text(
                                        '${contactInfo.name}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                          color:Color.fromARGB(255, 156, 158, 6)
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height:14),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.phone,color:Colors.teal),
                                          SizedBox(width:2),
                                          Text(
                                            '${contactInfo.phone}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color:Color.fromARGB(255, 156, 158, 6)
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width:8),
                                      Row(
                                        children: [
                                          Icon(Icons.map,color:Colors.teal),
                                          SizedBox(width:2),
                                          Text(
                                            '${contactInfo.location}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color:Color.fromARGB(255, 156, 158, 6),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),

                                ],
                              ),
                            ),
                            trailing: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.schedule,
                                        color: Colors.teal),
                                    // Text(DateFormat('dd-MM-yy').format(contactInfo.date)),
                                    Text(DateFormat('h:mm a')
                                        .format(contactInfo.time))
                                  ],
                                ),
                                SizedBox(height:4),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.calendar_month,
                                        color: Colors.teal),
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
                    );
                },
              ),
            );
          } else {
            return Center(
              child: Container(
                child:Text(
                  "No Appointment",
                  style:TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 38,
                    color:Color.fromARGB(171, 255, 193, 7),
                  ) ,
                )
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromARGB(255, 206, 157, 10), 
        unselectedItemColor: Color.fromARGB(255, 99, 99, 99),
        selectedLabelStyle: TextStyle(color: Colors.amber), 
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        currentIndex: 3,
        onTap:(item){
          if (item==0){
            GoRouter.of(context).pushNamed(
                  LandingAppRouteConstant.customerTechnicianList,
                );
          }else if(item==1){
            GoRouter.of(context).pushNamed(
                                          LandingAppRouteConstant
                                              .customerServiceRequest,
                                        );
          }else if(item==2){
            BlocProvider.of<CustomerAppointmentsBloc>(context).add(CustomerAppointInitialEvent());
          }else if(item==3){
            GoRouter.of(context).pushNamed(
                                          LandingAppRouteConstant
                                              .customerAppointment,
                                        );
          }
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            label: 'Pending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.refresh),
            label: 'Refresh',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Appointments',
          ),
        ],
      ),
    );
  }
}


