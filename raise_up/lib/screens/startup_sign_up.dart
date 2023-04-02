import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pixel_perfect/pixel_perfect.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Color(0xE8ECDCFD),
        body: CurlyBackgroundPage(
          backgroundImage: Container(
            child:Column(
              children:[
                ClipPath(
                  clipper:WaveClipper(),
                  child: Container(
                    decoration:BoxDecoration(
                      image:DecorationImage(
                        //colorFilter: ColorFilter.mode(Color(0xE3EC9F6F),BlendMode.colorBurn),
                        image:AssetImage("assets/images/phone_and_coin.jpg"),
                        fit:BoxFit.cover,
                      ),
                    ),
                    width:411.0,
                    height:360.0,
                    child:Column(
                      children:[
                        SizedBox(height:173.0),
                        Text(
                          "RaiseUP",
                          style:TextStyle(
                            fontSize:32.0,
                            fontFamily:"SfProDisplay",
                            letterSpacing: 3.0,
                          ),
                        ),
                        SizedBox(height:2.0),
                        Text(
                          "raise up your dreams",
                          style:TextStyle(
                            fontSize:16.0,
                            fontFamily:"SfUiTextRegular",
                            letterSpacing: 0.4,
                          ),
                        ),
                        SizedBox(height:38.0,),
                        Text(
                          "STARTUP",
                          style:TextStyle(
                            fontSize:21,
                            fontFamily:"SfProDisplay",
                            letterSpacing: 1.1,
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
                    key:_formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height:20.0),
                        //Email Input
                        Container(
                          width: 323.0,
                          height: 48.0,
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled:true,
                              fillColor:Color(0xFFEEEEEE),
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  width:2.0,
                                  color: Colors.cyan,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  width:3.0,
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
                        //Company Name Input
                        Container(
                          width: 323,
                          height: 48,
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled:true,
                              fillColor:Color(0xFFEEEEEE),
                              hintText: 'Company Name',
                              prefixIcon: Icon(Icons.shopping_bag),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  width:2.0,
                                  color: Colors.cyan,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  width:3.0,
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
                        SizedBox(height: 25.0),
                        //Password Input
                        Container(
                          width: 323,
                          height: 48,
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled:true,
                              fillColor:Color(0xFFEEEEEE),
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  width:2.0,
                                  color: Colors.cyan,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  width:3.0,
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
                        SizedBox(height: 25.0),
                        //Confirm Password Input
                        Container(
                          width: 323,
                          height: 48,
                          child: TextFormField(
                            decoration: InputDecoration(
                              filled:true,
                              fillColor:Color(0xFFEEEEEE),
                              hintText: 'Confirm Password',
                              prefixIcon: Icon(Icons.lock),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  width:2.0,
                                  color: Colors.cyan,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  width:3.0,
                                  color: Colors.tealAccent,
                                ),
                              ),
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please confirm your password';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 40.0),
                        //Button
                        SizedBox(
                          width: 323.0, // Set the desired width of the button
                          height: 50.0, // Set the desired height of the button
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                return;
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Color(0xFF38E929)),
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.white),
                              shape:
                                  MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                            child: Text(
                                'Signup',
                              style:TextStyle(
                                color:Colors.black,
                                fontSize:18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
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
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: Text(
                                  'Log in',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
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
      );
  }
}


class WaveClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path=new Path();
    path.lineTo(0, size.height-40.0);
    var start=Offset(size.width/3,size.height-50);
    var mid=Offset(size.width-220.0,size.height+55);
    var end=Offset(size.width,size.height-40);
    path.cubicTo(start.dx, start.dy, mid.dx, mid.dy, end.dx, end.dy);
    path.lineTo(size.width,0);
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
        color:Color(0xE8F5E6FD),
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


