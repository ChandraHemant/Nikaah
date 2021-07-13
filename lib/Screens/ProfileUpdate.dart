import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nikaah.com/Screens/ShowProfile.dart';
import 'package:nikaah.com/Service/ApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFF00ACC1)),
      home: ProfileUpdate1(),
    );
  }
}


/*<-----------Screen 1----------->*/

class ProfileUpdate1 extends StatefulWidget {
  @override
  _ProfileUpdate1 createState() => _ProfileUpdate1();
}

class _ProfileUpdate1 extends State<ProfileUpdate1> {
  List<String> genders= [
    "Male",
    "Female"
  ];

  List<String> marital= [
    "Never Married",
    "Divorced"
    "Widowed"
    "Awaiting Divorce"
    "Annulled"
  ];

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);

  String feet, inch, dob, value, email=null, community, m_tongue, marital_status="Never Married", gender="Male";

  bool visible = false;
  bool viewVisible = false;

  final _key = new GlobalKey<FormState>();

  String u_id=null;

  enableSkip(){
    setState(() {
      if(email!=null) {
        viewVisible = true;
      }
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      u_id = preferences.getString("id");
      email = preferences.getString("email");
    });
    enableSkip();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }


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
      profileUpdates1();
    }else{
      setState(() {
        visible=false;
      });
    }
  }
  profileUpdates1() async {
    final response = await http.post(ApiService.BASE_URL + "User_Profile_Update",
        body: {"u_id": u_id, "dob": dob, "email":email, "gender":gender, "marital_status":marital_status, "m_tongue":m_tongue, "height":feet+"' "+inch+'"', "community":community});

    print("login register");
    final data = jsonDecode(response.body);
    bool value = data['error'];
    String success = data['success'];

    if (!value) {
      setState(() {
        savePref(email);
        visible = false;
      });
      print("Success: " + success);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileUpdate2()));
    } else {
      setState(() {
        visible = false;
      });
      print("fail");
      print("Success: " + success);
      loginFailedToast("Something Went Wrong! ");
    }
  }


  savePref(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("email", email);
    });
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

  @override
  Widget build(BuildContext context) {
      final emailField = TextFormField(
        validator: (e) {
          String patttern = r'(^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$)';
          RegExp regExp = new RegExp(patttern);
          if (!regExp.hasMatch(e)) {
            return 'Please enter valid email id';
          }
        },
        onSaved: (e) => email = e,

        obscureText: false,
        style: style,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.email_outlined),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
            hintText: "Enter Your Email Id",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelText: "Email Id"
        ),

        keyboardType: TextInputType.text,
      );

      final genderField = InputDecorator(
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.add_road_rounded),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
            hintText: "Gender",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelText: "Select Your Gender"
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            isDense: true, // Reduces the dropdowns height by +/- 50%
            icon: Icon(Icons.keyboard_arrow_down),
            value: gender,
            items: genders.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (selectedItem) => setState(() => gender = selectedItem,
            ),
          ),
        ),
      );

      final maritalField = InputDecorator(
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.group_work_outlined),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
            hintText: "Marital Status",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelText: "Select Your Marital Status"
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            isDense: true, // Reduces the dropdowns height by +/- 50%
            icon: Icon(Icons.keyboard_arrow_down),
            value: marital_status,
            items: marital.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (selectedItem) => setState(() => marital_status = selectedItem,
            ),
          ),
        ),
      );

      final tongueField = TextFormField(
        validator: (e) {
          String patttern = r'(^[a-zA-Z ]*$)';
          RegExp regExp = new RegExp(patttern);
          if (e.isEmpty) {
            return 'Please enter your Mother Tongue';
          }
          else if (!regExp.hasMatch(e)) {
            return 'Please enter valid Mother Tongue';
          }

        },
        onSaved: (e) => m_tongue = e,
        style: style,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.language_outlined),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            hintText: "Enter Mother Tongue",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelText: "Mother Tounge"
        ),
        keyboardType: TextInputType.text,
      );

      final communityField = TextFormField(
        validator: (e) {
          String patttern = r'(^[a-zA-Z ]*$)';
          RegExp regExp = new RegExp(patttern);
          if (e.isEmpty) {
            return 'Please enter your Community';
          }
          else if (!regExp.hasMatch(e)) {
            return 'Please enter valid Community';
          }

        },
        onSaved: (e) => community = e,
        style: style,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.group),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
            hintText: "Eg. Brahmin",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelText: "Your Community"
        ),
      );


      final feetField = TextFormField(
        validator: (e) {
          String patttern = r'(^(?:[+0]9)?[0-9]{1}$)';
          RegExp regExp = new RegExp(patttern);
          if (!regExp.hasMatch(e)) {
            return 'Please enter valid height in feet';
          }

        },
        onSaved: (e) => feet = e,
        style: style,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.height),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
            hintText: "Eg. 5 Feet",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelText: "Your Height in Feet"
        ),
      );


      final inchField = TextFormField(
        validator: (e) {
          String patttern = r'(^(?:[+0]9)?[0-9]{1,2}$)';
          RegExp regExp = new RegExp(patttern);
          if (!regExp.hasMatch(e)) {
            return 'Please enter valid height in Inch';
          }

        },
        onSaved: (e) => inch = e,
        style: style,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.height_outlined),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
            hintText: "Eg. 9 Inch",
            labelText: "Your Height in Inch",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      );

      final dobField = TextFormField(
        validator: (e) {
          String patttern = r"^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$";
          RegExp regExp = new RegExp(patttern);
          if (!regExp.hasMatch(e)) {
            return 'Please enter valid Date of Birth';
          }
        },
        onSaved: (e) => dob = e,

        decoration: InputDecoration(
            prefixIcon: Icon(Icons.date_range_outlined),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            hintText: "Eg. dd/mm/yyyy, dd-mm-yyyy, dd.mm.yyyy",
            border:OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            labelText: "Date Of Birth"
        ),
        // controller: mobileController,
        obscureText: false,
        style: style,

      );

      final registerButton = Material(
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
                child: Text("Update",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      );

      return new Scaffold(
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

                                SizedBox(height: 10.0),

                                Text("Update User Profile",
                                    textAlign: TextAlign.center,
                                    style: style.copyWith( fontSize: 22,
                                        color: Colors.cyan[900], fontWeight: FontWeight.bold)),

                                SizedBox(height: 35.0),

                                emailField,

                                SizedBox(height: 25.0),

                                dobField,

                                SizedBox(height: 25.0),

                                genderField,

                                SizedBox(height: 25.0),

                                maritalField,

                                SizedBox(height: 25.0),

                                tongueField,

                                SizedBox(height: 25.0),

                                communityField,

                                SizedBox(height: 25.0),

                                Text("Enter Your Height in Feet & Inch",
                                    textAlign: TextAlign.center,
                                    style: style.copyWith(
                                        color: Colors.cyan[700], fontWeight: FontWeight.bold)),
                                SizedBox(height: 25.0),
                                feetField,
                                SizedBox(height: 15.0),
                                inchField,

                                SizedBox(height: 25.0),

                                registerButton,

                                Visibility(
                                  visible: viewVisible,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text("Already updated this section ?"),

                                            FlatButton(
                                              child: Row(
                                                children: [
                                                  Text("Skip This",
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                      ))],

                                              ),
                                              onPressed: () {
                                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileUpdate2()));
                                              }             ,

                                            )
                                          ],
                                        ),
                                      ),
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
          );
    }
  }


