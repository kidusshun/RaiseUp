import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pixel_perfect/pixel_perfect.dart';

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
        child: PixelPerfect(
          assetPath: 'assets/images/pixel_customer-login.jpg',
          child: CurlyBackgroundPage(
            backgroundImage: Container(
              child: Column(
                children: [
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
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
                              color: Colors.white70,
                              fontSize: 17.0,
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
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 50.0),
                          //Email Input

                          //Button
                          SizedBox(
                            width: 323.0,
                            height: 50.0,
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  return;
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
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                'CUSTOMER',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            width: 323.0,
                            height: 50.0,
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  return;
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(0, 255, 255, 255)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: const BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 38, 242, 205))),
                                ),
                              ),
                              child: Text(
                                'Technician',
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
