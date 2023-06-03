import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_perfect/pixel_perfect.dart';

import '../app_route_customers_constatnts.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xE8ECDCFD),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: CurlyBackgroundPage(
          backgroundImage: Container(
            child: Column(
              children: [
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    key: Key("background image"),
                    decoration: const BoxDecoration(
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
                          "Wheels  ",
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
                            color: Color.fromARGB(225, 255, 255, 255),
                            fontSize: 19.0,
                            fontFamily: "SfUiTextRegular",
                            letterSpacing: 0.2,
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
              child: Column(mainAxisSize: MainAxisSize.max, children: [
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context)
                    .pushNamed(LandingAppRouteConstant.customerSignUp);
              },
              child: Text("Customer", style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 12.0),
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context)
                    .pushNamed(LandingAppRouteConstant.technicianSignUp);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 12.0),
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text("Technician", style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 1000)
          ])),
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
