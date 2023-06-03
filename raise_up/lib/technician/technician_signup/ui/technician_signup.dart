import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:go_router/go_router.dart';
import 'package:raise_up/technician/technician_signup/bloc/technician_signup_bloc.dart';
import 'package:raise_up/technician/app_route_constatnts.dart';

class TechnicianSignup extends StatefulWidget {
  @override
  _TechnicianSignupState createState() => _TechnicianSignupState();
}

class _TechnicianSignupState extends State<TechnicianSignup> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final technicianSignupBloc =
        TechnicianSignupBloc(); // Define the technicianSignupBloc variable

    return BlocProvider<TechnicianSignupBloc>.value(
      value: technicianSignupBloc,
      child: BlocConsumer<TechnicianSignupBloc, TechnicianSignupState>(
        listener: (context, state) {
          if (state is TechnicianSignUpNavigateToLoginState) {
            GoRouter.of(context).pushNamed(
              TechnicianAppRouteConstant.technicianSignIn,
            );
          } else if (state is TechnicianSignUpSucessActionState) {
            GoRouter.of(context).pushNamed(
              TechnicianAppRouteConstant.technicianAccoutInformation,
            );
          }
          // Add any necessary listeners for state changes
        },
        builder: (context, state) {
          if (state is TechnicianSignupLoadingActionState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Scaffold(
            backgroundColor: Color.fromARGB(232, 255, 255, 255),
            body: PixelPerfect(
              // assetPath: 'assets/images/pixel_technician_signup.jpg',
              child: CurlyBackgroundPage(
                backgroundImage: Container(
                  child: Column(
                    children: [
                      ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              //colorFilter: ColorFilter.mode(Color(0xE3EC9F6F),BlendMode.colorBurn),
                              image: AssetImage("assets/images/wrench.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: 411.0,
                          height: 366.0,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 185.0,
                              ),
                              Text(
                                "Wheels  ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.0,
                                  fontFamily: "SfProDisplay",
                                  letterSpacing: 3.0,
                                ),
                              ),
                              SizedBox(height: 1.5),
                              Text(
                                "Keeping You On The Road",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 17.0,
                                  fontFamily: "SfUiTextRegular",
                                  letterSpacing: 0.2,
                                ),
                              ),
                              SizedBox(
                                height: 38.0,
                              ),
                              Text(
                                "TECHNICIAN",
                                style: TextStyle(
                                  color: Color(0xFF2CC020),
                                  fontSize: 22,
                                  fontFamily: "SfProDisplay",
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                child: Container(
                  child: Center(
                    child: SingleChildScrollView(
                      key: Key('main scroll'),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: BlocConsumer<TechnicianSignupBloc,
                            TechnicianSignupState>(
                          listener: (context, state) {
                            if (state is TechnicianSignUpSucessActionState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Center(child: Text(state.sucess)),
                                  width: 200.0, // Width of the snackbar.
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor:
                                      Color.fromARGB(192, 17, 160, 165),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                ),
                              );
                            } else if (state
                                is TechnicianSignUpfailedActionState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Center(child: Text(state.failure)),
                                  width: 200.0, // Width of the snackbar.
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor:
                                      Color.fromARGB(192, 236, 59, 36),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  SizedBox(height: 20.0),
                                  //Email Input
                                  Container(
                                    key: Key('email'),
                                    width: 323.0,
                                    height: 48.0,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        context
                                            .read<TechnicianSignupBloc>()
                                            .add(
                                                TechnicianSignupEmailInputEvent(
                                                    email: value));
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xFFEEEEEE),
                                        hintText: 'Email',
                                        prefixIcon: Icon(
                                          Icons.email,
                                          size: 30.0,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            width: 2.0,
                                            color: Colors.cyan,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            width: 3.0,
                                            color: Colors.tealAccent,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please enter your email';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 25.0),
                                  //Technician Name Input
                                  Container(
                                    key: Key('name'),
                                    width: 323,
                                    height: 48,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        context
                                            .read<TechnicianSignupBloc>()
                                            .add(TechnicianSignupNameInputEvent(
                                                name: value));
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xFFEEEEEE),
                                        hintText: 'Technician Name',
                                        prefixIcon: Icon(Icons.settings),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            width: 2.0,
                                            color: Colors.cyan,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            width: 3.0,
                                            color: Colors.tealAccent,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please enter the name of your company';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 30.0),
                                  //Password Input
                                  Container(
                                    key: Key('password'),
                                    width: 323,
                                    height: 48,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        context.read<TechnicianSignupBloc>().add(
                                            TechnicianSignupPasswordInputEvent(
                                                password: value));
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xFFEEEEEE),
                                        hintText: 'Password',
                                        prefixIcon: Icon(Icons.key),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            width: 2.0,
                                            color: Colors.cyan,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            width: 3.0,
                                            color: Colors.tealAccent,
                                          ),
                                        ),
                                      ),
                                      obscureText: true,
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please enter your password';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 30.0),
                                  //Confirm Password Input
                                  Container(
                                    key: Key('confirm password'),
                                    width: 323,
                                    height: 48,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        context.read<TechnicianSignupBloc>().add(
                                            TechnicianSignupConfirmationPasswordInputEvent(
                                                confirmationPassword: value));
                                      },
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xFFEEEEEE),
                                        hintText: 'Confirm Password',
                                        prefixIcon: Icon(Icons.key),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            width: 2.0,
                                            color: Colors.cyan,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            width: 3.0,
                                            color: Colors.tealAccent,
                                          ),
                                        ),
                                      ),
                                      obscureText: true,
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return ('Please confirm your password');
                                        } else if (state
                                            is TechnicianSignUpConfarmationPasswordIncorrectState) {
                                          return ('provide correct confirmation');
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 40.0),
                                  //Button
                                  SizedBox(
                                    key: Key('signup button'),
                                    width: 323.0,
                                    height: 50.0,
                                    child: TextButton(
                                      onPressed: () {
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          final technicianSignupBloc =
                                              BlocProvider.of<
                                                      TechnicianSignupBloc>(
                                                  context);
                                          technicianSignupBloc.add(
                                              TechnicianSignupSignupButtonClickedEvent());
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xFF38E929)),
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
                                        'Signup',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 400,
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Already have an account? ',
                                            style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          key: Key('login button'),
                                          child: TextButton(
                                            onPressed: () {
                                              final technicianSignupBloc =
                                                  BlocProvider.of<
                                                          TechnicianSignupBloc>(
                                                      context);
                                              technicianSignupBloc.add(
                                                  TechnicianSignupLogInButtonClickedEvent());
                                            },
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 4, 135, 222),
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
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
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    var firstControlPoint = Offset(size.width / 5, size.height - 50);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height);
    var secondEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CurlyBackgroundPage extends StatelessWidget {
  final Widget child;
  final Container backgroundImage;

  const CurlyBackgroundPage({
    Key? key,
    required this.child,
    required this.backgroundImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          backgroundImage,
          SafeArea(child: child),
        ],
      ),
    );
  }
}
