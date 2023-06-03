import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../landing/app_route_customers_constatnts.dart';
import '../../../widgets/dateselection.dart';
import '../../app_route_customers_constatnts.dart';
import '../bloc/customer_service_request_bloc.dart';
import '../model/customer_service_request_delete_model.dart';
import '../model/customer_service_request_model.dart';
import '../model/customer_service_request_update_model.dart';

class CustomerServiceStRequest extends StatelessWidget {
  const CustomerServiceStRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CustomerServiceRequestBloc>(
      create: (context) => CustomerServiceRequestBloc(),
      child: CustomerServiceRequest(),
    );
  }
}

class CustomerServiceRequest extends StatefulWidget {
  const CustomerServiceRequest({Key? key}) : super(key: key);

  @override
  State<CustomerServiceRequest> createState() =>
      _CustomerServiceRequestState();
}

class _CustomerServiceRequestState extends State<CustomerServiceRequest> {
  late CustomerServiceRequestBloc customerServiceRequestBloc;

  @override
  void initState() {
    super.initState();
    customerServiceRequestBloc =
        BlocProvider.of<CustomerServiceRequestBloc>(context);
    customerServiceRequestBloc.add(CustomerServiceRequestInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    // Hard-coded sample data for contacts

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        key: Key('title'),
        title: Text("Service Requests"),
        backgroundColor: Color.fromRGBO(251, 165, 46, 1),
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
      body: BlocConsumer<CustomerServiceRequestBloc,
          CustomerServiceRequestState>(
        listenWhen: (previousState, state) {
          return state is CustomerServiceRequestActionState;
        },
        buildWhen: (previousState, state) {
          return state is! CustomerServiceRequestActionState;
        },
        listener: (context, state) {
          // TODO: implement listener
          if (state is CustomerAppointmentSuccessActionState) {
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
          } else if (state is CustomerAppointmentUnSuccessfulActionState) {
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
          }else if (state is CustomerServiceRequestSucssesfullyDeletedActionState){
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
          }else if (state is CustomerServiceRequestFailedToDeleteActionState) {
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
          }else if (state is CustomerServiceRequestSucssesfullyUpdatedActionState){
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
          }else if (state is CustomerServiceRequestFailedToUpdateActionState) {
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
          if (state is CustomerServiceRequestIntState) {
            List<CustomerServiceRequestModel> serviceRequests =
                state.technicianCredential;
            // print(serviceRequests.length);
            return Container(
              child: ListView.builder(
                itemCount: serviceRequests.length,
                itemBuilder: (context, index) {
                  // print("hi");
                  final contactInfo = serviceRequests[index];
                  return Dismissible(
                    key:Key(contactInfo.serviceId.toString()),
                    direction:DismissDirection.startToEnd,
                    onDismissed: (DismissDirection direction){
                      CustomerServiceRequestDelete serviceRequestDelete=CustomerServiceRequestDelete(serviceId: contactInfo.serviceId);
                      if(direction==DismissDirection.startToEnd){
                        context.read<CustomerServiceRequestBloc>().add(
                          CustomerServiceRequestDeleteButtonClickedEvent(serviceRequestDelete: serviceRequestDelete)
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
                        DateTime dateAndTime =
                                        await DateSelection().selectDate(context);
                                    print(dateAndTime);
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
                  
                        print(isoDateString);
                        CustomerServiceRequestUpdate updatedServiceRequest=CustomerServiceRequestUpdate(preferredDate:isoDateString ,serviceId: contactInfo.serviceId,technicianId: contactInfo.technicianId);
                          context.read<CustomerServiceRequestBloc>().add(
                            CustomerServiceRequestTechnicianCardClickedEvent(updatedServiceRequest: updatedServiceRequest)
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
                                child: Row(
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
                    color: Color.fromARGB(167, 255, 193, 7),
                  ),
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
        currentIndex: 1,
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
            BlocProvider.of<CustomerServiceRequestBloc>(context).add(CustomerServiceRequestInitialEvent());
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