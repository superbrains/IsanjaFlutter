import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:isanja/Screen/CurrentPlayer.dart';

class SampleAnimation extends StatefulWidget{

  SampleAnimation();

  @override
  State<StatefulWidget> createState() {
    return SampleAnimationState();
  }
}

class SampleAnimationState extends State<SampleAnimation> with TickerProviderStateMixin {

  AnimationController _controller;
  Animation _animation;
  Path _path;
  double posx = 100.0;
  double posy = 100.0;
   String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
AnimationController controller;
  void onTapDown(BuildContext context, TapDownDetails details) {
    print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      posx = localOffset.dx;
      posy = localOffset.dy;

      print("x ="+ posx.toString());
       print("y ="+ posy.toString());
    });
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
     
    );
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 5000));
    super.initState();
    _animation = Tween(begin: 0.0,end: 1.0).animate(_controller)
      ..addListener((){
        setState(() {
        });
      });
    _controller.forward();
    _path  = drawPath();
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTapDown: (TapDownDetails details) => onTapDown(context, details),
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                 Container(
                      child: 
                    Image.asset("assets/board.png")
                    
                    ),
                Positioned(
                 // top: 0,
                  

                  child: CustomPaint(
                    painter: PathPainter(_path),
                  ),
                ),

                
                Positioned(
                  top: calculate(_animation.value).dy,
                  left: calculate(_animation.value).dx,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    width: 10,
                      height: 10,
                  ),
                ),
              ],
            ),

 Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Timer",style: TextStyle(color: Colors.green.shade800, fontSize: 20),),
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
                                      color: Colors.grey
                                    ));
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
                                        builder: (BuildContext context, Widget child) {
                                          return Text(
                                            timerString,
                                            style: TextStyle(color:Colors.green, fontSize: 20),

                                          
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
                      Column(children:<Widget>[
Text("sssssssssss, ", style: TextStyle(color:Colors.white),)
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
                    
                      Padding(
                        padding: const EdgeInsets.only(left:0.0),
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





          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Path drawPath(){
    Size size = Size(300,300);
    Path path = Path();
   // path.moveTo(20, size.height / 2);

   // path.moveTo(0,20);
    
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


  Offset calculate(value) {
    PathMetrics pathMetrics = _path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value);
    return pos.position;
  }

}


class PathPainter extends CustomPainter {

  Path path;

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