/*<-----------Screen 2----------->*/

class ProfileUpdate2 extends StatefulWidget {
  @override
  _ProfileUpdate2 createState() => _ProfileUpdate2();
}

class _ProfileUpdate2 extends State<ProfileUpdate2> {
  List<String> edu= [
    "Bachelors",
    "Masters",
    "Undergraduate",
    "Postgraduate",
    "PhD",
    "Diploma"
  ];

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);

  String clg_uni=null, edu_high="Bachelors";

  bool visible = false;
  bool viewVisible = false;

  final _key = new GlobalKey<FormState>();

  String u_id=null;

  enableSkip(){
    setState(() {
      if(clg_uni!=null) {
        viewVisible = true;
      }
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      u_id = preferences.getString("id");
      clg_uni = preferences.getString("clg_uni");
    });
    enableSkip();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }


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
      profileUpdates1();
    }else{
      setState(() {
        visible=false;
      });
    }
  }
  profileUpdates1() async {
    final response = await http.post(ApiService.BASE_URL + "User_EduProfile_Update",
        body: {"u_id": u_id, "edu_high":edu_high, "clg_uni":clg_uni});

    print("login register");
    final data = jsonDecode(response.body);
    bool value = data['error'];
    String success = data['success'];

    if (!value) {
      setState(() {
        savePref(clg_uni);
        visible = false;
      });
      print("Success: " + success);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileUpdate3()));
    } else {
      setState(() {
        visible = false;
      });
      print("fail");
      print("Success: " + success);
      loginFailedToast("Something Went Wrong! ");
    }
  }


  savePref(String clg_uni) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("clg_uni", clg_uni);
    });
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

  @override
  Widget build(BuildContext context) {

    final eduField = InputDecorator(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.school_outlined),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
          hintText: "Highest Education",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: "Select Your Qualification"
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          isDense: true, // Reduces the dropdowns height by +/- 50%
          icon: Icon(Icons.keyboard_arrow_down),
          value: edu_high,
          items: edu.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (selectedItem) => setState(() => edu_high = selectedItem,
          ),
        ),
      ),
    );

    final clgUniField = TextFormField(
      validator: (e) {
        if (e.isEmpty) {
          return 'Please enter your college/university';
        }

      },
      onSaved: (e) => clg_uni = e,
      style: style,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.school),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          hintText: "Enter College/University Name",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: "College / University"
      ),
      keyboardType: TextInputType.text,
    );

    final registerButton = Material(
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
              child: Text("Update",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );

    return new Scaffold(
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

                          SizedBox(height: 10.0),

                          Text("Educational Details",
                              textAlign: TextAlign.center,
                              style: style.copyWith( fontSize: 22,
                                  color: Colors.cyan[900], fontWeight: FontWeight.bold)),

                          SizedBox(height: 35.0),

                          eduField,

                          SizedBox(height: 25.0),

                          clgUniField,

                          SizedBox(height: 25.0),

                          registerButton,

                          Visibility(
                            visible: viewVisible,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Already updated this section ?"),

                                      FlatButton(
                                        child: Row(
                                          children: [
                                            Text("Skip This",
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                ))],

                                        ),
                                        onPressed: () {
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileUpdate3()));
                                        }             ,

                                      )
                                    ],
                                  ),
                                ),
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
    );
  }
}


