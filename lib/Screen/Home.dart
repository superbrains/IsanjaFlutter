import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:isanja/Class/CategoryClass.dart';
import 'package:isanja/Service/CategoryService.dart';
import 'package:isanja/Service/RegistrationServ.dart';
import 'package:isanja/Service/TeamServ.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:math' as math;
import 'package:isanja/global.dart'as global;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:isanja/Screen/CurrentPlayer.dart';
import 'package:isanja/Screen/CurveScreen.dart';
import 'package:isanja/Screen/MarketPlace.dart';
import 'package:isanja/Screen/OtherPlayer.dart';
import 'package:isanja/Screen/Rules.dart';
import 'package:isanja/Screen/WordBank.dart';
import 'package:isanja/Screen/WordDatabase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController ycontroller;
  AnimationController bcontroller;
  AnimationController grcontroller;
  List<CategoryClass> filteredCategory = new List <CategoryClass>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController =  new TextEditingController();
   TextEditingController teamController =  new TextEditingController();
  Animation _animation;
  Animation _greenanimation;
   Animation _yellowanimation;
  Animation _blueanimation;
   bool formValid = true;
     ProgressDialog pr;
  Path _path;
  Path _pathyellow;
  Path _pathBlue;
  Path _pathGreen;
  double posx = 100.0;
  double posy = 100.0;
  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void onTapDown(BuildContext context, TapDownDetails details) {
    print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;
      bool formValid = true;
      print("x =" + posx.toString());
      print("y =" + posy.toString());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  getCategoryFromServer()async{
  var resp = await CategoryService.getAllCategory();
    filteredCategory = resp;
    global.categories = filteredCategory;
  
}
 Future<bool> simpledialog(str) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
            title: Text('Message'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  str,
                  style: TextStyle(fontSize: 10, color: Colors.green.shade600),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Home();
                    }));
                  },
                
                  child: Container(
                    height: 40.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.green.shade900,
                        color: Colors.green.shade600,
                        elevation: 7.0,
                        child: Center(
                          child: Text(
                            'OK',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'MontSerrat'),
                          ),
                        )),
                  ),
                ),
              ],
            )));
  }
  Future<bool> simpledialog2(str) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
            title: Text('Message'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  str,
                  style: TextStyle(fontSize: 10, color: Colors.green.shade600),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Home();
                    }));
                  },
                
                  child: Container(
                    height: 40.0,
                    child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.green.shade900,
                        color: Colors.green.shade600,
                        elevation: 7.0,
                        child: Center(
                          child: Text(
                            'OK',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'MontSerrat'),
                          ),
                        )),
                  ),
                ),
              ],
            )));
  }
  Path drawPath() {
    Size size = Size(200, 300);
    Path path = Path();
    path.moveTo(107, 87);

    path.quadraticBezierTo(104, 85, 72, 111);
    path.quadraticBezierTo(69, 129, 84, 140);
    path.quadraticBezierTo(94, 135, 176, 148);
    path.quadraticBezierTo(181, 158, 186, 189);
    path.quadraticBezierTo(165, 198, 140, 212);
    path.quadraticBezierTo(140, 205, 95, 198);
    path.quadraticBezierTo(98, 186, 81, 177);
    path.quadraticBezierTo(92, 193, 61, 185);
    path.quadraticBezierTo(52, 217, 66, 250);
    path.quadraticBezierTo(76, 260, 180, 266);
    path.quadraticBezierTo(197, 264, 218, 290);
    path.quadraticBezierTo(196, 309, 170, 304);
    path.quadraticBezierTo(123, 312, 126, 312);
    path.quadraticBezierTo(127, 324, 124, 335);
    path.quadraticBezierTo(141, 347, 152, 355);

    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);
    //    path.lineTo(70, 30);
    // path.lineTo(20, 70);

    //path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height / 2);
    return path;
  }

  Path drawYellowPath() {
    Size size = Size(100, 300);
    Path gpath = Path();

    gpath.moveTo(216, 160);
    gpath.quadraticBezierTo(205, 156, 161, 160);
    gpath.quadraticBezierTo(170, 161, 155, 185);
    gpath.quadraticBezierTo(147, 184, 172, 190);
    gpath.quadraticBezierTo(182, 188, 218, 205);
    gpath.quadraticBezierTo(216, 211, 217, 232);
    gpath.quadraticBezierTo(213, 229, 200, 248);
    gpath.quadraticBezierTo(192, 245, 183, 246);
    gpath.quadraticBezierTo(182, 260, 156, 276);
    gpath.quadraticBezierTo(151, 272, 120, 269);
    gpath.quadraticBezierTo(112, 253, 100, 264);
    gpath.quadraticBezierTo(92, 248, 76, 243);
    gpath.quadraticBezierTo(69, 247, 64, 249);
    gpath.quadraticBezierTo(60, 249, 54, 268); //herr y
    gpath.quadraticBezierTo(44, 265, 58, 296);
    gpath.quadraticBezierTo(49, 296, 61, 309);
    gpath.quadraticBezierTo(57, 301, 76, 321);
    gpath.quadraticBezierTo(70, 317, 107, 337);
    gpath.quadraticBezierTo(109, 325, 118, 338);
    gpath.quadraticBezierTo(130, 319, 126, 337);
    gpath.quadraticBezierTo(129, 332, 165, 333);
    gpath.quadraticBezierTo(162, 325, 188, 332);
    gpath.quadraticBezierTo(185, 325, 202, 340);
    gpath.quadraticBezierTo(210, 335, 218, 354);
    gpath.quadraticBezierTo(215, 333, 212, 341);
    gpath.quadraticBezierTo(210, 350, 220, 356);
    gpath.quadraticBezierTo(206, 368, 190, 377);
    gpath.quadraticBezierTo(182, 358, 164, 369);
    gpath.quadraticBezierTo(158, 368, 128, 370);
    gpath.quadraticBezierTo(116, 375, 113, 390);
    gpath.quadraticBezierTo(114, 392, 130, 403);
    gpath.quadraticBezierTo(132, 406, 158, 420);

    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);
    //    path.lineTo(70, 30);
    // path.lineTo(20, 70);

    //path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height / 2);
    return gpath;
  }

  Path drawBluePath() {
    Size size = Size(100, 300);
    Path bpath = Path();

    bpath.moveTo(299, 145);
    bpath.quadraticBezierTo(299, 145, 255, 159);
    bpath.quadraticBezierTo(245, 158, 235, 177);
    bpath.quadraticBezierTo(243, 189, 249, 210);
    bpath.quadraticBezierTo(242, 200, 258, 241);
    bpath.quadraticBezierTo(262, 245, 256, 254);
    bpath.quadraticBezierTo(244, 260, 224, 290);
    bpath.quadraticBezierTo(210, 281, 201, 300); //here
    bpath.quadraticBezierTo(187, 302, 133, 310);
    bpath.quadraticBezierTo(120, 301, 92, 283);
    bpath.quadraticBezierTo(80, 280, 58, 277);
    bpath.quadraticBezierTo(60, 249, 54, 268); //herr y
    bpath.quadraticBezierTo(44, 265, 58, 296);
    bpath.quadraticBezierTo(49, 296, 61, 309);
    bpath.quadraticBezierTo(57, 301, 76, 321);
    bpath.quadraticBezierTo(70, 317, 107, 337);
    bpath.quadraticBezierTo(109, 325, 118, 338);
    bpath.quadraticBezierTo(130, 319, 126, 337);
    bpath.quadraticBezierTo(129, 332, 165, 333);
    bpath.quadraticBezierTo(162, 325, 188, 332);
    bpath.quadraticBezierTo(185, 325, 202, 340);
    bpath.quadraticBezierTo(210, 335, 218, 354);
    bpath.quadraticBezierTo(215, 333, 212, 341);
    bpath.quadraticBezierTo(210, 350, 220, 356);
    bpath.quadraticBezierTo(206, 368, 190, 377);
    bpath.quadraticBezierTo(182, 358, 164, 369);
    bpath.quadraticBezierTo(158, 368, 128, 370);
    bpath.quadraticBezierTo(116, 375, 113, 390);
    bpath.quadraticBezierTo(114, 392, 130, 403);
    bpath.quadraticBezierTo(132, 406, 158, 420);

    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);
    //    path.lineTo(70, 30);
    // path.lineTo(20, 70);

    //path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height / 2);
    return bpath;
  }
 Path drawGreenPath() {
    Size size = Size(100, 300);
    Path grpath = Path();

    grpath.moveTo(366, 168);
     grpath.quadraticBezierTo(366, 168, 344, 205);
      grpath.quadraticBezierTo(344, 196, 322, 213);
       grpath.quadraticBezierTo(329, 213, 316, 242);
        grpath.quadraticBezierTo(305, 245, 290, 283);
       grpath.quadraticBezierTo(278, 293, 285, 293);
        grpath.quadraticBezierTo(289, 300, 261, 312);
           grpath.quadraticBezierTo(259, 308, 225, 318);
                grpath.quadraticBezierTo(212, 306, 208, 292);
   
    grpath.quadraticBezierTo(210, 281, 201, 300); //here
    grpath.quadraticBezierTo(187, 302, 133, 310);
    grpath.quadraticBezierTo(120, 301, 92, 283);
    grpath.quadraticBezierTo(80, 280, 58, 277);
    grpath.quadraticBezierTo(60, 249, 54, 268); //herr y
    grpath.quadraticBezierTo(44, 265, 58, 296);
    grpath.quadraticBezierTo(49, 296, 61, 309);
    grpath.quadraticBezierTo(57, 301, 76, 321);
    grpath.quadraticBezierTo(70, 317, 107, 337);
    grpath.quadraticBezierTo(109, 325, 118, 338);
    grpath.quadraticBezierTo(130, 319, 126, 337);
    grpath.quadraticBezierTo(129, 332, 165, 333);
    grpath.quadraticBezierTo(162, 325, 188, 332);
    grpath.quadraticBezierTo(185, 325, 202, 340);
    grpath.quadraticBezierTo(210, 335, 218, 354);
    grpath.quadraticBezierTo(215, 333, 212, 341);
    grpath.quadraticBezierTo(210, 350, 220, 356);
    grpath.quadraticBezierTo(206, 368, 190, 377);
    grpath.quadraticBezierTo(182, 358, 164, 369);
    grpath.quadraticBezierTo(158, 368, 128, 370);
    grpath.quadraticBezierTo(116, 375, 113, 390);
    grpath.quadraticBezierTo(114, 392, 130, 403);
    grpath.quadraticBezierTo(132, 406, 158, 420);

    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);
    //    path.lineTo(70, 30);
    // path.lineTo(20, 70);

    //path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height / 2);
    return grpath;
  }
  AnimationController _controller;
  Offset calculate(value) {
    PathMetrics pathMetrics = _path.computeMetrics();

    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value);
    return pos.position;
  }

  Offset yellowcalculate(value) {
    PathMetrics pathMetrics = _pathyellow.computeMetrics();

    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value);
    return pos.position;
  }

  Offset bluecalculate(value) {
    PathMetrics pathMetrics = _pathBlue.computeMetrics();

    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value);
    return pos.position;
  }
 Offset greencalculate(value) {
    PathMetrics pathMetrics = _pathGreen.computeMetrics();

    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value);
    return pos.position;
  }

  getLoginDetails() async {
    global.loginStatus = 'false';
    var ss = await SharedPreferences.getInstance();
    global.fullName = ss.getString('Fullname') == null ? "": global.fullName ;
    global.profileId = ss.getString('ProfileID') == null
        ? 0
        : int.parse(ss.getString('ProfileID'));
    global.loginStatus = ss.getString('LoginStatus');
    return ss;
  }


  @override
  void initState() {
    
    super.initState();
    getLoginDetails();
    getCategoryFromServer();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
    ycontroller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
         grcontroller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    bcontroller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    super.initState();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _yellowanimation = Tween(begin: 0.0, end: 1.0).animate(ycontroller);
    _blueanimation = Tween(begin: 0.0, end: 1.0).animate(bcontroller);
    _greenanimation = Tween(begin: 0.0, end: 1.0).animate(grcontroller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
    ycontroller.forward();
    bcontroller.forward();
    grcontroller.forward();
    _path = drawPath();
    _pathyellow = drawYellowPath();
    _pathBlue = drawBluePath();
    _pathGreen = drawGreenPath();

   




  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(
        message: 'Processing...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: Container(
            padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("ISANJA", style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.green.shade800,
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              _creteTeamDialog();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.notifications),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(children: <Widget>[
          Stack(children: <Widget>[
            Container(
              color: Colors.green.shade800,
              height: 200,
              // decoration: BoxDecoration(
              //   color: Colors.blue.shade900,
              //     image: DecorationImage(
              //         fit: BoxFit.cover,
              //         image: AssetImage(
              //             'assets/images/appBar.png'))),
            ),
            Positioned(
              top: 50,
              left: 30,
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {},
                        child: Container(
                          width: 80.0,
                          height: 80.0,
                          child: CachedNetworkImage(
                              imageUrl:
                                  "https://gillow.ng/app/api/Profiles/GetProfileImage?ProfileID=" +
                                      127.toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                              Colors.blue, BlendMode.dstIn),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100.0)),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 20.0,
                                              color: Colors.black),
                                        ]),
                                  ),
                              placeholder: (context, url) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        child: CircularProgressIndicator(),
                                        height: 50,
                                        width: 50,
                                      ),
                                    ],
                                  ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error)
                              //  Image.asset("assets/images/icon.png"),
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("John Doe",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: "BalooPaaji2"))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("07011223344",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: "BalooPaaji2"))
                      ],
                    ),
                  ])
                ],
              ),
            ),
          ]),
          SizedBox(height: 15),
          CustomListTile(
              Icons.person,
              "My Profile",
              () => {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    // //  return MyProfile();
                    // }))
                  }),
          CustomListTile(
              Icons.person,
              "Host New Game",
              () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return OtherPlayer();
                    }))
                  }),
          CustomListTile(
              Icons.person,
              "Join Game",
              () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CurrentPlayer();
                    }))
                  }),
          CustomListTile(
              Icons.person,
              "Categories",
              () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return WordBank();
                    }))
                  }),
          CustomListTile(
              Icons.person,
              "Rules and regulation",
              () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Rules();
                    }))
                  }),
          CustomListTile(
              Icons.person,
              "Market Place",
              () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MarketPlace();
                    }))
                  }),
          CustomListTile(
              Icons.person,
              "Word Database",
              () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return WordDatabase();
                    }))
                  }),
          CustomListTile(
              Icons.person,
              "Sample",
              () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SampleAnimation();
                    }))
                  }),
        ]),
      ),
      body: GestureDetector(
        onTapDown: (TapDownDetails details) => onTapDown(context, details),
        child: Column(children: <Widget>[
          Stack(
            children: <Widget>[
              Container(child: Image.asset("assets/board.png")),
              Positioned(
                top: 0,
                child: CustomPaint(
                  painter: PathPainter(_path),
                ),
              ),
              Positioned(
                top: -65,
                child: CustomPaint(
                  painter: PathPainter(_pathyellow),
                ),
              ),
              Positioned(
                top: -65,
                child: CustomPaint(
                  painter: PathPainter(_pathBlue),
                ),
              ),
               Positioned(
                top: -65,
                child: CustomPaint(
                  painter: PathPainter(_pathGreen),
                ),
              ),
              Positioned(
                top: yellowcalculate(_yellowanimation.value).dy - 65,
                left: yellowcalculate(_yellowanimation.value).dx,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10)),
                  width: 10,
                  height: 10,
                ),
              ),
              Positioned(
                top: bluecalculate(_blueanimation.value).dy - 65,
                left: bluecalculate(_blueanimation.value).dx,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  width: 10,
                  height: 10,
                ),
              ),
                Positioned(
                top: greencalculate(_greenanimation.value).dy - 75,
                left: greencalculate(_greenanimation.value).dx,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green.shade800,
                      borderRadius: BorderRadius.circular(10)),
                  width: 10,
                  height: 10,
                ),
              ),
              Positioned(
                top: calculate(_animation.value).dy,
                left: calculate(_animation.value).dx,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  width: 10,
                  height: 10,
                ),
              ),
              Positioned(
                  left: 310,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "ISANJA POINT",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "23",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ],
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Timer",
                  style: TextStyle(color: Colors.green.shade800, fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.center,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: AnimatedBuilder(
                              animation: controller,
                              builder: (BuildContext context, Widget child) {
                                return CustomPaint(
                                    painter: TimerPainter(
                                        animation: controller,
                                        backgroundColor: Colors.green,
                                        color: Colors.grey));
                              },
                            ),
                          ),
                          Align(
                            alignment: FractionalOffset.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                AnimatedBuilder(
                                    animation: controller,
                                    builder:
                                        (BuildContext context, Widget child) {
                                      return Text(
                                        timerString,
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 20),
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(children: <Widget>[
                Text(
                  "sssssssssss, ",
                  style: TextStyle(color: Colors.white),
                )
              ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FloatingActionButton(
                          child: AnimatedBuilder(
                            animation: controller,
                            builder: (BuildContext context, Widget child) {
                              return Icon(controller.isAnimating
                                  ? Icons.pause
                                  : Icons.play_arrow);

                              // Icon(isPlaying
                              // ? Icons.pause
                              // : Icons.play_arrow);
                            },
                          ),
                          onPressed: () {
                            // setState(() => isPlaying = !isPlaying);

                            if (controller.isAnimating) {
                              controller.stop(canceled: true);
                            } else {
                              controller.reverse(
                                  from: controller.value == 0.0
                                      ? 1.0
                                      : controller.value);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: (){
                 _showLoginDialog();
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Container(
                    // height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 0.5)),
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/GameCard.JPG")
                            //Text("Game Card", style: TextStyle(color:Colors.white),),
                            ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.only(right:8.0),
              //   child: Container(
              //     height:200,

              //      decoration: BoxDecoration(
              //             border: Border.all(
              //           width: 0.5,
              //         )),
              //       child: Text("Game Card"),
              //   )
              // ),
            ],
          )
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green.shade800,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          height: 200,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //first column

                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 40),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "Current Player",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: <Widget>[
                              Text(
                                "John Doe",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: <Widget>[
                              Text(
                                "Team",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: <Widget>[
                              Text(
                                "Team Blue",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )
                        ]),
                  ),
                  //second column
                  SizedBox(width: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 40),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "Wild Card",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "1",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: <Widget>[
                              Text(
                                "Game Card",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "22",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )
                        ]),
                  ),
                  //3rd column
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 70.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Next Player:",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "John Doe",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "(Yellow team)",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
   _showLoginDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text("Create Account",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BalooPaaji2',
                      color: Colors.green.shade600)),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.green.shade600
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          content: Stack(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      // height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("Fullname"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 15.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Fill Required Space";
                                  }
                                  return null;
                                },
                                // keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                style: new TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                controller: nameController,
                                decoration: InputDecoration(
                                  hintText: 'Full Name',
                                  contentPadding: EdgeInsets.fromLTRB(
                                      8.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                              ),
                            ),
                           
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    formValid = true;
                                  });
                                 
                                  pr.show();
                                 
                                  // call api
                                  var res = await RegistrationService.postProfile(nameController.text);
                                  if(res >1){
                                    res = global.profileId;
                                     SharedPreferences.getInstance()
                                            .then((ss) {
                                          ss.setString(
                                              'Fullname',
                                              nameController.text );
                                          ss.setString('ProfileID',
                                              global.profileId.toString());
                                          ss.setString("LoginStatus", "true");
                                         
                                        }); pr.hide().then((isHidden) {
                                          return simpledialog(
                                              "Registration Successful");
                                        });
                                  }
                               else{
                                  pr.hide();
                                 simpledialog2("Error");
                               }
                                }
                              },
                              child: Center(
                                child: Container(
                                  width: 180,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade900,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Center(
                                      child: Text("Sign Up",
                                          style: TextStyle(
                                              color: Colors.white))),
                                ),
                              ),
                            )
                          ],
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
    );

  }
   _creteTeamDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text("Create Team",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'BalooPaaji2',
                      color: Colors.green.shade600)),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.green.shade600
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          content: Stack(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      // height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("Team Name"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 15.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Fill Required Space";
                                  }
                                  return null;
                                },
                                // keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                style: new TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                controller: nameController,
                                decoration: InputDecoration(
                                  hintText: 'Team Name',
                                  contentPadding: EdgeInsets.fromLTRB(
                                      8.0, 10.0, 20.0, 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                              ),
                            ),
                           
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    formValid = true;
                                  });
                                 
                                  pr.show();
                                 
                                  // call api
                                  var res = await TeamService.postTeam(teamController.text);
                                  if(res >1){
                                    pr.hide();
                                      return simpledialog(
                                  "Team  Created");
                                       
                                  }
                               else{
                                  pr.hide();
                                 simpledialog2("Error");
                               }
                                }
                              },
                              child: Center(
                                child: Container(
                                  width: 180,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade900,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Center(
                                      child: Text("Sign Up",
                                          style: TextStyle(
                                              color: Colors.white))),
                                ),
                              ),
                            )
                          ],
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
    );
    
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, bottom: 6),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
        ),
        child: InkWell(
          splashColor: Colors.green.shade900,
          onTap: onTap,
          child: Container(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon, color: Colors.green),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: Text(
                        text,
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Monseratti',
                            color: Colors.green.shade800),
                      ),
                    )
                  ],
                ),
                Icon(
                  Icons.arrow_right,
                  color: Colors.green,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}

class PathPainter extends CustomPainter {
  Path path;
  Path gpath;

  PathPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.redAccent.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawPath(this.path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
