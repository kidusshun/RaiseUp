import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raise_up/technician/technician_appointments/bloc/technician_appointments_bloc.dart';

class TechnicianAppointments extends StatefulWidget {
  const TechnicianAppointments({Key? key}) : super(key: key);

  @override
  State<TechnicianAppointments> createState() =>
      _TechnicianAppointments();
}

class _TechnicianAppointments extends State<TechnicianAppointments> {
  final TechnicianAppointmentsBloc technicianAppointmentsBloc =
      TechnicianAppointmentsBloc();

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

    return BlocConsumer<TechnicianAppointmentsBloc,
        TechnicianAppointmentsState>(
      bloc: technicianAppointmentsBloc,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Appointments"),
            backgroundColor: Color.fromARGB(255, 67, 139, 149),
          ),
          body: Container(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contactInfo = contacts[index];
                return GestureDetector(
                  onTap: () {print(contactInfo.customerName);},
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
                              offset: Offset(0, 2), // changes position of shadow
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
                              style:TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          trailing:Text("5/15/23"),
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
