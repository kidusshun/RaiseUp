import 'package:flutter/material.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:raise_up/widgets/gestureDetectorButton.dart';
import 'package:raise_up/widgets/selectionButton.dart';

import '../bloc/technician_account_information_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechnicianAccountInformation extends StatefulWidget {
  const TechnicianAccountInformation({Key? key}) : super(key: key);

  @override
  State<TechnicianAccountInformation> createState() => _MyAppState();
}

class _MyAppState extends State<TechnicianAccountInformation> {
  final _formKey = GlobalKey<FormState>();
  double spacing = 10.0;
  Color col = Color.fromARGB(235, 217, 217, 217);
  Color borderColor = Colors.transparent;
  bool on = false;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TechnicianAccountInformationBloc(),
        ),
      ],
      child: MaterialApp(
        home: PixelPerfect(
          assetPath: "assets/images/pixel-technician-account-information.jpg",
          child: Scaffold(
            appBar: AppBar(
              title: Text('Account Information'),
              backgroundColor: Color.fromARGB(255, 67, 139, 149),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(23, 13, 0, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Text("Hello,",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Tell us a bit more about yourself and your profession.",
                        style: TextStyle(
                          fontSize: 19.4,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 55.0),
                      Text(
                        "Expertise?",
                        style: TextStyle(
                          fontSize: 18.7,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Wrap(spacing: spacing, children: [
                        GestureButton(name: "Body Work"),
                        GestureButton(name: "Exahust"),
                        GestureButton(name: "Electrical System"),
                        GestureButton(name: "Transmission"),
                        GestureButton(name: "Engine"),
                        GestureButton(name: "Sterring"),
                        GestureButton(name: "Tire & Axis"),
                        GestureButton(name: "Suspenssion & Sterring"),
                        GestureButton(name: "Break"),
                      ]),
                      BlocConsumer<TechnicianAccountInformationBloc, TechnicianAccountInformationState>(
                        listener: (context, state) {
                          // TODO: implement listener
                          if (state is TechnicianInputSucessActionState) {
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
                          }
                          else if (state is TechnicianInputFailureActionState) {
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
                          return Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                //Phone Number
                                // Text("Phone Number?"),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 35, 0),
                                  child: TextFormField(
                                      onChanged: (value) {context.read<TechnicianAccountInformationBloc>().add(TechnicianPhoneNumberInputEvent(phoneNumber: value));},
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please Enter Your Phone Number';
                                        }else{
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Phone Number",
                                      )),
                                ),
                                //Garage Name
                                // Text("Garage Name?"),
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 35, 0),
                                  child: TextFormField(
                                      onChanged: (value) {context.read<TechnicianAccountInformationBloc>().add(TechnicianGarageNameInputEvent(garageName: value));},
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please Enter Your Garage Name';
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Garage Name",
                                      )),
                                ),
                                //Garage Location
                                // Text("Garage Location?"),
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 35, 0),
                                  child: TextFormField(
                                      onChanged: (value) {context.read<TechnicianAccountInformationBloc>().add(TechnicianGarageLocationInputEvent(garageLocation: value));},
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please Enter Your Garage Location';
                                        }else{
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Garage Location",
                                      )),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: 323.0,
                                  height: 50.0,
                                  child: TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {}
                                      // print("hi");
                                      context.read<TechnicianAccountInformationBloc>().add(TechnicianAccountInformationSubmitButtonEvent());
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color.fromARGB(
                                                  255, 30, 201, 135)),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
