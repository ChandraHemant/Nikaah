import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:nikaah.com/Screens/ProfileUpdate.dart';
import 'package:nikaah.com/Screens/ShowProfile.dart';
import 'package:nikaah.com/Service/ApiService.dart';
import 'package:nikaah.com/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePicUpdate extends StatefulWidget {

  @override
  _ProfilePicUpdateState createState() => _ProfilePicUpdateState();
}

class _ProfilePicUpdateState extends State<ProfilePicUpdate> {

  File _image=null,_image2=null,_image3=null,_image4=null,_image5=null;
  String images=null, images2=null, images3=null, images4=null, images5=null;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);
  bool visible = false;
  String u_id;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      u_id = preferences.getString("id");
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
  }

  final picker = ImagePicker();

  _imgFromCamera() async {
    var pickedImage = await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  _imgFromGallery() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  _imgFromCamera2() async {
    var pickedImage2 = await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image2 = File(pickedImage2.path);
    });
  }

  _imgFromGallery2() async {
    var pickedImage2 = await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image2 = File(pickedImage2.path);
    });
  }

  _imgFromCamera3() async {
    var pickedImage3 = await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image3 = File(pickedImage3.path);
    });
  }

  _imgFromGallery3() async {
    var pickedImage3 = await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image3 = File(pickedImage3.path);
    });
  }

  _imgFromCamera4() async {
    var pickedImage4 = await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image4 = File(pickedImage4.path);
    });
  }

  _imgFromGallery4() async {
    var pickedImage4 = await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image4 = File(pickedImage4.path);
    });
  }

  _imgFromCamera5() async {
    var pickedImage5 = await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image5 = File(pickedImage5.path);
    });
  }

  _imgFromGallery5() async {
    var pickedImage5 = await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image5 = File(pickedImage5.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  void _showPicker2(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery2();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera2();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  void _showPicker3(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery3();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera3();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  void _showPicker4(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery4();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera4();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  void _showPicker5(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery5();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera5();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  loadProgress() {
    setState(() {
      visible = true;
    });
    uploadImage();
  }


  selectionWarningToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.amberAccent,
        textColor: Colors.white);
  }

  uploadSuccessToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  uploadFailedToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }


  Future uploadImage()async{
    final uri = Uri.parse(ApiService.BASE_URL+"Profile_image_upload");
    var request = http.MultipartRequest('POST',uri);
    request.fields['u_id'] = u_id;
    if(_image==null && _image2==null && _image3==null && _image4==null && _image5==null) {
      setState(() {
        visible = false;
      });
      selectionWarningToast("Please choose atleast one image");
    }else{
      if(_image!=null){
        var pic = await http.MultipartFile.fromPath("image", _image.path);
        request.files.add(pic);
        print(_image.path);
      }
      if(_image2!=null){
        var pic2 = await http.MultipartFile.fromPath("image2", _image2.path);
        request.files.add(pic2);
        print(_image2.path);
      }
      if(_image3!=null){
        var pic3 = await http.MultipartFile.fromPath("image3", _image3.path);
        request.files.add(pic3);
        print(_image3.path);
      }
      if(_image4!=null){
        var pic4 = await http.MultipartFile.fromPath("image4", _image4.path);
        request.files.add(pic4);
        print(_image4.path);
      }
      if(_image5!=null){
        var pic5 = await http.MultipartFile.fromPath("image5", _image5.path);
        request.files.add(pic5);
        print(_image5.path);
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        final responses = await http.post(ApiService.BASE_URL+"My_ProfilePic", body: {
          "u_id":u_id
        });

        final data = jsonDecode(responses.body);
        bool value = data['error'];
        images = data['u_img'];
        images2 = data['u_img2'];
        images3 = data['u_img3'];
        images4 = data['u_img4'];
        images5 = data['u_img5'];
        if(!value) {
          setState(() {
            savePref(images, images2, images3, images4, images5);
            visible = false;
          });
        }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShowProfile()));
        uploadSuccessToast("Sccessfully Uploaded!");
        print('Image Uploded');
      }else{
        setState(() {
          visible = false;
        });
        uploadFailedToast("Something went wrong!");
        print('Image Not Uploded');
      }
    }

  }


  savePref(String img, String img2, String img3, String img4, String img5) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("img", img);
      preferences.setString("img2", img2);
      preferences.setString("img3", img3);
      preferences.setString("img4", img4);
      preferences.setString("img5", img5);
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
  Widget build(BuildContext context) {
    //it will helps to return the size of the screen
    Size size = MediaQuery.of(context).size;
    final image = Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: size.width*0.42,
                  height: size.width*0.42,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.cyan),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: _image == null //profilePhoto which is File object
                              ?  ( (images == null||images == ""||images == " ") ? AssetImage("assets/images/avtar.png"):NetworkImage(ApiService.BASE_URL+images))
                              : FileImage(_image), // picked file
                          fit: BoxFit.fill)),
                ),
                Text("Primary Pic",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.blueGrey, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 12, bottom: 12, right: 10),
            child: Align(
              alignment: Alignment.center,
              child: Container(

                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                    //    choiceImage();
                  },
                  child: Icon(
                    LineAwesomeIcons.retro_camera,
                    color: Colors.amber,
                    size: 35,
                  ),
                ),
              ),
            ),
          ),
        ]
    );

    final image2 = Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: size.width*0.42,
                  height: size.width*0.42,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.cyan),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: _image2 == null //profilePhoto which is File object
                              ?   (  (images2 == null||images2 == ""||images2 == " ")  ? AssetImage("assets/images/avtar.png"):NetworkImage(ApiService.BASE_URL+images2))
                              : FileImage(_image2), // picked file
                          fit: BoxFit.fill)),
                ),
                Text("Choose Pic 2",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.blueGrey, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 12, bottom: 12, right: 10),
            child: Align(
              alignment: Alignment.center,
              child: Container(

                child: GestureDetector(
                  onTap: () {
                    _showPicker2(context);
                    //    choiceImage();
                  },
                  child: Icon(
                    LineAwesomeIcons.retro_camera,
                    color: Colors.amber,
                    size: 35,
                  ),
                ),
              ),
            ),
          ),
        ]
    );

    final image3 = Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: size.width*0.25,
                  height: size.width*0.25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.cyan),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: _image3 == null //profilePhoto which is File object
                              ?   (  (images3 == null||images3 == ""||images3 == " ")  ? AssetImage("assets/images/avtar.png"):NetworkImage(ApiService.BASE_URL+images3))
                              : FileImage(_image3), // picked file
                          fit: BoxFit.fill)),
                ),
                Text("Choose Pic 3",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.blueGrey, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 5, top: 12, bottom: 12, right: 5),
            child: Align(
              alignment: Alignment.center,
              child: Container(

                child: GestureDetector(
                  onTap: () {
                    _showPicker3(context);
                    //    choiceImage();
                  },
                  child: Icon(
                    LineAwesomeIcons.retro_camera,
                    color: Colors.amber,
                    size: 35,
                  ),
                ),
              ),
            ),
          ),
        ]
    );

    final image4 = Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: size.width*0.25,
                  height: size.width*0.25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.cyan),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: _image4 == null //profilePhoto which is File object
                              ?   (  (images4 == null||images4 == ""||images4 == " ")  ? AssetImage("assets/images/avtar.png"):NetworkImage(ApiService.BASE_URL+images4))
                              : FileImage(_image4), // picked file
                          fit: BoxFit.fill)),
                ),
                Text("Choose Pic 4",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.blueGrey, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 5, top: 12, bottom: 12, right: 5),
            child: Align(
              alignment: Alignment.center,
              child: Container(

                child: GestureDetector(
                  onTap: () {
                    _showPicker4(context);
                    //    choiceImage();
                  },
                  child: Icon(
                    LineAwesomeIcons.retro_camera,
                    color: Colors.amber,
                    size: 35,
                  ),
                ),
              ),
            ),
          ),
        ]
    );


    final image5 = Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: size.width*0.25,
                  height: size.width*0.25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.cyan),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: _image5 == null //profilePhoto which is File object
                              ?   (  (images5 == null||images5 == ""||images5 == " ")  ? AssetImage("assets/images/avtar.png"):NetworkImage(ApiService.BASE_URL+images5))
                              : FileImage(_image5), // picked file
                          fit: BoxFit.fill)),
                ),
                Text("Choose Pic 5",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.blueGrey, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 5, top: 12, bottom: 12, right: 5),
            child: Align(
              alignment: Alignment.center,
              child: Container(

                child: GestureDetector(
                  onTap: () {
                    _showPicker5(context);
                    //    choiceImage();
                  },
                  child: Icon(
                    LineAwesomeIcons.retro_camera,
                    color: Colors.amber,
                    size: 35,
                  ),
                ),
              ),
            ),
          ),
        ]
    );


    final uploadButton = Material(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
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
                child: Text("UPLOAD",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
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
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Center(
                              child: Text("UPLOAD PROFILE PICTURE",
                                  textAlign: TextAlign.center,
                                  style: style.copyWith(fontSize: 22,
                                      color: Colors.blueGrey[700], fontWeight: FontWeight.bold)),
                            ),
                          ),

                          Row(
                            children: [
                              image,
                              image2,
                            ],
                          ),

                          Row(
                            children: [
                              image3,
                              image4,
                              image5,
                            ],
                          ),

                          uploadButton,
                        ],
                      )
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}

