import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:raise_up/customers/customer_signup/bloc/customer_signup_bloc.dart'
    show CustomerSignupLogInButtonClickedEvent;

// import 'package:raise_up/technician/technician_signup/bloc/technician_signup_bloc.dart';

import '../bloc/customer_signup_bloc.dart';
import 'package:raise_up/customers/app_route_customers_constatnts.dart';

class CustomerSignup extends StatefulWidget {
  @override
  _CustomerSignup createState() => _CustomerSignup();
}

class _CustomerSignup extends State<CustomerSignup> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CustomerSignupBloc(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Color.fromARGB(232, 255, 255, 255),
        body: PixelPerfect(
          // assetPath: 'assets/images/pixel_customer-signup.jpg',
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
                          image: AssetImage("assets/images/wheel.jpg"),
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
                            "Wheels",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
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
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 17.0,
                              fontFamily: "SfUiTextRegular",
                              letterSpacing: 0.2,
                            ),
                          ),
                          SizedBox(
                            height: 38.0,
                          ),
                          Text(
                            "CUSTOMER",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
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
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child:
                        BlocConsumer<CustomerSignupBloc, CustomerSignupState>(
                      listener: (context, state) {
                        // TODO: implement listener
                        if (state is CustomerSignUpSucessActionState) {
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
                        } else if (state is CustomerSignUpfailedActionState) {
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
                        } else if (state
                            is CustomerSignupLogInButtonClickedEvent) {
                          GoRouter.of(context).pushNamed(
                              CustomerAppRouteConstant.customerSignin);
                        }
                      },
                      builder: (context, state) {
                        return Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 20.0),
                              //Email Input
                              Container(
                                width: 323.0,
                                height: 48.0,
                                child: TextFormField(
                                  onChanged: (value) {
                                    context.read<CustomerSignupBloc>().add(
                                        CustomerSignupEmailInputEvent(
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
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide(
                                        width: 2.0,
                                        color: Colors.cyan,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
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
                              //CUSTOMER Name Input
                              Container(
                                width: 323,
                                height: 48,
                                child: TextFormField(
                                  onChanged: (value) {
                                    context.read<CustomerSignupBloc>().add(
                                        CustomerSignupNameInputEvent(
                                            name: value));
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFFEEEEEE),
                                    hintText: 'Customer Name',
                                    prefixIcon: Icon(Icons.settings),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide(
                                        width: 2.0,
                                        color: Colors.cyan,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
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
                                width: 323,
                                height: 48,
                                child: TextFormField(
                                  onChanged: (value) {
                                    context.read<CustomerSignupBloc>().add(
                                        CustomerSignupPasswordInputEvent(
                                            password: value));
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFFEEEEEE),
                                    hintText: 'Password',
                                    prefixIcon: Icon(Icons.key),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide(
                                        width: 2.0,
                                        color: Colors.cyan,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
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
                                width: 323,
                                height: 48,
                                child: TextFormField(
                                  onChanged: (value) {
                                    context.read<CustomerSignupBloc>().add(
                                        CustomerSignupConfirmationPasswordInputEvent(
                                            confirmationPassword: value));
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFFEEEEEE),
                                    hintText: 'Confirm Password',
                                    prefixIcon: Icon(Icons.key),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide(
                                        width: 2.0,
                                        color: Colors.cyan,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
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
                                        is CustomerSignUpConfarmationPasswordIncorrectState) {
                                      return ('provide correct confirmation');
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 40.0),
                              //Button
                              SizedBox(
                                width: 323.0,
                                height: 50.0,
                                child: TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {}
                                    context.read<CustomerSignupBloc>().add(
                                        CustomerSignupSignupButtonClickedEvent());

                                        GoRouter.of(context).go(
                                          CustomerAppRouteConstant
                                              .customerSignin,
                                        );
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
                                  child: const Text(
                                    'Signup',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 400,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already have an account? ',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        BlocProvider.of<CustomerSignupBloc>(
                                                context)
                                            .add(
                                                CustomerSignupLogInButtonClickedEvent());
                                        GoRouter.of(context).pushNamed(
                                          CustomerAppRouteConstant
                                              .customerSignin,
                                        );
                                      },
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 17, 41, 255),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w900,
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
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - 40.0);
    var start = Offset(size.width / 3.5, size.height - 80);
    var mid = Offset(size.width - 60, size.height);
    var end = Offset(size.width, size.height - 41);
    path.cubicTo(start.dx, start.dy, mid.dx, mid.dy, end.dx, end.dy);
    path.lineTo(size.width, 0);
    path.close;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

class CurlyBackgroundPage extends StatelessWidget {
  final Widget backgroundImage;
  final Widget child;

  CurlyBackgroundPage({
    required this.backgroundImage,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xE8F5E6FD),
        child: Column(
          children: [
            backgroundImage,
            child,
          ],
        ),
      ),
    );
  }
}
