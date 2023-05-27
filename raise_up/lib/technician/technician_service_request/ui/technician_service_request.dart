import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/technician_service_request_bloc.dart';
import 'package:raise_up/technician/technician_profile/ui/technician_profile.dart';

class TechnicianServiceRequest extends StatefulWidget {
  const TechnicianServiceRequest({Key? key}) : super(key: key);

  @override
  State<TechnicianServiceRequest> createState() =>
      _TechnicianServiceRequestState();
}

class _TechnicianServiceRequestState extends State<TechnicianServiceRequest> {
  final TechnicianServiceRequestBloc technicianServiceRequestBloc =
      TechnicianServiceRequestBloc();

  @override
  Widget build(BuildContext context) {
    // Hard-coded sample data for contacts
    final List<ContactInfo> contacts = [
      ContactInfo(customerName: 'John Doe', customerPhoneNumber: '1234567890'),
      ContactInfo(
          customerName: 'Jane Smith', customerPhoneNumber: '0987654321'),
      ContactInfo(
          customerName: 'Bob Johnson', customerPhoneNumber: '9876543210'),
    ];

    return BlocConsumer<TechnicianServiceRequestBloc,
        TechnicianServiceRequestState>(
      bloc: technicianServiceRequestBloc,
      listenWhen: (previous, current) =>
          current is TechnicianServiceRequestActionState,
      buildWhen: (previous, current) =>
          current != TechnicianServiceRequestActionState,
      listener: (context, state) {
        if (state is TechnicianServiceRequestNavigateToProfileState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TechnicianProfile()));
        } else if (state
            is TechnicianServiceRequestNavigateToAppointmentApprovalState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TechnicianProfile()));
        }
        // Add any necessary listeners for state changes
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Incoming Requests"),
            backgroundColor: Color.fromARGB(255, 67, 139, 149),
            actions: [
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  technicianServiceRequestBloc.add(
                      TechnicianServiceRequestCustomerProfileClickedEvent());
                  // Handle profile icon button press
                },
              ),
            ],
          ),
          body: Container(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contactInfo = contacts[index];

                return GestureDetector(
                  onTap: () {
                    technicianServiceRequestBloc.add(
                        TechnicianServiceRequestCustomerAppointmentClickedEvent());
                    // Handle contact tap event
                    // You can call events or perform any action here
                    print('Contact tapped: ${contactInfo.customerName}');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                            backgroundColor: Color.fromARGB(255, 67, 139, 149),
                            foregroundColor: Colors.white,
                            radius: 25.0,
                            child: Icon(Icons.person),
                          ),
                          title: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Name: ${contactInfo.customerName}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          subtitle: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Phone Number: ${contactInfo.customerPhoneNumber}',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          trailing: Text("5/15/23"),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
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
      },
    );
  }
}

class ContactInfo {
  final String customerName;
  final String customerPhoneNumber;

  ContactInfo({required this.customerName, required this.customerPhoneNumber});
}
