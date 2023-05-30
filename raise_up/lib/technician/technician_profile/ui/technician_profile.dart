import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raise_up/technician/technician_service_request/ui/technician_service_request.dart';
import '../bloc/technician_profile_bloc.dart';
import 'package:raise_up/widgets/selectionButton.dart';
import 'package:raise_up/technician/technician_profile/model/technician_profile_class.dart';
import 'package:raise_up/technician/technician_profile/repos/technician_profile_repository.dart';

class TechnicianProfile extends StatefulWidget {
  const TechnicianProfile({Key? key});

  @override
  State<TechnicianProfile> createState() => _TechnicianProfileState();
}

class _TechnicianProfileState extends State<TechnicianProfile> {
  final TechnicianProfileBloc technicianProfileBloc = TechnicianProfileBloc();

  @override
  void initState() {
    super.initState();
    technicianProfileBloc.add(TechnicianProfileLoadDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TechnicianProfileBloc, TechnicianProfileState>(
      bloc: technicianProfileBloc,
      listenWhen: (previous, current) =>
          current is TechnicianProfileActionState,
      buildWhen: (previous, current) =>
          current is! TechnicianProfileActionState,
      listener: (context, state) {
        if (state is TechnicianProfileNavigateToHomeState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TechnicianServiceRequest()));
        } else if (state is TechnicianProfileNavigateToTodoState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TechnicianServiceRequest()));
        }
        // Add any necessary listeners for state changes
      },
      builder: (context, state) {
        if (state is TechnicianProfileLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TechnicianProfileLoadedSuccessState) {
          final technicianProfile = state.technicianProfile;

          return Scaffold(
            body: Column(
              children: [
                Container(
                  color: Color.fromARGB(
                      255, 117, 185, 198), // Set background color to green
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(70),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        child: Icon(
                          Icons.person,
                          size: 80,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        technicianProfile.name,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      InkWell(
                        onTap: () {
                          technicianProfileBloc.add(
                              TechnicianProfileEditNameButtonClickedEvent());
                          // Handle edit name functionality here
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.blue,
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'edit',
                              style: TextStyle(
                                color: Color.fromARGB(255, 11, 131, 211),
                                decoration: TextDecoration.underline,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: technicianProfile.skills
                //       .map<Widget>(
                //         (skill) => SelectionButton(text: skill),//selectionButton.dart file have been replaced!
                //                                                 // Make some modifications accordingly
                //       )
                //       .toList(),
                // ),
                Row(
                  // padding: EdgeInsets.all(10),
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[Padding(
                    padding: const EdgeInsets.fromLTRB(15,25,0,0),
                    child: Text(
                      'History:',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ]
                ),
               
                Expanded(
                  child: ListView.builder(
                    itemCount: technicianProfile.history.length,
                    itemBuilder: (context, index) {
                      final contactInfo = technicianProfile.history[index];
                      return Dismissible(
                        key: Key(contactInfo.customerName),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (direction) {
                          // technicianProfileBloc.add(
                          //   TechnicianProfileContactInfoDeletedEvent(index),
                          // );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(166, 45, 204, 196).withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10),
                              leading: CircleAvatar(
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
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {
                      technicianProfileBloc
                          .add(TechnicianProfileHomeButtonClickedEvent());
                      // Handle home button functionality here
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.build),
                    onPressed: () {
                      technicianProfileBloc
                          .add(TechnicianProfileTodoButtonClickedEvent());
                      // Handle todo button functionality here
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(); // Placeholder for any other state
        }
      },
    );
  }
}