/*<-----------Screen 3----------->*/

class ProfileUpdate3 extends StatefulWidget {
  @override
  _ProfileUpdate3 createState() => _ProfileUpdate3();
}

class _ProfileUpdate3 extends State<ProfileUpdate3> {
  List<String> occupation_list= [
    "Accountant (General)",
    "Aeroplane Pilot",
    "Agricultural Engineer",
    "Agricultural Scientist",
    "Baker",
    "Biotechnologist",
    "Chemical Engineer",
    "Civil Engineer",
    "Computer Science Engineer",
    "Electrical Engineer",
    "Geophysicist",
    "None Occupation"
  ];

  List<String> working_place_list= [
    "Private Company",
    "Government / Public Sector",
    "Defense / Civil Services",
    "Business / Self Employed",
    "Not Working"
  ];

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);

  String an_income=null, org_name, working_place="Private Company", occupation="Accountant (General)";

  bool visible = false;
  bool viewVisible = false;

  final _key = new GlobalKey<FormState>();

  String u_id=null;

  enableSkip(){
    setState(() {
      if(an_income!=null) {
        viewVisible = true;
      }
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      u_id = preferences.getString("id");
      an_income = preferences.getString("an_income");
    });
    enableSkip();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }


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
      profileUpdates1();
    }else{
      setState(() {
        visible=false;
      });
    }
  }
  profileUpdates1() async {
    final response = await http.post(ApiService.BASE_URL + "User_Occupation_Update",
        body: {"u_id": u_id, "an_income": an_income, "org_name":org_name, "working_place":working_place, "occupation":occupation});

    print("login register");
    final data = jsonDecode(response.body);
    bool value = data['error'];
    String success = data['success'];

    if (!value) {
      setState(() {
        savePref(an_income);
        visible = false;
      });
      print("Success: " + success);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileUpdate4()));
    } else {
      setState(() {
        visible = false;
      });
      print("fail");
      print("Success: " + success);
      loginFailedToast("Something Went Wrong! ");
    }
  }


  savePref(String an_income) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("an_income", an_income);
    });
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

  @override
  Widget build(BuildContext context) {

    final occuptionField = InputDecorator(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.business),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
          hintText: "Occupation",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: "Select Your Occupation"
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          isDense: true, // Reduces the dropdowns height by +/- 50%
          icon: Icon(Icons.keyboard_arrow_down),
          value: occupation,
          items: occupation_list.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (selectedItem) => setState(() => occupation = selectedItem,
          ),
        ),
      ),
    );


    final workingField = InputDecorator(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.home_work_outlined),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
          hintText: "Currently Working Place",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: "Select Your Working Place"
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          isDense: true, // Reduces the dropdowns height by +/- 50%
          icon: Icon(Icons.keyboard_arrow_down),
          value: working_place,
          items: working_place_list.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (selectedItem) => setState(() => working_place = selectedItem,
          ),
        ),
      ),
    );

    final incomeField = TextFormField(
      validator: (e) {
        if (e.isEmpty) {
          return 'Please enter your Annual Income';
        }
      },
      onSaved: (e) => an_income = e,
      style: style,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.monetization_on_outlined),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          hintText: "Enter Annual Income",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: "Annual Income"
      ),
      keyboardType: TextInputType.text,
    );

    final orgField = TextFormField(
      validator: (e) {
        String patttern = r'(^[a-zA-Z ]*$)';
        RegExp regExp = new RegExp(patttern);
        if (e.isEmpty) {
          return 'Please enter your Organization Name';
        }
        else if (!regExp.hasMatch(e)) {
          return 'Please enter valid Organization Name';
        }

      },
      onSaved: (e) => org_name = e,
      style: style,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.location_city),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
          hintText: "Enter Organization Name",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: "Organization Name"
      ),
    );

    final registerButton = Material(
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
              child: Text("Update",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );

    return new Scaffold(
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

                          SizedBox(height: 10.0),

                          Text("Occupation Details",
                              textAlign: TextAlign.center,
                              style: style.copyWith( fontSize: 22,
                                  color: Colors.cyan[900], fontWeight: FontWeight.bold)),

                          SizedBox(height: 35.0),

                          occuptionField,

                          SizedBox(height: 25.0),

                          workingField,

                          SizedBox(height: 25.0),

                          orgField,

                          SizedBox(height: 25.0),

                          incomeField,

                          SizedBox(height: 25.0),

                          registerButton,

                          Visibility(
                            visible: viewVisible,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Already updated this section ?"),

                                      FlatButton(
                                        child: Row(
                                          children: [
                                            Text("Skip This",
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                ))],

                                        ),
                                        onPressed: () {
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileUpdate4()));
                                        }             ,

                                      )
                                    ],
                                  ),
                                ),
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
    );
  }
}


