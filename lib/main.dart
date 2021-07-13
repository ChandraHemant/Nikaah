import 'dart:convert';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:http/http.dart' as http;
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nikaah.com/Screens/ProfileUpdate.dart';
import 'package:nikaah.com/Screens/ShowProfile.dart';
import 'package:nikaah.com/Screens/SignUp.dart';
import 'package:nikaah.com/Service/ApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(
      color: Colors.transparent,
      child: Text(
        details.toString(),
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.transparent,
        ),
      ),
    );
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.blueGrey[700]);
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Nikaah',
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFF00ACC1)),
      home: AnimatedSplashScreen(
        duration: 3000,
        splash:  ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              "assets/images/ban.jpg",
              fit: BoxFit.contain,
            )
        ),
        nextScreen: MySignInPage(),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: Colors.white
      ),
    );
  }
}

enum LoginStatus { notSignIn, signIn }

class MySignInPage extends StatefulWidget {
  MySignInPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MySignInPageState createState() => _MySignInPageState();
}

class _MySignInPageState extends State<MySignInPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);

  String otp, mob, value;

  bool visible = false;

  bool viewVisible = true;

  bool hideVisible = false;

  bool readon = true;

  final _key = new GlobalKey<FormState>();

  loadProgress() {
    setState(() {
      visible = true;
    });
    check();
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      if(mob!=null && (otp==null || otp=="")) {
        print('mob: ');
        print(mob);
        print('otp: ');
        print(otp);
        loginRegister();
      }else{
        verfyOtp();
      }
    }else{
      setState(() {
        visible = false;
      });
    }
  }

  resendOtp() async
  {
    final response = await http.post(ApiService.BASE_URL + "User_ResendOtp",
        body: {"mobile": mob});

    final data = jsonDecode(response.body);
    bool value = data['error'];
    String success = data['success'];

    if (!value) {
      setState(() {
        visible = false;
        viewVisible = false;
        hideVisible = true;
        readon = false;
      });
      print("Successfully: " + success);
      loginSuccessToast("OTP Successfully Sended Check Your Inbox!");
    } else {
      setState(() {
        visible = false;
      });
      print("fail");
      print("Success: " + success);
      loginFailedToast("Oops somthing went wrong! Please try again later");
    }
  }

  verfyOtp() async
  {
    final response = await http.post(ApiService.BASE_URL + "User_VerifyOtp",
        body: {"mobile": mob, "otp": otp});

    final data = jsonDecode(response.body);
    bool value = data['error'];
    String success = data['success'];
    String uemail = data['uemail'];
    String uname = data['uname'];
    String umobile = data['umobile'];
    String uid = data['uid'];
    print("Verify");
    if (!value) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(uemail, umobile, uname, uid);
        visible = false;
        viewVisible = false;
        hideVisible = true;
      });
      print("Success: " + success);
      loginSuccessToast("Successfully logged in!");
      if(uemail==null || uemail=="" || uemail==" ") {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => ProfileUpdate1()));
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => ShowProfile()));
      }
    } else {
      setState(() {
        visible = false;
      });
      print("fail");
      print("Oops Somthing went wrong! Please try again later");
      loginFailedToast(success);
    }
  }

  loginRegister() async {
    final response = await http.post(ApiService.BASE_URL + "User_Signin",
        body: {"mobile": mob});

    print("login register");
    final data = jsonDecode(response.body);
    bool value = data['error'];
    String success = data['success'];
    String mobile = data['mobile'];

    if (!value) {
      setState(() {
        saveMobile(mobile);
        visible = false;
        viewVisible = false;
        hideVisible = true;
        readon = false;
      });
      print("Success: " + success);
      loginSuccessToast("Please Verify Mobile Number With OTP!");
    } else {
      setState(() {
        visible = false;
      });
      print("fail");
      print("Success: " + success);
      loginFailedToast("Something Went Wrong! Please try again later");
    }
  }

  // ------------ Functions for Sign UP Phone ------------

  loginSuccessToast(String toast) {
   return Fluttertoast.showToast(
       msg: toast,
       toastLength: Toast.LENGTH_SHORT,
       gravity: ToastGravity.BOTTOM,
       timeInSecForIosWeb: 1,
       backgroundColor: Colors.green,
       textColor: Colors.white);
  }

  loginFailedToast(String toast) {
   return Fluttertoast.showToast(
       msg: toast,
       toastLength: Toast.LENGTH_SHORT,
       gravity: ToastGravity.BOTTOM,
       timeInSecForIosWeb: 1,
       backgroundColor: Colors.red,
       textColor: Colors.white);
  }

  savePref(String email, String mobile, String name, String id) async {
   SharedPreferences preferences = await SharedPreferences.getInstance();
   setState(() {
     preferences.setString("name", name);
     preferences.setString("email", email);
     preferences.setString("id", id);
     preferences.setString("mobile", mobile);
   });
  }

  saveMobile(String mobile) async {
   SharedPreferences preferences = await SharedPreferences.getInstance();
   setState(() {
     preferences.setString("mobile", mobile);
     mob = preferences.getString('mobile');
     preferences.commit();
   });
  }

  getPref() async {
   SharedPreferences preferences = await SharedPreferences.getInstance();
   setState(() {
     value = preferences.getString("id");

     if (value != null) {
       print("id: ");
       print(value);
       _loginStatus = LoginStatus.signIn;
       Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => ShowProfile()));
     } else {
       _loginStatus = LoginStatus.notSignIn;
     }
   });
  }

  Future<bool> _onBackPressed() {
   return showDialog(
     context: context,
     builder: (context) => new AlertDialog(
       title: new Text('Are you sure?'),
       content: new Text('Do you want to exit an App'),
       actions: <Widget>[
         new GestureDetector(
           onTap: () => Navigator.of(context).pop(false),
           child: roundedButton(
               "No", Color(0xFF212121), const Color(0xFFFFFFFF)),
         ),
         new GestureDetector(
           onTap: () => Navigator.of(context).pop(true),
           child: roundedButton(
               " Yes ", const Color(0xFFFFC107), const Color(0xFFFFFFFF)),
         ),
       ],
     ),
   ) ??
       false;
  }

  Widget roundedButton(String buttonLabel, Color bgColor, Color textColor) {
   var loginBtn = new Container(
     padding: EdgeInsets.all(5.0),
     alignment: FractionalOffset.center,
     decoration: new BoxDecoration(
       color: bgColor,
       borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
       boxShadow: <BoxShadow>[
         BoxShadow(
           color: const Color(0xFF696969),
           offset: Offset(1.0, 6.0),
           blurRadius: 0.001,
         ),
       ],
     ),
     child: Text(
       buttonLabel,
       style: new TextStyle(
           color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
     ),
   );
   return loginBtn;
  }

  @override
  void initState() {
   // TODO: implement initState
   super.initState();
   getPref();
  }

  @override
  Widget build(BuildContext context) {

    final mobileField = TextFormField(
      validator: (e) {
        String patttern = r'(^(?:[+0]9)?[0-9]{10,13}$)';
        RegExp regExp = new RegExp(patttern);
        if (e.isEmpty) {
          return "Please enter mobile number";
        }
        else if (!regExp.hasMatch(e)) {
          return 'Please enter valid 10 digit mobile number';
        }
      },
      onSaved: (e) => mob = e,

      decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone_iphone_outlined),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          hintText: "Enter Mobile Number",
          border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: "Mobile Number"
      ),
      keyboardType: TextInputType.phone,
      // controller: mobileController,
      obscureText: false,
      style: style,

    );

    final otpField = TextFormField(
      validator: (e) {
        String patttern = r'(^(?:[+0]9)?[0-9]{6}$)';
        RegExp regExp = new RegExp(patttern);
        if (readon) {
          return null;
        }
        else if (e.isEmpty) {
          return  "Please enter otp";
        }
        else if (!regExp.hasMatch(e)) {
          return 'Please enter valid otp';
        }
      },
      onSaved: (e) => otp = e,

      decoration: InputDecoration(
          prefixIcon: Icon(Icons.message_outlined),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          hintText: "Enter OTP",
          border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),

          labelText: "One Time Password"
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      // controller: otpControlle
      style: style,
      readOnly: readon,

    );

    final otpButton = Material(
      child: Column(
        children: [
          Visibility(
            visible: visible,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
              borderRadius: BorderRadius.circular(32),
              gradient: LinearGradient(
                colors: [Colors.blueGrey[700], Colors.cyan[700]],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
            ),
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () {
                loadProgress();
              },
              child: Text("Get OTP",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );

    final loginButton = Material(
      child: Column(
        children: [
          Visibility(
            visible: visible,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
              borderRadius: BorderRadius.circular(32),
              gradient: LinearGradient(
                colors: [Colors.blueGrey[700], Colors.cyan[700]],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
            ),
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () {
                loadProgress();
              },
              child: Text("Sign In",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );


    return new WillPopScope(

        onWillPop: _onBackPressed,
        child: new Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 0.5, 0.7, 0.9],
                colors: [
                  Colors.blueGrey[700],
                  Colors.blueGrey[300],
                  Colors.cyan[300],
                  Colors.cyan[700],
                ],
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Form(
                        key: _key,
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 155.0,
                            child:  ClipRRect(
                              borderRadius: BorderRadius.circular(70),
                              child: Image.asset(
                                "assets/images/ban.jpg",
                                fit: BoxFit.contain,
                              )
                            ),
                          ),

                          SizedBox(height: 25.0),

                          mobileField,

                          SizedBox(height: 25.0),

                          otpField,

                          Visibility(
                            visible: hideVisible,
                            child: Container(
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Don't have an OTP?"),

                                    FlatButton(
                                      child: Row(
                                        children: [
                                          Text("RESEND OTP",
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ))],

                                      ),
                                      onPressed: () {
                                        resendOtp();
                                      }             ,

                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 25.0),

                          new Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Visibility(
                                  visible : viewVisible,
                                  child: GestureDetector(
                                    onTap:() {
                                      loadProgress();
                                    },
                                    child: otpButton,
                                  ),
                                ),

                                Visibility(
                                  visible: hideVisible,
                                  child: GestureDetector(
                                    onTap:() {
                                      loadProgress();
                                    },
                                    child: loginButton,
                                  ),
                                ),
                              ]
                          ),
                          Container(
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Don't have an account?"),

                                  FlatButton(
                                    child: Row(
                                      children: [
                                        Text("Sign Up",
                                            style: TextStyle(
                                              color: Colors.blue,
                                            ))],

                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MySignUpPage()));
                                    }             ,

                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
                    )
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}

