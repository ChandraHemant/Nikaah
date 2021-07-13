import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:nikaah.com/Screens/ProfilePicUpdate.dart';
import 'package:http/http.dart' as http;
import 'package:nikaah.com/Screens/ProfileUpdate.dart';
import 'package:nikaah.com/Service/ApiService.dart';
import 'package:nikaah.com/main.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile>  {

  String images=null, images2=null, images3=null, images4=null, images5=null, u_id=null, names=null;
  bool visible = false;
  String u_percent="", u_address="", u_dist="", u_state="", u_email="", u_dob="", u_m_tongue="", u_community="", u_gender="", u_marital_status="", u_height="", u_family_loc="", u_edu_quali="", u_clg_university="", u_occupation="", u_work_comp_type="", u_comp_org_name="", u_an_income="", u_native_place="", u_father_status="", u_mother_status="", u_sibling_brother="", u_sibling_sister="", u_marrid_brother="", u_marrid_sister="";
  double points=0.0;

  enableFunc() {
    setState(() {
      if(visible==false) {
        visible = true;
      }else{
        visible=false;
      }
    });
    profileDetail();
  }

  profileDetail() async {
    final response = await http.post(ApiService.BASE_URL+"User_ProfileDetail", body: {
      "u_id":u_id
    });
    final data = json.decode(response.body);
    setState(() {
      points = data['u_percent_point'];
      u_percent = data['u_percent']+"%";
      u_address = data['u_address'];
      u_an_income = data['u_an_income'];
      u_clg_university = data['u_clg_university'];
      u_community = data['u_community'];
      u_comp_org_name = data['u_comp_org_name'];
      u_dist = data['u_dist'];
      u_dob = data['u_dob'];
      u_edu_quali = data['u_edu_quali'];
      u_email = data['u_email'];
      u_family_loc = data['u_family_loc'];
      u_father_status = data['u_father_status'];
      u_gender = data['u_gender'];
      u_height = data['u_height'];
      u_m_tongue = data['u_m_tongue'];
      u_marital_status = data['u_marital_status'];
      u_marrid_brother = data['u_marrid_brother'];
      u_marrid_sister = data['u_marrid_sister'];
      u_mother_status = data['u_mother_status'];
      u_native_place = data['u_native_place'];
      u_occupation = data['u_occupation'];
      u_sibling_brother = data['u_sibling_brother'];
      u_sibling_sister = data['u_sibling_sister'];
      u_state = data['u_state'];
      u_work_comp_type = data['u_work_comp_type'];
      print(u_address);
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("mobile", null);
      preferences.setString("name", null);
      preferences.setString("email", null);
      preferences.setString("id", null);
      preferences.setString("otp", null);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MySignInPage(),
        ),
      );
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      u_id = preferences.getString("id");
      names = preferences.getString("name");
      images = preferences.getString("img");
      images2 = preferences.getString("img2");
      images3 = preferences.getString("img3");
      images4 = preferences.getString("img4");
      images5 = preferences.getString("img5");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
    profileDetail();
  }

  Future<List> getProfilePic() async {
    final response = await http.post(ApiService.BASE_URL+"User_ProfilePic", body: {
      "u_id":u_id
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF00838F),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/ban.jpg"
                          ),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    child: Container(
                      alignment: Alignment(0.0,2.5),
                      child: CircleAvatar(
                        backgroundImage: (images == null||images == ""||images == " ") ? AssetImage("assets/images/avtar.png"):NetworkImage(ApiService.BASE_URL+images),
                        radius: 60.0,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 60,
                ),

                Text(
                  names,
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        u_address,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(", ",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        u_dist,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(", ",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        u_state,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        u_occupation,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(" at ",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        u_comp_org_name,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          constraints: BoxConstraints.expand(height: 225),
                          child: FutureBuilder<List>(
                            future: getProfilePic(),
                            // ignore: missing_return
                            builder: (ctx, ss) {
                              if (ss.hasError) {
                                print('error');
                              }
                              if (ss.hasData) {
                                return ImageSlider(list: ss.data);
                              } else {
                                return Center(
                                  child: const CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePicUpdate())),
                          child: Card(
                              color: Colors.amber,
                              margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                              elevation: 5.0,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12,horizontal: 30),
                                  child: Text("Update Profile Pic",style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.w300
                                  ),))
                          ),
                        ),CircularPercentIndicator(
                          radius: 130.0,
                          animation: true,
                          animationDuration: 1200,
                          lineWidth: 15.0,
                          percent: points,
                          center: new Text(
                            u_percent,
                            style:
                            new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          footer: new Text(
                            "Profile Updated",
                            style:
                            new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                          ),
                          circularStrokeCap: CircularStrokeCap.butt,
                          backgroundColor: Colors.yellow,
                          progressColor: Colors.cyan,
                        ),
                        SizedBox(
                          height: 25,
                        ),
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
                                "Update Profile",
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
                        SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: visible,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Email: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_email,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Date of Birth: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_dob,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Mother Tongue: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_m_tongue,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Community: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_community,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Gender: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_gender,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Height: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_height,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Marital Status: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_marital_status,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Educational Qualification: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_edu_quali,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("College/University Name: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_clg_university,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Your Occupation: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_occupation,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Currently Working Company: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_work_comp_type,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Organization Name: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_comp_org_name,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Annual Income: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_an_income,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Family Live Address: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_family_loc,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Native Place: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_native_place,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Father's Status: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_father_status,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Mother's Status: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_mother_status,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("No. Of Brothers: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_sibling_brother,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("No. of Sisters: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_sibling_sister,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("No. of Married Brothers: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_marrid_brother,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("No. of Married Sisters: ",style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    Text(u_marrid_sister,style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w400
                                    ),),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: (){
                        signOut();
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
                          constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
                          alignment: Alignment.center,
                          child: Text(
                            "Logout",
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
                        enableFunc();
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
                            "Profile Detail",
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
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        )
    );
  }

}

/*<--------Slider-------------->*/

// ignore: must_be_immutable
class ImageSlider extends StatelessWidget {
  List list;

  ImageSlider({this.list});

  @override
  Widget build(BuildContext context) {
    return new Swiper(
      autoplay: true,
      layout: SwiperLayout.STACK,
      itemWidth: 330.0,
      itemHeight: 300.0,
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (ctx, i) {
        return new Image.network(
          ApiService.BASE_URL + list[i]['u_img'],
          fit: BoxFit.fitWidth,
        );
      },
    );
  }
}
