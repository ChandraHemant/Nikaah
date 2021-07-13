import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nikaah.com/Screens/CustomAppBar.dart';
import 'package:nikaah.com/Screens/MyProfile.dart';
import 'package:nikaah.com/Screens/ProfileUpdate.dart';
import 'package:http/http.dart' as http;
import 'package:nikaah.com/Service/ApiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowProfile extends StatefulWidget {

  @override
  _ShowProfileState createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile>  {
  List<String> welcomeImages = [
    "./uploads/Profiles/scaled_image_picker5689072771682467750.jpg",
    "./uploads/Profiles/scaled_image_picker602328241479530833.jpg",
    "./uploads/Profiles/scaled_image_picker7568969653172066163.jpg",
    "./uploads/Profiles/scaled_image_picker1716859342075237463.jpg",
    "./uploads/Profiles/scaled_image_picker4092964641671648707.jpg",
  ];

  List<String> names = [
    "Hemant Chandra",
    "Hemant",
    "Hemant Kumar",
    "H. K. C.",
    "HTKC",
  ];

  List<String> ages = [
    "age: 24Yr",
    "age: 24Yr",
    "age: 24Yr",
    "age: 24Yr",
    "age: 24Yr",
  ];

  String u_id=null;

  getPref() async {
    getProfile();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      u_id = preferences.getString("id");
    });
  }

  Future<List> getProfile() async {
    final response = await http.post(ApiService.BASE_URL+"User_Profile", body: {
      "u_id":u_id
    });
    var data = json.decode(response.body);
/*    setState(() {
      welcomeImages = data;
    });*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
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
  Widget build(BuildContext context) {
    //it will helps to return the size of the screen
    Size size = MediaQuery.of(context).size;
    CardController controller; //Use this to trigger swap.
    return new WillPopScope(
        onWillPop: _onBackPressed,
        child: new Scaffold(
        backgroundColor: const Color(0xFF00838F),
        appBar: CustomAppBar(
          height: 70,
          child: Container(
            decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
                image: new DecorationImage(
                  image: new AssetImage('assets/images/ban.jpg'),
                  fit: BoxFit.fitWidth,
                )
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [

              Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child:TinderSwapCard(
                    orientation: AmassOrientation.BOTTOM,
                    totalNum: welcomeImages.length,
                    stackNum: 4,
                    swipeEdge: 4.0,
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                    maxHeight: MediaQuery.of(context).size.width * 0.9,
                    minWidth: MediaQuery.of(context).size.width * 0.8,
                    minHeight: MediaQuery.of(context).size.width * 0.8,
                    cardBuilder: (context, index) => GridTile(
                      child: Card(
                        elevation: 6.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child:Image.network(ApiService.BASE_URL+'${welcomeImages[index]}'),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8.0,0,4.0,4),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('${names[index]}',
                                          style: TextStyle(fontWeight: FontWeight.bold,
                                              fontSize: 26,color: Colors.white,shadows: [ Shadow(blurRadius: 1.0,color: Colors.black,offset: Offset(0.6,0.6))]),),
                                        Padding(
                                          padding: const EdgeInsets.only(left:8.0,top: 10.0),
                                          child: Text('${ages[index]}',
                                            style: TextStyle(fontSize: 15,
                                                color: Colors.white,
                                                shadows: [ Shadow(blurRadius: 1.0,color: Colors.black,offset: Offset(0.6,0.6))]),),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(right:38.0),
                                          child: Container(
                                            width: size.width*0.18,
                                            height: size.width*0.18,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.cyan),
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: AssetImage("assets/images/cl.png"), // picked file
                                                    fit: BoxFit.fill)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:38.0),
                                          child: Container(
                                            width: size.width*0.18,
                                            height: size.width*0.18,
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.cyan),
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: AssetImage("assets/images/wp.png"), // picked file
                                                    fit: BoxFit.fill)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),//image,
                    ),
                    cardController: controller = CardController(),
                    swipeUpdateCallback:
                        (DragUpdateDetails details, Alignment align){
                      if(align.x < 0){
                        // print(details);
                      }else if (align.x > 0){
                        print('id: 1');
                        loginSuccessToast("UserId: 1");
                      }
                    },
                    swipeCompleteCallback:
                        (CardSwipeOrientation orientaion , int index){

                    },
                  )),

              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileUpdate1()));
                    },
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.pink,Colors.redAccent]
                        ),
                        borderRadius: BorderRadius.circular(30.0),

                      ),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 120.0,maxHeight: 40.0,),
                        alignment: Alignment.center,
                        child: Text(
                          "Profile Update",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile()));
                    },
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.pink,Colors.redAccent]
                        ),
                        borderRadius: BorderRadius.circular(80.0),

                      ),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
                        alignment: Alignment.center,
                        child: Text(
                          "My Profile",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w300
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      )
    );

  }

  loginSuccessToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }
}