/*<-----------Screen 4----------->*/

class ProfileUpdate4 extends StatefulWidget {
  @override
  _ProfileUpdate4 createState() => _ProfileUpdate4();
}

class _ProfileUpdate4 extends State<ProfileUpdate4> {
  List<String> father= [
    "Employed",
    "Business",
    "Retired",
    "Not Employed",
    "Passed Away"
  ];

  List<String> mother= [
    "Homemaker",
    "Employed",
    "Business",
    "Retired",
    "Passed Away"
  ];

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);

  String num_sis_marital, num_bro_marital, num_sis, num_bro, home_town, native_place=null, father_status="Employed", mother_status="Homemaker";

  bool visible = false;
  bool viewVisible = false;

  final _key = new GlobalKey<FormState>();

  String u_id=null;

  enableSkip(){
    setState(() {
      if(native_place!=null) {
        viewVisible = true;
      }
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      u_id = preferences.getString("id");
      native_place = preferences.getString("native_place");
    });
    enableSkip();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }


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
      profileUpdates1();
    }else{
      setState(() {
        visible=false;
      });
    }
  }
  profileUpdates1() async {
    final response = await http.post(ApiService.BASE_URL + "User_FamilyProfile_Update",
        body: {"u_id": u_id, "native_place": native_place, "family_live": home_town, "num_bro":num_bro, "num_sis":num_sis, "num_bro_marital":num_bro_marital, "num_sis_marital":num_sis_marital, "father_status":father_status, "mother_status":mother_status});

    print("login register");
    final data = jsonDecode(response.body);
    bool value = data['error'];
    String success = data['success'];

    if (!value) {
      setState(() {
        savePref(native_place);
        visible = false;
      });
      print("Success: " + success);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowProfile()));
    } else {
      setState(() {
        visible = false;
      });
      print("fail");
      print("Success: " + success);
      loginFailedToast("Something Went Wrong! ");
    }
  }


  savePref(String native_place) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("native_place", native_place);
    });
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

  @override
  Widget build(BuildContext context) {

    final fatherField = InputDecorator(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.perm_contact_cal_outlined),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
          hintText: "Father Status",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: "Select Your Father Status"
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          isDense: true, // Reduces the dropdowns height by +/- 50%
          icon: Icon(Icons.keyboard_arrow_down),
          value: father_status,
          items: father.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (selectedItem) => setState(() => father_status = selectedItem,
          ),
        ),
      ),
    );


    final motherField = InputDecorator(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.perm_contact_cal_rounded),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 0, 10.0),
          hintText: "Mother Status",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: "Select Your Mother Status"
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          isDense: true, // Reduces the dropdowns height by +/- 50%
          icon: Icon(Icons.keyboard_arrow_down),
          value: mother_status,
          items: mother.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (selectedItem) => setState(() => mother_status = selectedItem,
          ),
        ),
      ),
    );

    final nativeField = TextFormField(
      validator: (e) {
        if (e.isEmpty) {
          return 'Please enter your Native Address';
        }

      },
      onSaved: (e) => native_place = e,
      style: style,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.location_history),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
          hintText: "Enter Native Place",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: "Location (City/State/Country)"
      ),
    );


    final homeField = TextFormField(
      validator: (e) {
        if (e.isEmpty) {
          return 'Please enter where your family live';
        }

      },
      onSaved: (e) => home_town = e,
      style: style,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.location_on),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
          hintText: "Enter where your family live",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: "Where does your family live"
      ),
    );


    final sisField = TextFormField(
      validator: (e) {
        String patttern = r'(^(?:[+0]9)?[0-9]{1}$)';
        RegExp regExp = new RegExp(patttern);
        if (!regExp.hasMatch(e)) {
          return 'Please enter valid number of sisters';
        }

      },
      onSaved: (e) => num_sis = e,
      style: style,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.accessibility_sharp),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
          hintText: "Total Number of Sisters",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: "Number of Sisters"
      ),
    );


    final broField = TextFormField(
      validator: (e) {
        String patttern = r'(^(?:[+0]9)?[0-9]{1}$)';
        RegExp regExp = new RegExp(patttern);
        if (e.isEmpty) {
          return 'Please enter your Number Of Brothers';
        }
        else if (!regExp.hasMatch(e)) {
          return 'Please enter valid number';
        }

      },
      onSaved: (e) => num_bro = e,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.accessibility_outlined),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
        hintText: "Total Number Of Brothers",
        labelText: "Number Of Brothers",
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
    );



    final sisMarridField = TextFormField(
      validator: (e) {
        String patttern = r'(^(?:[+0]9)?[0-9]{1}$)';
        RegExp regExp = new RegExp(patttern);
        if (!regExp.hasMatch(e)) {
          return 'Please enter valid number of married sisters';
        }

      },
      onSaved: (e) => num_sis_marital = e,
      style: style,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.stacked_line_chart),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
          hintText: "No. of Married Sisters",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          labelText: "Number of Married Sisters"
      ),
    );


    final broMarridField = TextFormField(
      validator: (e) {
        String patttern = r'(^(?:[+0]9)?[0-9]{1}$)';
        RegExp regExp = new RegExp(patttern);
        if (e.isEmpty) {
          return 'Please enter your Number Of Married Brothers';
        }
        else if (!regExp.hasMatch(e)) {
          return 'Please enter valid married number';
        }

      },
      onSaved: (e) => num_bro_marital = e,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.stairs_outlined),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
        hintText: "No. Of Married Brothers",
        labelText: "Number Of Married Brothers",
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
    );

    final registerButton = Material(
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
              child: Text("Update",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );

    return new Scaffold(
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

                          SizedBox(height: 10.0),

                          Text("Update User Profile",
                              textAlign: TextAlign.center,
                              style: style.copyWith( fontSize: 22,
                                  color: Colors.cyan[900], fontWeight: FontWeight.bold)),

                          SizedBox(height: 35.0),

                          nativeField,

                          SizedBox(height: 25.0),

                          homeField,

                          SizedBox(height: 25.0),

                          fatherField,

                          SizedBox(height: 25.0),

                          motherField,

                          SizedBox(height: 25.0),

                          Text("Enter Your Siblings Detail",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.cyan[700], fontWeight: FontWeight.bold)),
                          SizedBox(height: 25.0),
                          broField,
                          SizedBox(height: 15.0),
                          sisField,

                          SizedBox(height: 25.0),

                          Text("Enter Your Siblings Marital Detail",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.cyan[700], fontWeight: FontWeight.bold)),
                          SizedBox(height: 25.0),
                          broMarridField,
                          SizedBox(height: 15.0),
                          sisMarridField,
                          SizedBox(height: 25.0),

                          registerButton,

                          Visibility(
                            visible: viewVisible,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Already updated this section ?"),

                                      FlatButton(
                                        child: Row(
                                          children: [
                                            Text("Skip This",
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                ))],

                                        ),
                                        onPressed: () {
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShowProfile()));
                                        }             ,

                                      )
                                    ],
                                  ),
                                ),
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
    );
  }
}

