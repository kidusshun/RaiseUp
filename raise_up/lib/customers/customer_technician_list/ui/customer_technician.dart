import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raise_up/technician/technician_service_request/bloc/technician_service_request_bloc.dart';
import 'package:raise_up/technician/technician_profile/ui/technician_profile.dart';
import 'package:raise_up/customers/customer_technician_list/bloc/customer_technician_list_bloc.dart';
import 'package:raise_up/widgets/selectionButton.dart';

class CustomerTechnicianList extends StatefulWidget {
  const CustomerTechnicianList({Key? key}) : super(key: key);

  @override
  State<CustomerTechnicianList> createState() => _CustomerTechnicianListState();
}

class _CustomerTechnicianListState extends State<CustomerTechnicianList> {
  final TechnicianServiceRequestBloc technicianServiceRequestBloc =
      TechnicianServiceRequestBloc();

  @override
  Widget build(BuildContext context) {
    // Hard-coded sample data for contacts
    final List<ContactInfo> contacts = [
      ContactInfo(name: 'John Doe', phoneNumber: '1234567890'),
      ContactInfo(name: 'Jane Smith', phoneNumber: '0987654321'),
      ContactInfo(name: 'Bob Johnson', phoneNumber: '9876543210'),
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
            title: Text("Customer Technician List"),
            backgroundColor: Color.fromRGBO(251, 165, 46, 1), // App bar color
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
          body: ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contactInfo = contacts[index];

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
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            contactInfo.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(Icons.phone),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SelectionButton(
                              text: 'Button 1',
                            ),
                            SelectionButton(
                              text: 'Button 2',
                            ),
                            SelectionButton(
                              text: 'Button 3',
                            ),
                            SelectionButton(
                              text: 'Button 4',
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                // Handle book button press
                              },
                              icon: Icon(Icons.book),
                              label: Text('Book'),
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(
                                    251, 165, 46, 1), // Button background color
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            Icon(Icons.map),
                            Text('Location'),
                            Icon(Icons.phone),
                            Text(contactInfo.phoneNumber),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class ContactInfo {
  final String name;
  final String phoneNumber;

  ContactInfo({required this.name, required this.phoneNumber});
}

// class SelectionButton extends StatelessWidget {
//   late Color backgroundColor;
//   late String text;
//   late Color borderColor;
//   bool isSelected;
//   late Function(bool) onSelected;

//   SelectionButton({
//     required this.text,
//     this.isSelected = false,
//     void Function(bool)? onSelected,
//   }) {
//     colorPicker();
//     this.onSelected = onSelected ?? (bool value) {};
//   }

//   void colorPicker() {
//     if (isSelected) {
//       backgroundColor = Colors.grey[300]!;
//       borderColor = Colors.transparent;
//     } else {
//       backgroundColor = Colors.transparent;
//       borderColor = Colors.grey[300]!;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         isSelected = !isSelected;
//         colorPicker();
//         onSelected(isSelected);
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//         alignment: Alignment.center,
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 14.0,
//           ),
//         ),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           border: Border.all(
//             color: borderColor,
//             width: 1.0,
//           ),
//           color: backgroundColor,
//         ),
//       ),
//     );
//   }
// }
