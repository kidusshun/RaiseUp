import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:raise_up/customers/app_route_customers_constatnts.dart';
import 'package:go_router/go_router.dart';
import 'package:raise_up/customers/customer_technician_list/model/technician_credential_model.dart';
import 'package:raise_up/technician/technician_service_request/bloc/technician_service_request_bloc.dart';
import 'package:raise_up/technician/technician_profile/ui/technician_profile.dart';
import 'package:raise_up/customers/customer_technician_list/bloc/customer_technician_list_bloc.dart';
import 'package:raise_up/widgets/selectionButton.dart';

import '../../../landing/app_route_customers_constatnts.dart';
import '../../../widgets/dateselection.dart';
import '../model/customer_service_request_model.dart';

class CustomerTechnicianStList extends StatelessWidget {
  const CustomerTechnicianStList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerTechnicianListBloc(),
      child: CustomerTechnicianList(),
    );
  }
}

Widget build(BuildContext context) {
  return BlocProvider(
    create: (context) => CustomerTechnicianListBloc(),
    child: CustomerTechnicianList(),
  );
}

class CustomerTechnicianList extends StatefulWidget {
  const CustomerTechnicianList({Key? key}) : super(key: key);

  @override
  State<CustomerTechnicianList> createState() => _CustomerTechnicianListState();
}

class _CustomerTechnicianListState extends State<CustomerTechnicianList> {
  late CustomerTechnicianListBloc customerTechnicianListBloc;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CustomerTechnicianListBloc>(context)
        .add(CustomerTechnicianListInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Technician List"),
        backgroundColor: Color.fromRGBO(251, 165, 46, 1),
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
      body:
          BlocConsumer<CustomerTechnicianListBloc, CustomerTechnicianListState>(
        listenWhen: (previousState, state) {
          return state is CustomerTechnicianListActionState;
        },
        buildWhen: (previousState, state) {
          return state is! CustomerTechnicianListActionState;
        },
        listener: (context, state) {
          if (state is CustomerTechnicianListErrorActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(child: Text(state.error)),
                width: 200.0, // Width of the snackbar.
                behavior: SnackBarBehavior.floating,
                backgroundColor: Color.fromARGB(192, 221, 39, 39),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            );
          }
          if (state
              is customerTechnicianListBookButtonClickedSucessActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(child: Text(state.sucess)),
                width: 200.0, // Width of the snackbar.
                behavior: SnackBarBehavior.floating,
                backgroundColor: Color.fromARGB(192, 32, 193, 233),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            );
          } else if (state
              is customerTechnicianListBookButtonClickedFailureActionState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(child: Text(state.failure)),
                width: 200.0, // Width of the snackbar.
                behavior: SnackBarBehavior.floating,
                backgroundColor: Color.fromARGB(192, 216, 48, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          // print(state);
          if (state is CustomerTechnicianListInitState) {
            List<TechnicianCredential> credentials = state.technicianCredential;
            int len = state.technicianCredential.length;
            return ListView.builder(
              itemCount: len,
              itemBuilder: (context, index) {
                final contactInfo = credentials[index];
                List<Widget> expertise = [];
                contactInfo.expertise.forEach((value) {
                  expertise.add(SelectionButton(text: value, selected: false)
                      .selectionButton);
                });
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                      10, 5, 10, 15), // Increased spacing between cards
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      title: Text(
                        contactInfo.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromARGB(255, 156, 158, 6)),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Wrap(
                            spacing: 5.0,
                            children: expertise,
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async {
                                  DateTime dateAndTime =
                                      await DateSelection().selectDate(context);
                                  // print(dateAndTime);
                                  // print(contactInfo.id);
                                  String formattedDateTime =
                                      DateFormat("yyyy-MM-ddTHH:mm:ss").format(
                                          DateTime(
                                              dateAndTime.year,
                                              dateAndTime.month,
                                              dateAndTime.day,
                                              dateAndTime.hour,
                                              dateAndTime.minute));
                                  String isoDateString =
                                      formattedDateTime + "Z";
                                  context.read<CustomerTechnicianListBloc>().add(
                                      CustomerTechnicianListBookButtonClickedEvent(
                                          iso: isoDateString,
                                          technicianId: contactInfo.id,
                                          notes: "wheel disfunction"));
                                },
                                icon: Icon(Icons.book),
                                label: Text('Book'),
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(251, 165, 46,
                                      1), // Button background color
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.map,color:Color.fromARGB(192, 17, 160, 165)),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(contactInfo.location),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Container(
                  child: Text(
                "NO Technicians",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(122, 255, 193, 7),
                ),
              )),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromARGB(255, 206, 157, 10), 
        unselectedItemColor: Color.fromARGB(255, 99, 99, 99),
        selectedLabelStyle: TextStyle(color: Colors.amber), 
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        currentIndex: 0,
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
            BlocProvider.of<CustomerTechnicianListBloc>(context).add(CustomerTechnicianListInitEvent());
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
      )
    );
  }
}

