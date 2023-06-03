import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/technician_profile_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:raise_up/technician/app_route_constatnts.dart';

class TechnicianStProfile extends StatelessWidget {
  const TechnicianStProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TechnicianProfileBloc(),
      child: TechnicianProfile(),
    );
  }
}

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
    BlocProvider.of<TechnicianProfileBloc>(context)
        .add(TechnicianHistoryInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
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
                // technicianProfile.name,
                "pp",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              InkWell(
                onTap: () {
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
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 0, 0),
            child: Text(
              'History:',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ]),
      ]),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                final technicianProfileBloc =
                    BlocProvider.of<TechnicianProfileBloc>(context);
                technicianProfileBloc
                    .add(TechnicianProfileHomeButtonClickedEvent());

                GoRouter.of(context).pushNamed(
                  TechnicianAppRouteConstant.technicianServiceRequest,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.build),
              onPressed: () {
                final technicianProfileBloc =
                    BlocProvider.of<TechnicianProfileBloc>(context);
                technicianProfileBloc
                    .add(TechnicianProfileTodoButtonClickedEvent());
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
